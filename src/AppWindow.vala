[GtkTemplate (ui = "/ui/AppWindow.ui")]
class AppWindow : Adw.ApplicationWindow {
    [GtkChild] private unowned Gtk.Entry search_entry;
    [GtkChild] private unowned Gtk.Box videos_list_holder;

    private VideosList videos_list;

    public AppWindow (App app) {
        Object (application: app);

        videos_list = new VideosList (); 

        videos_list_holder.append (videos_list);
    }

    [GtkCallback]
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
    public async void on_search () {
        var text = search_entry.text;

        if (text == "") return;
        
        yield videos_list.search_for (text);
    }
}

