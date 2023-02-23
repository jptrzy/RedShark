
class VideoEntry : GLib.Object {
    public string title {set;get;default = "TITLE PLACEHOLDER";}
    public string channel {set;get;default = "CHANNEL PLACEHOLDER";}
    public string views {set;get;default = "VIEWS PLACEHOLDER";}
    public File image_path {set;get;}
    public string video_url {set;get;}
}

[GtkTemplate (ui = "/ui/VideosList.ui")]
class VideosList : Gtk.Box {
    [GtkChild] private unowned Gtk.GridView list;
    [GtkChild] private unowned Gtk.Stack stack;
    [GtkChild] private unowned Gtk.Spinner spinner;

    private bool video_player_opened = false;
 
    public static GLib.ListStore model_list
        = new GLib.ListStore(typeof (VideoEntry));

    public VideosList () {
        Object ();

        list.set_model (new Gtk.NoSelection (model_list));

        model_list.append (
            new VideoEntry () {
            
            }
        );

        stack.visible_child_name = "view";
    }

    // I isn't the best solution, but it works for now.
    private static string cut_number (int64 number) {
        var text = "";
        return text;
    }

    public async void search_for (string text) {
        if (stack.visible_child_name == "watch") {
            return;
        }

        stack.visible_child_name = "load";
        spinner.spinning = true; 

        //var url = "https://yt.funami.tech/api/v1/search?q=%s".printf (text);
        var url = "https://www.googleapis.com/youtube/v3/search?key=%s&maxResults=20&part=snippet&type=video&q=%s"
            .printf (Config.get ().youtube_api_key, text);

        GJson.Node data;

        try {
            var res = yield fetch(url);
            data = yield res.json();
      
            if (!res.ok) {
                error ("Request isn't ok.");
                return;
            }
        } catch (Error err) {
            warning ("Some kind of a problem occured with a request: '%s'", err.message);
            return;
        }

        model_list.remove_all ();

        var tmp_dir = File.new_for_path (Environment.get_tmp_dir () + "/redshark");
        try {
            tmp_dir.make_directory_with_parents (null);
        } catch (Error err) { 
            warning ("%s", err.message);
        }

        if (tmp_dir.get_path () == null) {
            warning ("Can't get tmp dir path");
            return;
        }

        foreach (var item in data.as_object ()["items"].as_array ()) {
            string video_id = ((GJson.Object) item)["id"]["videoId"].as_string ();
            var snippet = ((GJson.Object) item)["snippet"];

            var image_url = snippet["thumbnails"]["medium"]["url"].as_string ();
            var target = File.new_for_path (
                tmp_dir.get_path () + "/thumbnail-" + video_id + ".jpg");

            yield downlaod_image (target, image_url);

            model_list.append (new VideoEntry () {
                title = snippet["title"].as_string(),
                channel = snippet["channelTitle"].as_string(),
                image_path = target,
                video_url = "https://www.youtube.com/watch?v=%s".printf (video_id),
            });
        }

        stack.visible_child_name = "view";
    }

    public async void downlaod_image (File file, string url) {
        var image = yield fetch (url);
        
        try {
            yield file.delete_async (0, null);
        } catch { }

        var os = file.create (FileCreateFlags.NONE, null);
        os.write_bytes (yield image.bytes (), null);
    }


    [GtkCallback]
    public async void on_click (uint pos) {
        message ("run %b", video_player_opened);
        video_player_opened = true;
        //stack.visible_child_name = "watch";

        var url = ((VideoEntry) model_list.get_object (pos)).video_url;

        // Blocking with output
        string standard_output, standard_error;
        int exit_status;
        Process.spawn_command_line_sync (
            "mpv %s".printf (url),
            out standard_output, out standard_error, out exit_status);

        message (standard_output);

        stack.visible_child_name = "view";
        video_player_opened = false;
    }
}
