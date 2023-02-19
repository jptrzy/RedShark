[GtkTemplate (ui = "/ui/AboutWindow.ui")]
class AboutWindow : Adw.AboutWindow {
    public AboutWindow (App app) {
        Object (application: app);
    }
}

