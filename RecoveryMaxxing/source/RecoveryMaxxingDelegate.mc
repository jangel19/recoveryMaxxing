import Toybox.Lang;
import Toybox.WatchUi;

class RecoveryMaxxingDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new RecoveryMaxxingMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
    function onNextPage() as Boolean {
        WatchUi.pushView(new weekChart(), null, WatchUi.SLIDE_UP);
        return true;
    }
    function onPreviousPage() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }

}
