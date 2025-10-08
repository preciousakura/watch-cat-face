import Toybox.Lang;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.System;
import Toybox.WatchUi;

class DataFields extends WatchUi.Layer {  
    private var width as Lang.Numeric or Null;
    private var height as Lang.Numeric or Null;

    private var batteryDataField as DataField or Null;
    private var stepsDataField as DataField or Null = null;
    private var heartRateDataField as DataField or Null = null;
    private var caloriesDataField as DataField or Null = null;

    public function initialize() {
        WatchUi.Layer.initialize({
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
        
        var dc = Layer.getDc();
        width = dc.getWidth();
        height = dc.getHeight();

        batteryDataField = new DataField({
            :locX=>width - 40, 
            :locY=>height / 2,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_XTINY,
            :iconLocX=>width - 55, 
            :iconLocY=>height / 2 - 25, 
            :iconRezId=>Rez.Drawables.LightningIcon,
        });
        
        caloriesDataField = new DataField({
            :locX=>width * 0.5, 
            :locY=>height - 110,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_XTINY,
            :iconRezId=>Rez.Drawables.FireIcon,
        });

        stepsDataField = new DataField({
            :locX=>width * 0.5, 
            :locY=>height - 50,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_XTINY,
            :iconRezId=>Rez.Drawables.StepsIcon,
        });

        heartRateDataField = new DataField({
            :locX=>width * 0.5, 
            :locY=>height - 80,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_XTINY,
            :iconRezId=>Rez.Drawables.HeartIcon,
        });
    }

    private function getHeartRate() {
        var heartRate = "-";
        var info = Activity.getActivityInfo();
        if (info.currentHeartRate != null) {
            heartRate = info.currentHeartRate;
        } else {
            var latestHeartRateSample = ActivityMonitor.getHeartRateHistory(1, true).next();
            if(latestHeartRateSample.heartRate != Toybox.ActivityMonitor.INVALID_HR_SAMPLE) {
                heartRate = latestHeartRateSample.heartRate.toString();
            }
        }
        return heartRate.toString();
    }

    public function onUpdate() as Void {
        var dc = Layer.getDc();
        if(dc != null) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.clear();

            var stats = System.getSystemStats();
            var battery = Math.round(stats.battery).toNumber().toString();
            var bateryFormat = battery + "%";
            batteryDataField.setText(bateryFormat);
            batteryDataField.draw(dc);

            var info = ActivityMonitor.getInfo();
            
            var calories = Math.round(info.calories).toNumber();
            var caloriesFormat = calories.toString();
            var caloriesTextSize = dc.getTextDimensions(caloriesFormat, Graphics.FONT_XTINY);
            caloriesDataField.setText(caloriesFormat);
            caloriesDataField.setIconLocation(width * 0.42 - (caloriesTextSize[0]/2), height - 106);
            caloriesDataField.draw(dc);

            var steps = Math.round(info.steps).toNumber();
            var stepsFormat = steps.toString();
            var stepsTextSize = dc.getTextDimensions(stepsFormat, Graphics.FONT_XTINY);
            stepsDataField.setText(stepsFormat);
            stepsDataField.setIconLocation(width * 0.42 - (stepsTextSize[0]/2), height - 46);
            stepsDataField.draw(dc);

            var heartFormat = getHeartRate();
            var heartRateTextSize = dc.getTextDimensions(heartFormat, Graphics.FONT_XTINY);
            heartRateDataField.setText(heartFormat);
            heartRateDataField.setIconLocation(width * 0.42 - (heartRateTextSize[0]/2), height - 76);
            heartRateDataField.draw(dc);
        }
    }
}