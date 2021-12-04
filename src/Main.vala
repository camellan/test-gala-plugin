namespace Gala.Plugins.Test_Widget {
    public class Main : Gala.Plugin {
        private Gala.WindowManager? wm = null;
        private Meta.Display display;
        private Monitor.WidgetBox widgetbox;

        construct {
            widgetbox = new Monitor.WidgetBox ();
            widgetbox.reactive = true;
            widgetbox.x = 1530;
            widgetbox.y = 20;
        }

        public override void initialize (Gala.WindowManager wm) {
            this.wm = wm;
            display = wm.get_display ();
            wm.background_group.add_child (widgetbox);
            widgetbox.hide ();
            var settings = new GLib.Settings ("org.pantheon.desktop.gala.keybindings.monitor");
            display.add_keybinding ("monitor", settings, 0, () => {
                if (widgetbox.is_visible ()) {
                    widgetbox.hide ();
                } else {
                    widgetbox.show ();
                }
            });
        }

        public override void destroy () {
            widgetbox.destroy ();
        }
    }
}

public Gala.PluginInfo register_plugin () {
    return {
        "monitor-gala-plugin",
        "Andrey Kultyapov <camellan@yandex.ru>",
        typeof (Gala.Plugins.Test_Widget.Main),
        Gala.PluginFunction.ADDITION,
        Gala.LoadPriority.IMMEDIATE
    };
}
