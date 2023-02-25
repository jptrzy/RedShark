[GtkTemplate (ui = "/ui/AppWindow.ui")]
class AppWindow : Adw.ApplicationWindow {
    [GtkChild] private unowned Gtk.Entry search_entry;
    [GtkChild] private unowned Gtk.Box videos_list_holder;

    private VideosList videos_list;

    public AppWindow (App app) {
        Object (application: app);

        videos_list = new VideosList (); 

        videos_list_holder.append (videos_list);
    
        // Css Styles
        var css_provider = new Gtk.CssProvider ();
		css_provider.load_from_resource ("styles/AppWindow.css");
		Gtk.StyleContext.add_provider_for_display (get_display (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
    }


    public async void show_settings () {
        message ("Show Settings");

        var window = new SettingsWindow ();

        window.show ();
    }

    public async void show_info () {
        message ("Show info");

		var window = new Adw.AboutWindow();

        window.application_name = "RedShark";
        window.version = "0.0.1";
        window.developer_name = "Jakub (jptrzy) Trzeciak";
        window.license_type = Gtk.License.GPL_3_0;

        window.comments = "Simple youtube client that uses mpv as a video player.";

        window.website = "https://github.com/jptrzy/RedShark";
        window.issue_url = "https://github.com/jptrzy/RedShark/issues";
        window.add_link("🧙 Jptrzy's website", "https://jptrzy.xyz");
        window.add_link("💸 Support", "https://jptrzy.xyz/donation");
    
        window.show();
    }

    [GtkCallback]
    public void on_search () {
        var text = search_entry.text;

        if (text == "") return;
        
        new Thread<void> ("search_for", () => videos_list.search_for (text));
    }
}

