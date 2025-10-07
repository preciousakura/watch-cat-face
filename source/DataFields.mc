import Toybox.Lang;
import Toybox.ActivityMonitor;
import Toybox.System;
import Toybox.WatchUi;

class DataFields extends WatchUi.Layer {  
    private var width as Lang.Numeric or Null;
    private var height as Lang.Numeric or Null;

    private var bateryIcon as WatchUi.BitmapResource or Null;
    private var stepsIcon as WatchUi.BitmapResource or Null;
    private var heartIcon as WatchUi.BitmapResource or Null;

    private var stats as System.Stats or Null = null;
    private var info as ActivityMonitor.Info or Null = null;
    private var heartRate as Lang.Numeric or Null = null;

    public function initialize() {
        stats = System.getSystemStats();
        info = ActivityMonitor.getInfo();

    	var heartrateIterator = ActivityMonitor.getHeartRateHistory(1, true);
        heartRate = heartrateIterator.next().heartRate;

        WatchUi.Layer.initialize({
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
        
        var dc = Layer.getDc();

        width = dc.getWidth();
        height = dc.getHeight();

        stepsIcon = Application.loadResource(Rez.Drawables.StepsIcon) as BitmapResource;
        bateryIcon = Application.loadResource(Rez.Drawables.LightningIcon) as BitmapResource;
        heartIcon = Application.loadResource(Rez.Drawables.HeartIcon) as BitmapResource;
    }

    public function onUpdate() as Void {
        var dc = Layer.getDc();
        if(dc != null) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.clear();

            var battery = Math.round(stats.battery).toNumber().toString();
            var bateryFormat = battery + "%";
            dc.drawBitmap(width - 55, height / 2 - 25, bateryIcon);
            dc.drawText(width - 40, height / 2, Graphics.FONT_XTINY, bateryFormat, Graphics.TEXT_JUSTIFY_CENTER);

            var heartFormat = "-";
            if(heartRate != Toybox.ActivityMonitor.INVALID_HR_SAMPLE) {
                heartFormat = heartRate.toString();
            }
            var heartRateTextSize = dc.getTextDimensions(heartFormat, Graphics.FONT_XTINY);
            dc.drawBitmap(width * 0.42 - (heartRateTextSize[0]/2), height - 76, heartIcon);
            dc.drawText(width * 0.5, height - 80, Graphics.FONT_XTINY, heartFormat, Graphics.TEXT_JUSTIFY_CENTER);

            var steps = Math.round(info.steps).toNumber();
            var stepsFormat = steps.toString();
            var stepsTextSize = dc.getTextDimensions(stepsFormat, Graphics.FONT_XTINY);
            dc.drawBitmap(width * 0.42 - (stepsTextSize[0]/2), height - 46, stepsIcon);
            dc.drawText(width * 0.5, height - 50, Graphics.FONT_XTINY, stepsFormat, Graphics.TEXT_JUSTIFY_CENTER);
        }
      
    }
}