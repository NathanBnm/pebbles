/*-
 * Copyright (c) 2017-2018 Subhadeep Jasu <subhajasu@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License 
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by: Subhadeep Jasu <subhajasu@gmail.com>
 *              Saunak Biswas  <saunakbis97@gmail.com>
 */

namespace Pebbles {
    public class ConvLengthView : Gtk.Grid {
        private CommonKeyPadConverter keypad;
        public Gtk.Entry from_entry;
        public Gtk.Entry to_entry;
        private int from_to = 0;

        construct {
            keypad = new CommonKeyPadConverter ();

            // Make Header Label
            var header_title = new Gtk.Label ("Length");
            header_title.get_style_context ().add_class ("h1");
            header_title.set_justify (Gtk.Justification.LEFT);
            header_title.halign = Gtk.Align.START;
            header_title.margin_start = 6;

            // Make Upper Unit Box
            from_entry = new Gtk.Entry ();
            from_entry.set_text ("1");
            from_entry.get_style_context ().add_class ("Pebbles_Conversion_Text_Box");
            from_entry.max_width_chars = 35;
            Gtk.ComboBoxText from_unit = new Gtk.ComboBoxText ();
            from_unit.append_text ("Nanometre");
            from_unit.append_text ("Micron");
            from_unit.append_text ("Millimetre");
            from_unit.append_text ("Centimetre");
            from_unit.append_text ("Metre");
            from_unit.append_text ("Kilometre");
            from_unit.append_text ("Inch");
            from_unit.append_text ("Foot");
            from_unit.append_text ("Yard");
            from_unit.append_text ("Mile");
            from_unit.append_text ("Nautical Mile");
            from_unit.append_text ("Light Year");
            from_unit.active = 4;

            // Make Lower Unit Box
            to_entry = new Gtk.Entry ();
            to_entry.set_text ("100");
            to_entry.get_style_context ().add_class ("Pebbles_Conversion_Text_Box");
            to_entry.max_width_chars = 35;
            Gtk.ComboBoxText to_unit = new Gtk.ComboBoxText ();
            to_unit.append_text ("Nanometre");
            to_unit.append_text ("Micron");
            to_unit.append_text ("Millimetre");
            to_unit.append_text ("Centimetre");
            to_unit.append_text ("Metre");
            to_unit.append_text ("Kilometre");
            to_unit.append_text ("Inch");
            to_unit.append_text ("Foot");
            to_unit.append_text ("Yard");
            to_unit.append_text ("Mile");
            to_unit.append_text ("Nautical Mile");
            to_unit.append_text ("Light Year");
            to_unit.active = 3;

            // Create Conversion active section
            var conversion_direction = new Granite.Widgets.ModeButton ();
            conversion_direction.halign = Gtk.Align.CENTER;
            conversion_direction.valign = Gtk.Align.CENTER;
            
            var interchange_button = new Gtk.Button ();
            var up_button = new Gtk.Image.from_icon_name ("go-up-symbolic", Gtk.IconSize.BUTTON);
            var down_button = new Gtk.Image.from_icon_name ("go-down-symbolic", Gtk.IconSize.BUTTON);
            var up_down_grid = new Gtk.Grid ();
            up_down_grid.valign = Gtk.Align.CENTER;
            up_down_grid.halign = Gtk.Align.CENTER;
            up_down_grid.attach (up_button, 0, 0, 1, 1);
            up_down_grid.attach (down_button, 1, 0, 1, 1);
            interchange_button.add (up_down_grid);
            interchange_button.margin_start = 100;
            interchange_button.margin_end   = 100;

            Gtk.Grid conversion_grid = new Gtk.Grid ();
            conversion_grid.attach (from_unit, 0, 0, 1, 1);
            conversion_grid.attach (from_entry, 0, 1, 1, 1);
            conversion_grid.attach (interchange_button, 0, 2, 1, 1);
            conversion_grid.attach (to_unit, 0, 3, 1, 1);
            conversion_grid.attach (to_entry, 0, 4, 1, 1);
            conversion_grid.width_request = 240;
            conversion_grid.height_request = 200;
            conversion_grid.set_row_homogeneous (true);
            conversion_grid.margin_start = 8;
            conversion_grid.margin_end = 8;
            conversion_grid.halign = Gtk.Align.CENTER;
            conversion_grid.row_spacing = 8;
            
            var separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
            separator.margin_start = 25;
            separator.margin_end = 25;
            
            halign = Gtk.Align.CENTER;
            valign = Gtk.Align.CENTER;
            attach (header_title, 0, 0, 3, 1);
            attach (keypad, 0, 1, 1, 1);
            attach (separator, 1, 1, 1, 1);
            attach (conversion_grid, 2, 1, 1, 1);
            row_spacing = 8;

            handle_focus ();
        }

        private void handle_focus () {
            from_entry.button_press_event.connect (() => {
                from_to = 0;
                return false;
            });
            to_entry.button_press_event.connect (() => {
                from_to = 1;
                return false;
            });
            this.key_press_event.connect ((event) => {
                switch (from_to) {
                    case 0: 
                        this.from_entry.grab_focus_without_selecting ();
                        break;
                    case 1:
                        this.to_entry.grab_focus_without_selecting ();
                        break;
                }
                return false;
            });
        }
    }
}