import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class AnimationLayer extends WatchUi.AnimationLayer {
    var delegate as AnimationDelegate;
    
    function initialize(rez as Lang.ResourceId or WatchUi.AnimationResource) {
        var dev = System.getDeviceSettings();
        var res = WatchUi.loadResource(rez) as BitmapResource;
        
        var x = 0;
        var y = (dev.screenHeight - res.getHeight()) / 2;

        AnimationLayer.initialize(rez,{:locX=>x,:locY=>y});
        delegate = new AnimationDelegate(); 
    }

    public function onPlay() as Void {
        play({:delegate=>self.delegate});
    }

    public function onStop() as Void {
        stop();
    }
}