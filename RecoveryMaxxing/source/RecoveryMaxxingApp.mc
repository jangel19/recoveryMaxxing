import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class RecoveryMaxxingApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    // function getInitialView() as [Views] or [Views, InputDelegates] {
    //     var factory = new RecoveryViewFactory();
    //     var viewLoop = new WatchUi.ViewLoop(factory, null);
    //     return [viewLoop, new WatchUi.ViewLoopDelegate(viewLoop)];
    // }
    function getInitialView() as [Views] or [Views, InputDelegates] {
    return [new RecoveryMaxxingView(), new RecoveryMaxxingDelegate()];
}

}

function getApp() as RecoveryMaxxingApp {
    return Application.getApp() as RecoveryMaxxingApp;
}
class RecoveryViewFactory extends WatchUi.ViewLoopFactory {

    function initialize() {
        ViewLoopFactory.initialize();
    }

    function getSize() as Lang.Number {
        return 2; // two pages: recovery score + week chart
    }

    function getView(page as Lang.Number) {
        if (page == 0) {
            return [new RecoveryMaxxingView()];
        } else {
            return [new weekChart()];
        }
    }
}
