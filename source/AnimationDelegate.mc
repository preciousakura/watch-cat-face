import Toybox.Lang;
import Toybox.WatchUi;

class AnimationDelegate extends WatchUi.AnimationDelegate {
    var animationDone = true;

    function initialize() {
        WatchUi.AnimationDelegate.initialize();
    }

    function onAnimationEvent(event as AnimationEvent, options as Dictionary) as Void {
        switch (event) {
            case ANIMATION_EVENT_COMPLETE:
                animationDone = true;
                WatchUi.requestUpdate();
                break;
            default:
        }
    }
}