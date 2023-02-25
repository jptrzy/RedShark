[SingleInstance]
class App : Adw.Application {
    public App () {
        Object (
            application_id: "xyz.jptrzy.Yourtube",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var window = new AppWindow(this);

        // Actions
        var action = new SimpleAction ("show.info", null);
		action.activate.connect (window.show_info);
		this.add_action (action);

        action = new SimpleAction ("show.settings", null);
		action.activate.connect (window.show_settings);
		this.add_action (action);


        window.present ();
    }

    /* TODO How to pass functions as arguments
    private void add_simple_action(string name, void method) {
        var action = new SimpleAction (name, null);
		action.activate.connect (method);
		this.add_action (action);
    }
    */

    static async void main (string[] args) {
        Gtk.init ();

        // TODO Add proper gtk/adw dialog message
        try {
            yield Config.get ().load ();
        } catch (Error err) {
            error (
                "Error while loading a config file. "+
                "This might break or block some functionalitis of redshark. "+
                "It is recommended to fix this issue, before proper app ussage.");
        }

        new App ().run(args);
    }
}
