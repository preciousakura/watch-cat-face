import Toybox.Lang;
import Toybox.ActivityMonitor;
import Toybox.System;
import Toybox.WatchUi;

class DataFields extends WatchUi.Layer {  
    private var bateryText as WatchUi.Text or Null;
    private var stepsText as WatchUi.Text or Null;
    private var stats as System.Stats or Null = null;
    private var info as ActivityMonitor.Info or Null = null;


    public function initialize() {
        stats = System.getSystemStats();
        info = ActivityMonitor.getInfo();

        WatchUi.Layer.initialize({
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
        
        var dc = Layer.getDc();

        bateryText = new WatchUi.Text({
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_XTINY,
            :locX=>dc.getWidth() - 75,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });

        stepsText = new WatchUi.Text({
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_XTINY,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>dc.getHeight() - 75
        });
    }

    public function onUpdate(layer as WatchUi.Layer) as Void {
        var dc = layer.getDc();

        dc.clear();

        var battery = Math.round(stats.battery).toNumber().toString();
        var bateryFormat = battery + "%";

        bateryText.setText(bateryFormat);
        bateryText.draw(dc);

        var stepsFormat = Math.round(info.steps).toNumber().toString();
        stepsText.setText(stepsFormat);
        stepsText.draw(dc);
    }
}