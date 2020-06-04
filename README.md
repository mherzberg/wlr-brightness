# wlr-brightness

wlr-brightness adjust the brightness of your screen when using
[wlroots](https://github.com/swaywm/wlroots/)-based
[Wayland](https://wayland.freedesktop.org/) compositors such as
[sway](https://github.com/swaywm/sway/). It works by adjusting the gamma values
of your screen and therefore supports both screens with and without backlight
(such as OLED).

## Installation

### From Source

Dependencies:

* [wlroots](https://github.com/swaywm/wlroots)
* wayland
* dbus
* wlr-protocols

Pull wlr-protocols:

    git submodule update --init --recursive

Compile:

    make
    
If you want to install wlr-brightness, you can use the systemd service:

    sudo make install
    cp res/wlr-brightness.service ~/.config/systemd/user/
    systemctl --user enable --now wlr-brightness

## Usage

Start the daemon:

    wlr-brightness

wlr-brightness is a Wayland-client and therefore needs to keep running. The
brightness will reset to the maximum on exit. To control wlr-brightness, use any
dbus utility, e.g.:

    gdbus call -e -d de.mherzberg -o /de/mherzberg/wlrbrightness -m de.mherzberg.wlrbrightness.get
    gdbus call -e -d de.mherzberg -o /de/mherzberg/wlrbrightness -m de.mherzberg.wlrbrightness.set 0.7
    gdbus call -e -d de.mherzberg -o /de/mherzberg/wlrbrightness -m de.mherzberg.wlrbrightness.increase 0.1
    gdbus call -e -d de.mherzberg -o /de/mherzberg/wlrbrightness -m de.mherzberg.wlrbrightness.decrease 0.1
