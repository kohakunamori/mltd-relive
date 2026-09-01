import json
import os
import traceback
from multiprocessing import freeze_support, set_start_method
from tkinter import *
from tkinter import messagebox, ttk
from tkinter.scrolledtext import ScrolledText

from mltd.models.setup import (check_database_version, cleanup, setup,
                               upgrade_database)
from mltd.servers import dns, proxy
from mltd.servers.asset_prepare import progress_status_path
from mltd.servers.config import ASSET_MODES, config, version
from mltd.servers.dns import dns_port, get_lan_ips
from mltd.servers.logging import handler, logger
from mltd.servers.process import CustomProcess
from mltd.servers.proxy import proxy_port

LOG_PATH = 'mltd-relive.log'
LOG_TAIL_BYTES = 128 * 1024
LOG_POLL_MS = 250
ASSET_PROGRESS_POLL_MS = 250


class MLTDReliveGUI:

    def __init__(self):
        self.root = Tk()
        self.root.title(f'mltd-relive Standalone v{version}')
        self.root.resizable(True, True)
        self.root.minsize(760, 650)

        style = ttk.Style()
        style.configure('Green.TButton', foreground='green')
        style.map('Green.TButton', foreground=[('disabled', 'grey'),
                                               ('active', 'green')])
        style.configure('Red.TButton', foreground='red')
        style.map('Red.TButton', foreground=[('disabled', 'grey'),
                                             ('active', 'red')])

        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)

        main_frame = ttk.Frame(self.root, padding=10)
        main_frame.grid(sticky=(N, S, W, E))
        main_frame.columnconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        main_frame.rowconfigure(4, weight=1)

        status_frame = ttk.Frame(main_frame, padding=10)
        status_frame.grid(column=0, row=0, sticky=(W, E))
        self.server_status = 'Stopped'
        self.status_label = ttk.Label(
            status_frame, text=f'Server Status: {self.server_status}',
            font=(None, 14), foreground='red', width=20, anchor=CENTER)
        self.status_label.grid(column=0, row=0)
        self.progress_bar = ttk.Progressbar(status_frame, mode='indeterminate')

        button_frame = ttk.Frame(main_frame, padding=10)
        button_frame.grid(column=1, row=0, sticky=(W, E))
        self.start_server_button = ttk.Button(
            button_frame, text='Start Server', command=self.start_server,
            style='Green.TButton', width=20
        )
        self.start_server_button.grid(column=1, row=0)
        self.stop_server_button = ttk.Button(
            button_frame, text='Stop Server', command=self.stop_server,
            style='Red.TButton', width=20
        )
        self.reset_button = ttk.Button(
            button_frame, text='Reset Data', command=self.reset_data,
            width=20
        )
        self.reset_button.grid(column=1, row=1)

        info_frame = ttk.Labelframe(main_frame, text='Server Info', padding=10)
        info_frame.grid(column=0, row=2, sticky=(N, S, W, E))
        lan_ipv4, lan_ipv6 = get_lan_ips()
        if not lan_ipv4:
            lan_ipv4 = 'N/A'
        if not lan_ipv6:
            lan_ipv6 = 'N/A'
        ttk.Label(info_frame, text=f'IPv4: {lan_ipv4}').grid(
            column=0, row=0, padx=5, sticky=W)
        ttk.Label(info_frame, text=f'IPv6: {lan_ipv6}').grid(
            column=0, row=1, padx=5, sticky=W)
        ttk.Label(info_frame, text=f'DNS Port: {dns_port}').grid(
            column=1, row=0, padx=5, sticky=W)
        ttk.Label(info_frame, text=f'TLS/API Port: {proxy_port}').grid(
            column=1, row=1, padx=5, sticky=W)

        options_frame = ttk.Labelframe(main_frame, text='Options', padding=10)
        options_frame.grid(column=1, row=2, sticky=(N, S, W, E))
        ttk.Label(options_frame, text='Game Client Language:').grid(
            column=0, row=0, rowspan=2, sticky=E)
        self.language = StringVar()
        self.language.set(config['default']['language'])
        self.zh_radio_button = ttk.Radiobutton(
            options_frame, text='繁體中文', variable=self.language, value='zh',
            command=self.change_language
        )
        self.zh_radio_button.grid(column=1, row=0, sticky=W)
        self.ko_radio_button = ttk.Radiobutton(
            options_frame, text='한국어', variable=self.language, value='ko',
            command=self.change_language
        )
        self.ko_radio_button.grid(column=1, row=1, sticky=W)

        ttk.Label(options_frame, text='Asset Mode:').grid(
            column=0, row=2, sticky=E, pady=(6, 0))
        self.asset_mode = StringVar(value=config.asset_mode)
        self.asset_mode_combobox = ttk.Combobox(
            options_frame,
            textvariable=self.asset_mode,
            values=ASSET_MODES,
            state='readonly',
            width=10,
        )
        self.asset_mode_combobox.grid(
            column=1, row=2, sticky=W, pady=(6, 0))
        self.asset_mode_combobox.bind(
            '<<ComboboxSelected>>', self.change_asset_mode)

        asset_frame = ttk.Labelframe(
            main_frame, text='Asset Preparation', padding=8)
        asset_frame.grid(
            column=0, row=3, columnspan=2, pady=(10, 0),
            sticky=(W, E))
        asset_frame.columnconfigure(0, weight=1)

        self.asset_progress_label = ttk.Label(
            asset_frame, text='Asset status: idle')
        self.asset_progress_label.grid(column=0, row=0, sticky=W)
        self.asset_progress = ttk.Progressbar(
            asset_frame, mode='determinate', maximum=100, value=0)
        self.asset_progress.grid(
            column=0, row=1, pady=(5, 3), sticky=(W, E))
        self.asset_progress_details = ttk.Label(
            asset_frame, text='No strict local asset preparation in progress.')
        self.asset_progress_details.grid(column=0, row=2, sticky=W)

        log_frame = ttk.Labelframe(main_frame, text='Server Log', padding=6)
        log_frame.grid(
            column=0, row=4, columnspan=2, pady=(10, 0),
            sticky=(N, S, W, E))
        log_frame.columnconfigure(0, weight=1)
        log_frame.rowconfigure(1, weight=1)

        log_toolbar = ttk.Frame(log_frame)
        log_toolbar.grid(column=0, row=0, sticky=(W, E), pady=(0, 5))
        self.log_autoscroll = BooleanVar(value=True)
        ttk.Checkbutton(
            log_toolbar,
            text='Auto-scroll',
            variable=self.log_autoscroll,
        ).pack(side=LEFT)
        ttk.Button(
            log_toolbar,
            text='Clear View',
            command=self.clear_log_view,
        ).pack(side=RIGHT)

        self.log_view = ScrolledText(
            log_frame,
            height=18,
            width=100,
            wrap='none',
            state=DISABLED,
            font='TkFixedFont',
        )
        self.log_view.grid(column=0, row=1, sticky=(N, S, W, E))

        self._log_offset = 0
        self._log_identity = None
        self._asset_progress_mtime_ns = None
        self._load_initial_log_tail()
        self.root.after(LOG_POLL_MS, self.update_log_view)
        self.root.after(ASSET_PROGRESS_POLL_MS, self.update_asset_progress)

    @staticmethod
    def _log_identity_for(stat_result):
        return (
            stat_result.st_dev,
            stat_result.st_ino,
            getattr(stat_result, 'st_ctime_ns',
                    int(stat_result.st_ctime * 1_000_000_000)),
        )

    @staticmethod
    def _format_rate(rate_bps):
        rate = max(0.0, float(rate_bps or 0.0))
        if rate >= 1024 * 1024:
            return f'{rate / (1024 * 1024):.1f} MiB/s'
        if rate >= 1024:
            return f'{rate / 1024:.1f} KiB/s'
        return f'{rate:.0f} B/s'

    def _replace_log_text(self, text):
        self.log_view.configure(state=NORMAL)
        self.log_view.delete('1.0', END)
        if text:
            self.log_view.insert(END, text)
        self.log_view.configure(state=DISABLED)
        if self.log_autoscroll.get():
            self.log_view.see(END)

    def _append_log_text(self, text):
        if not text:
            return
        self.log_view.configure(state=NORMAL)
        self.log_view.insert(END, text)
        self.log_view.configure(state=DISABLED)
        if self.log_autoscroll.get():
            self.log_view.see(END)

    def _load_initial_log_tail(self):
        try:
            stat_result = os.stat(LOG_PATH)
            start = max(0, stat_result.st_size - LOG_TAIL_BYTES)
            with open(LOG_PATH, 'rb') as log_file:
                log_file.seek(start)
                data = log_file.read()
            if start:
                newline = data.find(b'\n')
                if newline >= 0:
                    data = data[newline + 1:]
            self._replace_log_text(data.decode('utf-8', errors='replace'))
            self._log_offset = stat_result.st_size
            self._log_identity = self._log_identity_for(stat_result)
        except FileNotFoundError:
            self._replace_log_text('')
            self._log_offset = 0
            self._log_identity = None
        except OSError as exc:
            self._replace_log_text(f'[GUI] Unable to read {LOG_PATH}: {exc}\n')
            self._log_offset = 0
            self._log_identity = None

    def update_log_view(self):
        try:
            stat_result = os.stat(LOG_PATH)
            identity = self._log_identity_for(stat_result)

            if self._log_identity is not None and identity != self._log_identity:
                self._append_log_text('\n--- log rotated ---\n')
                self._log_offset = 0
            elif stat_result.st_size < self._log_offset:
                self._append_log_text('\n--- log truncated ---\n')
                self._log_offset = 0

            self._log_identity = identity

            if stat_result.st_size > self._log_offset:
                with open(LOG_PATH, 'rb') as log_file:
                    log_file.seek(self._log_offset)
                    data = log_file.read()
                    self._log_offset = log_file.tell()
                self._append_log_text(data.decode('utf-8', errors='replace'))
        except FileNotFoundError:
            self._log_offset = 0
            self._log_identity = None
        except OSError as exc:
            self._append_log_text(f'\n[GUI] Unable to update log view: {exc}\n')
        finally:
            self.root.after(LOG_POLL_MS, self.update_log_view)

    def clear_log_view(self):
        self._replace_log_text('')

    def _reset_asset_progress(self, preparing=False):
        self._asset_progress_mtime_ns = None
        self.asset_progress.configure(value=0)
        self.asset_progress_label.configure(foreground='')
        if preparing:
            self.asset_progress_label.configure(
                text='Asset status: waiting for preparation...')
            self.asset_progress_details.configure(
                text='Reading manifest and checking the local cache.')
        else:
            self.asset_progress_label.configure(text='Asset status: idle')
            self.asset_progress_details.configure(
                text='No strict local asset preparation in progress.')

    def _render_asset_progress(self, status):
        phase = status.get('phase', '')
        language = status.get('language', config.language)
        platform = status.get('platform', '')
        scope = f'{language}-{platform}' if platform else language
        platform_index = int(status.get('platform_index', 0) or 0)
        platform_count = int(status.get('platform_count', 0) or 0)
        platform_suffix = (
            f' [{platform_index}/{platform_count}]'
            if platform_index and platform_count else ''
        )
        manifest_total = int(status.get('manifest_total', 0) or 0)
        cached = int(status.get('cached', 0) or 0)
        downloaded = int(status.get('downloaded', 0) or 0)
        failed = int(status.get('failed', 0) or 0)

        self.asset_progress_label.configure(foreground='')

        if phase == 'starting':
            self.asset_progress.configure(value=0)
            self.asset_progress_label.configure(
                text='Asset status: starting strict local preparation...')
            self.asset_progress_details.configure(
                text=f'Preparing {platform_count} platform(s).')
            return

        if phase == 'manifest':
            self.asset_progress.configure(value=0)
            self.asset_progress_label.configure(
                text=f'{scope}{platform_suffix}: fetching manifest...')
            self.asset_progress_details.configure(
                text='Checking the asset index before cache scanning.')
            return

        if phase == 'scan':
            self.asset_progress.configure(value=0)
            self.asset_progress_label.configure(
                text=f'{scope}{platform_suffix}: checking local cache...')
            self.asset_progress_details.configure(
                text=f'Manifest objects: {manifest_total:,}')
            return

        if phase == 'prefetch':
            pending_total = int(status.get('pending_total', 0) or 0)
            completed = int(status.get('completed', 0) or 0)
            ready = cached + downloaded
            percent = (
                ready * 100.0 / manifest_total if manifest_total else 0.0
            )
            self.asset_progress.configure(value=min(100.0, percent))
            self.asset_progress_label.configure(
                text=(
                    f'{scope}{platform_suffix}: {ready:,}/{manifest_total:,} '
                    f'ready ({percent:.1f}%)'
                )
            )
            self.asset_progress_details.configure(
                text=(
                    f'Cached {cached:,}  •  Downloaded {downloaded:,}  •  '
                    f'Failed {failed:,}  •  '
                    f'{self._format_rate(status.get("rate_bps", 0))}  •  '
                    f'Prefetch {completed:,}/{pending_total:,}'
                )
            )
            return

        if phase == 'verify':
            verify_completed = int(status.get('verify_completed', 0) or 0)
            percent = (
                verify_completed * 100.0 / manifest_total
                if manifest_total else 0.0
            )
            self.asset_progress.configure(value=min(100.0, percent))
            self.asset_progress_label.configure(
                text=(
                    f'{scope}{platform_suffix}: verifying '
                    f'{verify_completed:,}/{manifest_total:,} ({percent:.1f}%)'
                )
            )
            self.asset_progress_details.configure(
                text=(
                    f'Cached {cached:,}  •  Downloaded {downloaded:,}  •  '
                    f'Failed {failed:,}'
                )
            )
            return

        if phase == 'platform_complete':
            self.asset_progress.configure(value=100)
            self.asset_progress_label.configure(
                text=f'{scope}{platform_suffix}: complete')
            self.asset_progress_details.configure(
                text=(
                    f'{manifest_total:,} objects ready  •  Cached {cached:,}  •  '
                    f'Downloaded {downloaded:,}'
                )
            )
            return

        if phase == 'complete':
            self.asset_progress.configure(value=100)
            self.asset_progress_label.configure(
                text='Asset status: local assets ready', foreground='green')
            self.asset_progress_details.configure(
                text=f'Completed {platform_count} platform(s).')
            return

        if phase == 'error':
            self.asset_progress_label.configure(
                text=f'{scope}{platform_suffix}: asset preparation failed',
                foreground='red')
            self.asset_progress_details.configure(
                text=status.get('message', 'Unknown asset preparation error.'))

    def update_asset_progress(self):
        try:
            status_path = progress_status_path(config.asset_cache_root)
            stat_result = status_path.stat()
            mtime_ns = getattr(
                stat_result, 'st_mtime_ns',
                int(stat_result.st_mtime * 1_000_000_000),
            )
            if mtime_ns != self._asset_progress_mtime_ns:
                status = json.loads(status_path.read_text(encoding='utf-8'))
                self._asset_progress_mtime_ns = mtime_ns
                self._render_asset_progress(status)
        except FileNotFoundError:
            pass
        except (OSError, ValueError, TypeError) as exc:
            logger.debug(f'Unable to read asset progress status: {exc}')
        finally:
            self.root.after(
                ASSET_PROGRESS_POLL_MS, self.update_asset_progress)

    def update_server_status(self):
        if self.proxy_process.is_alive() or self.dns_process.is_alive():
            if self.proxy_process.exception:
                self.stop_server_on_error(self.proxy_process.exception)
                return
            elif self.dns_process.exception:
                self.stop_server_on_error(self.dns_process.exception)
                return
            if (self.server_status == 'Starting'
                    and self.proxy_process.is_ready()
                    and self.dns_process.is_ready()):
                self.server_status = 'Started'
                self.status_label.config(
                    text=f'Server Status: {self.server_status}',
                    foreground='green')
                self.start_server_button.grid_forget()
                self.stop_server_button.grid(column=1, row=0)
                self.stop_server_button.configure(state=NORMAL)
                self.progress_bar.stop()
                self.progress_bar.grid_forget()
                logger.info('Server started.')
            self.root.after(200, self.update_server_status)
            return
        self.proxy_process.join()
        self.dns_process.join()
        if self.server_status == 'Stopping':
            self.server_status = 'Stopped'
            self.status_label.config(
                text=f'Server Status: {self.server_status}',
                foreground='red')
            self.start_server_button.grid(column=1, row=0)
            self.stop_server_button.grid_forget()
            self.start_server_button.configure(state=NORMAL)
            self.reset_button.config(state=NORMAL)
            self.zh_radio_button.config(state=NORMAL)
            self.ko_radio_button.config(state=NORMAL)
            self.asset_mode_combobox.config(state='readonly')
            logger.info('Server stopped.')

    def start_server(self):
        self.server_status = 'Starting'
        if not os.path.isfile('mltd-relive.db'):
            self.reset_data()
            return
        upgrade_database()

        handler.doRollover()
        status = ('Preparing Local Assets...'
                  if config.asset_mode == 'local'
                  else 'Starting Server...')
        self.status_label.config(text=status, foreground='black')
        logger.info('Starting server...')
        if config.asset_mode == 'local':
            try:
                progress_status_path(config.asset_cache_root).unlink(
                    missing_ok=True)
            except OSError as exc:
                logger.debug(f'Unable to clear old asset progress status: {exc}')
            self._reset_asset_progress(preparing=True)
            logger.info(
                'Strict local mode pre-downloads all Android and iOS assets '
                'before the server becomes ready.'
            )
        else:
            self._reset_asset_progress(preparing=False)
            self.asset_progress_details.configure(
                text=f'Asset mode {config.asset_mode}: full prefetch is disabled.')
        self.start_server_button.config(state=DISABLED)
        self.reset_button.config(state=DISABLED)
        self.zh_radio_button.config(state=DISABLED)
        self.ko_radio_button.config(state=DISABLED)
        self.asset_mode_combobox.config(state=DISABLED)
        self.progress_bar.grid(column=0, row=1, sticky=(W, E))
        self.progress_bar.start()
        self.proxy_process = CustomProcess(target=proxy.start, daemon=True)
        self.proxy_process.start()
        self.dns_process = CustomProcess(target=dns.start, daemon=True)
        self.dns_process.start()
        self.root.after(200, self.update_server_status)

    def stop_server(self):
        self.server_status = 'Stopping'
        self.status_label.config(text='Stopping Server...',
                                 foreground='black')
        logger.info('Stopping server...')
        self.start_server_button.config(state=DISABLED)
        self.proxy_process.terminate()
        self.dns_process.terminate()
        self.root.after(200, self.update_server_status)

    def stop_server_on_error(self, message):
        logger.error(message)
        messagebox.showerror('Error', message)
        self.progress_bar.stop()
        self.progress_bar.grid_forget()
        self.stop_server()

    def update_reset_data_progress(self):
        if not self.process.is_ready():
            if self.process.exception:
                logger.error(self.process.exception)
                messagebox.showerror('Error', self.process.exception)
            self.root.after(200, self.update_reset_data_progress)
            return
        self.process.join()
        if self.server_status == 'Starting':
            self.start_server()
            return
        self.status_label.config(
            text=f'Server Status: {self.server_status}', foreground='red')
        self.start_server_button.config(state=NORMAL)
        self.reset_button.config(state=NORMAL)
        self.zh_radio_button.config(state=NORMAL)
        self.ko_radio_button.config(state=NORMAL)
        self.asset_mode_combobox.config(state='readonly')
        self.progress_bar.stop()
        self.progress_bar.grid_forget()

    def reset_data(self):
        if os.path.isfile('mltd-relive.db'):
            check_database_version()
            if not messagebox.askyesno(
                    title='Warning',
                    message='Database already exists. Reset all data?'):
                return
            cleanup()
            logger.info('Dropped all tables.')

        handler.doRollover()
        self.status_label.config(text='Initializing Data...',
                                 foreground='black')
        self.start_server_button.config(state=DISABLED)
        self.reset_button.config(state=DISABLED)
        self.zh_radio_button.config(state=DISABLED)
        self.ko_radio_button.config(state=DISABLED)
        self.asset_mode_combobox.config(state=DISABLED)
        self.progress_bar.grid(column=0, row=1, sticky=(W, E))
        self.progress_bar.start()
        self.process = CustomProcess(target=setup)
        self.process.start()
        self.root.after(200, self.update_reset_data_progress)

    def change_language(self):
        language = self.language.get()
        config.language = language
        logger.info(f'Changed language to {language}.')

    def change_asset_mode(self, event=None):
        mode = self.asset_mode.get()
        config.asset_mode = mode
        logger.info(f'Changed asset mode to {mode}.')
        if mode != 'local' and self.server_status == 'Stopped':
            self._reset_asset_progress(preparing=False)
            self.asset_progress_details.configure(
                text=f'Asset mode {mode}: full prefetch is disabled.')


def report_callback_exception(self, exc, val, tb):
    logger.error(traceback.format_exc())
    messagebox.showerror('Error', message=traceback.format_exc())


if __name__ == '__main__':
    freeze_support()
    set_start_method('spawn')

    Tk.report_callback_exception = report_callback_exception

    gui = MLTDReliveGUI()
    if os.path.isfile('mltd-relive.db'):
        gui.root.after_idle(gui.start_server)
    gui.root.mainloop()
