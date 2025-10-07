import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

class DataField extends WatchUi.Text {
    private var icon as WatchUi.Bitmap or Null;

    public function initialize(options as {
        :locX as Numeric, 
        :locY as Numeric,
        :color as ColorType,
        :font as FontType,
        :justification as TextJustification,
        :iconLocX as Numeric, 
        :iconLocY as Numeric, 
        :iconRezId as ResourceId or Null,
    }) {
        var iconRez = options.get(:iconRezId);
        if (iconRez !=  null) {
            icon = new WatchUi.Bitmap({
                :rezId=>iconRez,
                :locX=>options.get(:iconLocX),
                :locY=>options.get(:iconLocY)
            });
        }

        Text.initialize({
            :locX =>options.get(:locX),
            :locY=>options.get(:locY),
            :color=>options.get(:color),
            :font=>options.get(:font),
            :justification=>options.get(:justification),
        });
    }

    public function draw(dc as Dc) as Void {
        if(icon !=  null) {
            icon.draw(dc);
        }
        Text.draw(dc);
    }

    public function setIconLocation(x as Numeric, y as Numeric) as Void {
        if(icon != null) {
            icon.setLocation(x, y);
        }
    }
}