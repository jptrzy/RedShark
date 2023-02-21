[SingleInstance]
class Config : GLib.Object {

    public int config_version {get; set;}
    public string youtube_api_key {get; set;}

    private Config() {}
   
    private static Config instance = null;
    public new static Config get() {
        if (Config.instance == null) {
            Config.instance = new Config();
        }

        return Config.instance;
    }
 
    public async void load() throws Error {
        
        var config_dir = Environment.get_user_config_dir () + "/redshark";

        try {
            File.new_for_path(config_dir).make_directory_with_parents();
        } catch {
            warning("Can't crate '%s' dir", config_dir);
        }
  
        var config_file = File.new_for_path(config_dir + "/config.json");

        if (config_file.query_exists()) {
            var parser = new Json.Parser();

            parser.load_from_file(config_file.get_path ());

            Config.instance = (Config) Json.gobject_deserialize (typeof(Config), parser.get_root ());
        } else {
            message (GJson.serialize_gobject(Config.get ()).to_string ());

            message ("Creating config file at '%s'", config_file.get_path ());


            var os = config_file.create (FileCreateFlags.NONE, null);
            var ds = new DataOutputStream(os);

            ds.put_string (GJson.serialize_gobject(Config.get ()).to_string ());
        }
    
    }
}
