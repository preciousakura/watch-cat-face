import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time.Gregorian;

class DigitalClockView extends WatchUi.Layer {
    var time as WatchUi.Text;
    var date as WatchUi.Text;

    public function initialize(dc as Dc) {
        var font = Application.loadResource(Rez.Fonts.JoyfulDigits) as FontType;
        time = new WatchUi.Text({
            :color=>Graphics.COLOR_WHITE,
            :font=>font,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>340/6
        });

        date = new WatchUi.Text({
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_AUX1,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>340/8
        });

        WatchUi.Layer.initialize({
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
        });
    }

    public function onUpdate(layer as WatchUi.Layer) as Void {
        var dc = layer.getDc();
        dc.clear();

        var clockTime = System.getClockTime();
        var hourMinString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);

        time.setText(hourMinString);
        time.draw(dc); 

        var now = Time.now();
        var dateInfo = Gregorian.info(now, Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$, $2$ $3$", [dateInfo.day_of_week, dateInfo.month, dateInfo.day]);
        date.setText(dateString);
        date.draw(dc);
    }
}