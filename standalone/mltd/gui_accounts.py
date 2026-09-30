from tkinter import BOTH, END, LEFT, RIGHT, X, StringVar, Toplevel
from tkinter import messagebox, simpledialog, ttk

from mltd.accounts import (
    DEFAULT_USERNAME,
    delete_account,
    list_accounts,
    register_account,
    set_account_enabled,
)


class UserManagementWindow:
    """Administrative UI for full-save and cloned standalone accounts."""

    def __init__(self, parent):
        self.window = Toplevel(parent)
        self.window.title('User Management')
        self.window.geometry('820x430')
        self.window.minsize(760, 380)
        self.window.transient(parent)

        outer = ttk.Frame(self.window, padding=10)
        outer.pack(fill=BOTH, expand=True)

        ttk.Label(
            outer,
            text=(
                'New users are full-save clones only. Blank/tutorial saves '
                'are not supported.'
            ),
        ).pack(fill=X, pady=(0, 8))

        columns = ('username', 'display_name', 'search_id', 'status', 'type')
        self.tree = ttk.Treeview(
            outer,
            columns=columns,
            show='headings',
            selectmode='browse',
            height=13,
        )
        headings = {
            'username': 'Username',
            'display_name': 'Display Name',
            'search_id': 'Search ID',
            'status': 'Status',
            'type': 'Type',
        }
        widths = {
            'username': 110,
            'display_name': 150,
            'search_id': 100,
            'status': 90,
            'type': 190,
        }
        for column in columns:
            self.tree.heading(column, text=headings[column])
            self.tree.column(column, width=widths[column], anchor='center')
        self.tree.pack(fill=BOTH, expand=True)
        self.tree.bind('<<TreeviewSelect>>', self._sync_button_state)
        self.tree.bind('<Double-1>', self._toggle_selected)

        toolbar = ttk.Frame(outer)
        toolbar.pack(fill=X, pady=(10, 0))

        self.add_button = ttk.Button(
            toolbar,
            text='Add Full-Save User',
            command=self.add_full_save_user,
        )
        self.add_button.pack(side=LEFT)

        self.enable_button = ttk.Button(
            toolbar,
            text='Enable',
            command=lambda: self.set_selected_enabled(True),
        )
        self.enable_button.pack(side=LEFT, padx=(8, 0))

        self.disable_button = ttk.Button(
            toolbar,
            text='Disable',
            command=lambda: self.set_selected_enabled(False),
        )
        self.disable_button.pack(side=LEFT, padx=(8, 0))

        self.delete_button = ttk.Button(
            toolbar,
            text='Delete User',
            command=self.delete_selected_user,
        )
        self.delete_button.pack(side=LEFT, padx=(8, 0))

        ttk.Button(
            toolbar,
            text='Refresh',
            command=self.refresh,
        ).pack(side=RIGHT)

        self.status_text = StringVar(value='')
        ttk.Label(outer, textvariable=self.status_text).pack(
            fill=X, pady=(8, 0)
        )

        self._accounts = {}
        self.refresh()

    def _selected_username(self):
        selection = self.tree.selection()
        if not selection:
            return None
        values = self.tree.item(selection[0], 'values')
        return values[0] if values else None

    def _selected_account(self):
        username = self._selected_username()
        if username is None:
            return None
        return self._accounts.get(username)

    def _sync_button_state(self, event=None):
        account = self._selected_account()
        if account is None:
            self.enable_button.config(state='disabled')
            self.disable_button.config(state='disabled')
            self.delete_button.config(state='disabled')
            return
        enabled = bool(account['is_enabled'])
        self.enable_button.config(state='disabled' if enabled else 'normal')
        self.disable_button.config(state='normal' if enabled else 'disabled')
        self.delete_button.config(
            state='disabled' if account['is_default'] else 'normal'
        )

    def refresh(self):
        selected = self._selected_username()
        try:
            accounts = list_accounts()
        except (ValueError, RuntimeError, OSError) as exc:
            messagebox.showerror(
                'User Management', str(exc), parent=self.window
            )
            return

        self._accounts = {account['username']: account for account in accounts}
        self.tree.delete(*self.tree.get_children())
        selected_item = None
        for account in accounts:
            status = 'Enabled' if account['is_enabled'] else 'Disabled'
            account_type = (
                'Default full save'
                if account['is_default']
                else 'Independent full-save clone'
            )
            item = self.tree.insert(
                '',
                END,
                values=(
                    account['username'],
                    account['display_name'],
                    account['search_id'],
                    status,
                    account_type,
                ),
            )
            if account['username'] == selected:
                selected_item = item

        if selected_item is not None:
            self.tree.selection_set(selected_item)
            self.tree.focus(selected_item)
            self.tree.see(selected_item)
        self.status_text.set(f'{len(accounts)} account(s)')
        self._sync_button_state()

    def add_full_save_user(self):
        username = simpledialog.askstring(
            'Add Full-Save User',
            '8-character username (ASCII letters/digits):',
            parent=self.window,
        )
        if username is None:
            return
        password = simpledialog.askstring(
            'Add Full-Save User',
            'Password (8-64 characters):',
            parent=self.window,
            show='*',
        )
        if password is None:
            return
        display_name = simpledialog.askstring(
            'Add Full-Save User',
            'In-game display name (1-10 characters).\n'
            'Leave empty to use the username:',
            parent=self.window,
        )
        if display_name is None:
            return
        display_name = display_name.strip() or None

        try:
            result = register_account(
                username,
                password,
                display_name=display_name,
            )
        except (ValueError, RuntimeError) as exc:
            messagebox.showerror(
                'Add Full-Save User', str(exc), parent=self.window
            )
            return

        self.refresh()
        self.status_text.set(
            f"Created {result['username']} (search ID {result['search_id']})"
        )

    def set_selected_enabled(self, enabled):
        account = self._selected_account()
        if account is None:
            return
        try:
            set_account_enabled(account['username'], enabled)
        except (ValueError, RuntimeError) as exc:
            messagebox.showerror(
                'User Management', str(exc), parent=self.window
            )
            return
        self.refresh()
        state = 'enabled' if enabled else 'disabled'
        self.status_text.set(f"{account['username']} {state}")

    def _toggle_selected(self, event=None):
        account = self._selected_account()
        if account is None:
            return
        self.set_selected_enabled(not account['is_enabled'])

    def delete_selected_user(self):
        account = self._selected_account()
        if account is None:
            return
        if account['username'] == DEFAULT_USERNAME or account['is_default']:
            messagebox.showerror(
                'Delete User',
                'The default full-save account cannot be deleted.',
                parent=self.window,
            )
            return

        confirmed = messagebox.askyesno(
            'Delete User',
            (
                f"Permanently delete {account['username']} and its independent "
                'save data?\n\nThis cannot be undone.'
            ),
            parent=self.window,
        )
        if not confirmed:
            return

        try:
            delete_account(account['username'])
        except (ValueError, RuntimeError) as exc:
            messagebox.showerror('Delete User', str(exc), parent=self.window)
            return
        self.refresh()
        self.status_text.set(f"Deleted {account['username']}")
