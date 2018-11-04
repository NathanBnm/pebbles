/*-
 * Copyright (c) 2017-2018 Subhadeep Jasu <subhajasu@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by: Subhadeep Jasu <subhajasu@gmail.com>
 *              Saunak Biswas  <saunakbis97@gmail.com>
 */
 
namespace Pebbles {
    public class PebblesApp : Gtk.Application {
        Pebbles.Settings settings;

        static PebblesApp _instance = null;
        public static PebblesApp instance {
            get {
                if (_instance == null) {
                    _instance = new PebblesApp ();
                }
                return _instance;
            }
        }

        public PebblesApp () {
            Object (
                application_id: "com.github.SubhadeepJasu.pebbles",
                flags: ApplicationFlags.HANDLES_COMMAND_LINE
            );
            settings = Settings.get_default ();
        }

        public MainWindow mainwindow { get; private set; default = null; }
        protected override void activate () {
            if (mainwindow == null) {
                mainwindow = new MainWindow ();
                mainwindow.application = this;
            }
            mainwindow.present ();
        }

        public override int command_line (ApplicationCommandLine cmd) {
            command_line_interpreter (cmd);
            return 0;
        }

        private void command_line_interpreter (ApplicationCommandLine cmd) {
            string[] cmd_args = cmd.get_arguments ();
            unowned string[] args = cmd_args;
            
            bool mem_to_clip = false;
            
            GLib.OptionEntry [] option = new OptionEntry [2];
            option [0] = { "last_result", 0, 0, OptionArg.NONE, ref mem_to_clip, "Get last answer", null };
            option [1] = { null };
            
            var option_context = new OptionContext ("actions");
            option_context.add_main_entries (option, null);
            try {
                option_context.parse (ref args);
            } catch (Error err) {
                warning (err.message);
                return;
            }
            
            if (mem_to_clip) {
                if (mainwindow != null) {
                    mainwindow.answer_notify ();
                    stdout.printf ("[STATUS]  Pebbles: Last answer copied to clipboard.\n");
                }
                else if (mainwindow == null) {
                    stdout.printf ("[ERROR]   Pebbles: Action ignored. App UI not running\n");
                    return;
                }
            }
            else {
                activate ();
            }
        }

        public static int main (string[] args) {
            var app = new PebblesApp ();
            return app.run (args);
        }
    }
}
