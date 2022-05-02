using Clutter;
using GLib;

namespace Monitor
{
	public class WidgetBox : Actor
	{
		const int PADDING = 24;
		Canvas canvas;
		int number = 1;
		// int fps = 1000 / 24; // 24 frames per second
		int fps = 500;
		public WidgetBox ()
		{
			width = 400;
			height = 300;
			load_canvas ();
			Timeout.add (fps, update);
			content = canvas;
		}

		bool load_canvas ()
		{
			canvas = new Canvas ();
			canvas.draw.connect (draw_background);
			canvas.set_size ((int)width, (int)height);
			return true;
		}

		bool draw_background ( Cairo.Context cr )
		{
			cr.set_operator (Cairo.Operator.CLEAR);
			cr.paint ();
			cr.set_operator (Cairo.Operator.OVER);

			var buffer = new Granite.Drawing.BufferSurface ((int)width, (int)height);

			var width = (int)width - PADDING * 2;
			var height = (int)height - PADDING * 2;

			Granite.Drawing.Utilities.cairo_rounded_rectangle (buffer.context, PADDING, PADDING, width, height, 5);
			buffer.context.set_source_rgba (0, 0, 0, 1);
			buffer.context.fill ();
			buffer.exponential_blur (12);

			cr.set_source_surface (buffer.surface, 0, 0);
			cr.paint ();

			Granite.Drawing.Utilities.cairo_rounded_rectangle (cr, PADDING, PADDING, width, height, 5);
			cr.set_source_rgb (0.2, 0.2, 0.2);
			cr.fill ();

			// Text:
			cr.set_source_rgb (0.1, 0.1, 0.1);
			cr.select_font_face ("Ubuntu", Cairo.FontSlant.NORMAL, Cairo.FontWeight.BOLD);
			cr.set_font_size (20);
			cr.move_to (100, 60);
			cr.show_text ("Test Monitor Plugin");

			cr.select_font_face ("Ubuntu Mono", Cairo.FontSlant.NORMAL, Cairo.FontWeight.NORMAL);
			cr.set_source_rgb (0.9, 0.1, 0.1);
			cr.set_font_size (100);
			cr.move_to (140, 200);

			if(number > 100)
			{
				number = 1;
			}
			number++;

			cr.show_text (number.to_string());

			return true;
		}

		bool update ()
		{
			canvas.invalidate();
			return true;
		}
	}
}
