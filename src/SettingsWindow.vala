[GtkTemplate (ui = "/ui/SettingsWindow.ui")]
class SettingsWindow : Adw.PreferencesWindow {
    private Config c = Config.get ();

    [GtkChild] private unowned Adw.ComboRow backend;
    [GtkChild] private unowned Adw.PasswordEntryRow youtube_api_key;

    construct {
        var model = new Adw.EnumListModel(typeof (Backend));

        backend.expression = new Gtk.PropertyExpression(typeof(Adw.EnumListItem), null, "nick");
        backend.model = model;
        backend.selected = c.backend;

        youtube_api_key.text = c.youtube_api_key;
    }

    [GtkCallback]
    private async void save() {
        c.backend = ((Adw.EnumListItem) backend.selected_item).value;
        c.youtube_api_key = youtube_api_key.text;

        try {
            yield c.save ();

            var toast = new Adw.Toast("Save successfully");
            toast.timeout = 1;
            toast.priority = Adw.ToastPriority.HIGH;
    
            add_toast(toast);
        } catch (Error err) {
            warning("There was an error while saving config '%s'", err.message);

            var toast = new Adw.Toast("Error while saving");
            toast.timeout = 3;
            toast.priority = Adw.ToastPriority.HIGH;

            add_toast(toast);
        }
    }
}
