using Clutter;

namespace Monitor
{
	public class WidgetBox : Actor
	{
		const int PADDING = 24;

		public WidgetBox ()
		{
			width = 400;
			height = 300;

			var canvas = new Canvas ();
			canvas.draw.connect (draw_background);
			canvas.set_size ((int)width, (int)height);
			content = canvas;
		}

		bool draw_background (Cairo.Context cr)
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

			return false;
		}
	}
}
