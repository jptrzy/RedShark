<img align="left" alt="Project logo" src="data/icons/xyz.jptrzy.Redshark.svg" />

# [WIP] Redshark
It is a "simple" youtube client.

# How it works
It uses [YuruVerse API](https://funami.tech) or Google API (requires api key) to search throw youtube.
After opening video it uses [mpv](https://mpv.io) with [yt-dlp](https://github.com/yt-dlp/yt-dlp) to watch it.

# Design Assumptions
* First polish an existing feature,
then add a new one.
* Don't promote or show the user content that he didn't ask for.

# FAQ
## Why did you start another youtube client project when there are plenty of them?
I wanted to check the current state of vala language, also no project suit me for my use or was not [WIP](https://dont-ship.it/).

...but I use some code from this one [Replay](https://github.com/nahuelwexd/Replay), without it, I wouldn't start this project.
## How to generate your own Google API Key?

# Build From Source
Dependencies change frequently,
so you can check them in `meson.build`.

```
mkdir build
cd build
meson setup
meson compile
```

# TODO
* play multiple video at once
* support youtube alternatives (PearTube)
* rounded corner in image
* download images async
* ~~create icon~~
* ~~settings page~~

