async Response fetch (string url) throws Error {
    var session = new Soup.Session ();
    var msg = new Soup.Message ("GET", url);

    return new Response (yield session.send_async (msg, Priority.DEFAULT, null)) {
        status_code = msg.status_code,
        status_text = msg.reason_phrase,
        ok          = 200 <= msg.status_code < 300,
    };
}
