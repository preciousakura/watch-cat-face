import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time.Gregorian;

class DigitalClockView extends WatchUi.Layer {
    private var timeDataField as DataField or Null = null;
    private var dateDataField as DataField or Null = null;

    public function initialize(dc as Dc) {
        var height = dc.getHeight();

        var font = Application.loadResource(Rez.Fonts.JoyfulDigits) as FontType;
        timeDataField = new DataField({
            :color=>Graphics.COLOR_WHITE,
            :font=>font,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>height * 0.15
        });

        dateDataField = new DataField({
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_AUX1,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>height * 0.12
        });

        WatchUi.Layer.initialize({
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
        });
    }

    public function onUpdate() as Void {
        var dc = Layer.getDc();
        if(dc != null) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.clear();

            var clockTime = System.getClockTime();
            var hourMinString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);

            timeDataField.setText(hourMinString);
            timeDataField.draw(dc); 

            var now = Time.now();
            var dateInfo = Gregorian.info(now, Time.FORMAT_MEDIUM);
            var dateString = Lang.format("$1$, $2$ $3$", [dateInfo.day_of_week, dateInfo.month, dateInfo.day]);
            dateDataField.setText(dateString);
            dateDataField.draw(dc);
        }
       
    }
}