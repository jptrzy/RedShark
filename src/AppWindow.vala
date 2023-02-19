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

    construct {}


    [GtkCallback]
    public async void show_info () {
        message ("Show info");

        var builder = new Gtk.Builder.from_resource ("/ui/AboutWindow.ui");
		var window = (Adw.AboutWindow) builder.get_object ("window");

        window.application_name = "RedShark";
        window.version = "0.0.1";
        window.developer_name = "Jakub (jptrzy) Trzeciak";

        window.license_type = Gtk.License.GPL_3_0;

    
        window.show();
    }

    [GtkCallback]
    public async void on_search () {
        var text = search_entry.text;

        if (text == "") return;
        
        message ("Search");
    }
}

