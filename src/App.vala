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

    static void main (string[] args) {
        stdout.printf ("Hello world!\n");

        new App ().run(args);
    }
}
