#!/usr/bin/env python3
import sys
import gi

gi.require_version('Gtk', '4.0')
gi.require_version('Adw', '1')

from gi.repository import Gtk, Adw, Gio

class CupcakeWelcome(Adw.Application):
    def __init__(self):
        super().__init__(application_id='com.cupcake.welcome',
                         flags=Gio.ApplicationFlags.FLAGS_NONE)

    def do_activate(self):
        win = Adw.ApplicationWindow(application=self)
        win.set_default_size(800, 600)
        win.set_title("Welcome to Cupcake")

        # Main Content
        content = Adw.StatusPage()
        content.set_icon_name("system-help-symbolic")
        content.set_title("Welcome to Cupcake")
        content.set_description("Your friendly, powerful, and reproducible Linux system.")

        # Action Buttons
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        box.set_halign(Gtk.Align.CENTER)
        
        # Tour Button
        btn_tour = Gtk.Button(label="Start Tour")
        btn_tour.add_css_class("pill")
        btn_tour.add_css_class("suggested-action")
        btn_tour.connect("clicked", self.on_tour_clicked)
        box.append(btn_tour)

        # Setup Button
        btn_setup = Gtk.Button(label="Setup Network & Accounts")
        btn_setup.add_css_class("pill")
        btn_setup.connect("clicked", self.on_setup_clicked)
        box.append(btn_setup)

        # Docs Button
        btn_docs = Gtk.Button(label="Read Documentation")
        btn_docs.add_css_class("pill")
        btn_docs.connect("clicked", self.on_docs_clicked)
        box.append(btn_docs)

        # Container
        clamp = Adw.Clamp()
        clamp.set_maximum_size(600)
        
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        main_box.append(content)
        main_box.append(box)
        
        clamp.set_child(main_box)
        win.set_content(clamp)
        win.present()

    def on_tour_clicked(self, button):
        print("Tour started!")

    def on_setup_clicked(self, button):
        print("Setup started!")
    
    def on_docs_clicked(self, button):
        Gio.AppInfo.launch_default_for_uri("https://github.com/cupcake/docs", None)

def main():
    app = CupcakeWelcome()
    return app.run(sys.argv)

if __name__ == '__main__':
    sys.exit(main())
