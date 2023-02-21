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

        window.present ();
    }

    static async void main (string[] args) {

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
