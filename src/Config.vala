public enum Backend {
    NONE,

    YOUTUBE_WITH_API,
    YOUTUBE_WITH_YURUVERSE,
}

[SingleInstance]
class Config : GLib.Object {
    public int config_version {get; set; default = 0;}
    public string youtube_api_key {get; set; default = "";}
    public Backend backend {get; set; default = Backend.NONE;}

    private Config() {}
   
    private static Config instance = null;
    public new static Config get() {
        if (Config.instance == null) {
            Config.instance = new Config();
        }

        return Config.instance;
    }

    public async string get_file() {
        var config_dir = Environment.get_user_config_dir () + "/redshark";
        var config_dir_file = File.new_for_path(config_dir);

        if (!config_dir_file.query_exists(null)) {
            File.new_for_path(config_dir).make_directory_with_parents();
        }
  
        return config_dir + "/config.json";
    }

    public async void save() throws Error {
        var config_file = yield get_file ();

        Json.Node root = Json.gobject_serialize(this);
        Json.Generator generator = new Json.Generator ();
        generator.set_root (root);

        generator.to_file (config_file);
    }

    public async void load() throws Error {
        var config_file = File.new_for_path (yield get_file ());

        if (config_file.query_exists()) {  
            var parser = new Json.Parser();

            parser.load_from_file(config_file.get_path ());
    
            Config.instance = (Config) Json.gobject_deserialize (typeof(Config), parser.get_root ());
        } else {
            message ("Creating config file at '%s'", config_file.get_path ());

            save ();
        }
    }
}
