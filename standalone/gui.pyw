import os
import traceback
from multiprocessing import freeze_support, set_start_method
from tkinter import *
from tkinter import messagebox, ttk
from tkinter.scrolledtext import ScrolledText

from mltd.models.setup import (check_database_version, cleanup, setup,
                               upgrade_database)
from mltd.servers import dns, proxy
from mltd.servers.config import config, version
from mltd.servers.dns import dns_port, get_lan_ips
from mltd.servers.logging import handler, logger
from mltd.servers.process import CustomProcess
from mltd.servers.proxy import proxy_port

LOG_PATH = 'mltd-relive.log'
LOG_TAIL_BYTES = 128 * 1024
LOG_POLL_MS = 250


class MLTDReliveGUI:

    def __init__(self):
        self.root = Tk()
        self.root.title(f'mltd-relive Standalone v{version}')
        self.root.resizable(True, True)
        self.root.minsize(860, 600)

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
        main_frame.rowconfigure(3, weight=1)

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
        options_frame.columnconfigure(1, weight=1)
        ttk.Label(options_frame, text='Game Client Language:').grid(
            column=0, row=0, rowspan=2, padx=(0, 8), sticky=E)
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

        ttk.Label(options_frame, text='Asset Remote URL:').grid(
            column=0, row=2, padx=(0, 8), pady=(8, 0), sticky=E)
        self.asset_remote_url = StringVar(value=config.asset_remote_url)
        self.asset_remote_entry = ttk.Entry(
            options_frame,
            textvariable=self.asset_remote_url,
            width=42,
        )
        self.asset_remote_entry.grid(
            column=1, row=2, pady=(8, 0), sticky=(W, E))
        self.asset_remote_entry.bind('<Return>', self.change_asset_remote_url)
        self.asset_remote_entry.bind('<FocusOut>', self.change_asset_remote_url)
        ttk.Label(
            options_frame,
            text='Leave blank to use the default Rainbow CDN. HTTPS only.',
            foreground='grey',
        ).grid(column=1, row=3, sticky=W)

        log_frame = ttk.Labelframe(main_frame, text='Server Log', padding=6)
        log_frame.grid(
            column=0, row=3, columnspan=2, pady=(10, 0),
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
        self._load_initial_log_tail()
        self.root.after(LOG_POLL_MS, self.update_log_view)

    @staticmethod
    def _log_identity_for(stat_result):
        return (
            stat_result.st_dev,
            stat_result.st_ino,
            getattr(stat_result, 'st_ctime_ns',
                    int(stat_result.st_ctime * 1_000_000_000)),
        )

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

    def _set_options_state(self, enabled):
        state = NORMAL if enabled else DISABLED
        self.zh_radio_button.config(state=state)
        self.ko_radio_button.config(state=state)
        self.asset_remote_entry.config(state=state)

    def _save_asset_remote_url(self, show_error=True):
        value = self.asset_remote_url.get().strip()
        try:
            config.asset_remote_url = value
        except ValueError as exc:
            self.asset_remote_url.set(config.asset_remote_url)
            if show_error:
                messagebox.showerror('Invalid Asset Remote URL', str(exc))
            return False
        self.asset_remote_url.set(config.asset_remote_url)
        return True

    def update_server_status(self):
        proxy_alive = getattr(self, 'proxy_process', None) is not None \
            and self.proxy_process.is_alive()
        dns_alive = getattr(self, 'dns_process', None) is not None \
            and self.dns_process.is_alive()

        if proxy_alive or dns_alive:
            if self.server_status != 'Stopping':
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
                    self.stop_server_button.configure(state=NORMAL)
                    self.progress_bar.stop()
                    self.progress_bar.grid_forget()
                    logger.info('Server started.')
            self.root.after(200, self.update_server_status)
            return

        if getattr(self, 'proxy_process', None) is not None:
            self.proxy_process.join()
        if getattr(self, 'dns_process', None) is not None:
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
            self._set_options_state(True)
            self.progress_bar.stop()
            self.progress_bar.grid_forget()
            logger.info('Server stopped.')

    def start_server(self):
        if not self._save_asset_remote_url():
            return

        self.server_status = 'Starting'
        if not os.path.isfile('mltd-relive.db'):
            self.reset_data()
            return
        upgrade_database()

        handler.doRollover()
        self.status_label.config(text='Starting Server...', foreground='black')
        logger.info('Starting server...')
        if config.asset_remote_url:
            logger.info(f'Asset remote URL: {config.asset_remote_url}')
        else:
            logger.info('Asset remote URL: default Rainbow CDN')

        self.start_server_button.config(state=DISABLED)
        self.start_server_button.grid_forget()
        self.stop_server_button.grid(column=1, row=0)
        self.stop_server_button.configure(state=NORMAL)
        self.reset_button.config(state=DISABLED)
        self._set_options_state(False)
        self.progress_bar.grid(column=0, row=1, sticky=(W, E))
        self.progress_bar.start()
        self.proxy_process = CustomProcess(target=proxy.start, daemon=True)
        self.proxy_process.start()
        self.dns_process = CustomProcess(target=dns.start, daemon=True)
        self.dns_process.start()
        self.root.after(200, self.update_server_status)

    def stop_server(self):
        if self.server_status == 'Stopping':
            return
        self.server_status = 'Stopping'
        self.status_label.config(text='Stopping Server...', foreground='black')
        logger.info('Stopping server...')
        self.stop_server_button.config(state=DISABLED)
        self.start_server_button.config(state=DISABLED)
        for process_name in ('proxy_process', 'dns_process'):
            process = getattr(self, process_name, None)
            if process is not None and process.is_alive():
                process.terminate()
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
        self._set_options_state(True)
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
        self._set_options_state(False)
        self.progress_bar.grid(column=0, row=1, sticky=(W, E))
        self.progress_bar.start()
        self.process = CustomProcess(target=setup)
        self.process.start()
        self.root.after(200, self.update_reset_data_progress)

    def change_language(self):
        language = self.language.get()
        config.language = language
        logger.info(f'Changed language to {language}.')

    def change_asset_remote_url(self, event=None):
        if self._save_asset_remote_url():
            value = config.asset_remote_url or 'default Rainbow CDN'
            logger.info(f'Changed asset remote URL to {value}.')


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
