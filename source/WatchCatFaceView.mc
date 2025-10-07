import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchCatFaceView extends WatchUi.WatchFace {
    private var animation as AnimationLayer or Null = null;
    private var clockLayer as DigitalClockView or Null = null; 
    private var dataFields as DataFields or Null = null;

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        animation = new AnimationLayer(Rez.Drawables.NeonCat);
        if(animation != null) {
            insertLayer(animation, 0);
        }

        clockLayer = new DigitalClockView(dc);
        if(clockLayer != null) {
            insertLayer(clockLayer, 1);
        }

        dataFields = new DataFields();
        if(dataFields != null) {
            insertLayer(dataFields, 2);
        }
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() as Void {
        if(animation != null) {
            animation.onPlay();
        }
    }

    function onUpdate(dc as Dc) as Void {
        if(animation != null) {
            if (animation.delegate.animationDone) {
                animation.delegate.animationDone = false;
                animation.onPlay();
            }
        }

        if(clockLayer != null) {
            clockLayer.onUpdate();
        }

        if(dataFields != null) {
            dataFields.onUpdate();
        }
        View.onUpdate(dc);
    }

    function onHide() as Void {
        if(animation != null) {
            animation.onStop();
        }
    }

    function onExitSleep() as Void {
        if(animation != null) {
            animation.onPlay();
        }
    }

    function onEnterSleep() as Void {
        if(animation != null) {
            animation.onStop();
        }
    }
}