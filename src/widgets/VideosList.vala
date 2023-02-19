
class VideoEntry : GLib.Object {
    public string title {set;get;default = "TITLE PLACEHOLDER";}
    public string channel {set;get;default = "CHANNEL PLACEHOLDER";}
}

[GtkTemplate (ui = "/ui/VideosList.ui")]
class VideosList : Gtk.Box {
    [GtkChild] private unowned Gtk.GridView list;
 
    public static GLib.ListStore model_list
        = new GLib.ListStore(typeof (VideoEntry));

    public VideosList () {
        Object ();

        list.set_model (new Gtk.NoSelection (model_list));

        model_list.append (
            new VideoEntry () {
            
            }
        );
    }

    construct {}

    [GtkCallback]
    public async void on_click () {
        message ("click"); 
    }
}
