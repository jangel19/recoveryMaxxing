import Toybox.Graphics;
import Toybox.WatchUi;

class RecoveryMaxxingView extends WatchUi.View {

    var _score = 75;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var cx = width / 2;
        var cy = height / 2;

        // draw the circl
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(15);
        dc.drawArc(cx, cy, cx - 20, Graphics.ARC_CLOCKWISE, 0, 360);

        // draw recovery circle based ont eh score
        dc.setColor(getRecoveryColor(_score), Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(15);
        var sweepAngle = (_score/ 100.0) * 360;
        dc.drawArc(cx, cy, cx - 20, Graphics.ARC_CLOCKWISE, 90, 90 - sweepAngle);

        // rec label
        dc.drawText(cx, cy -40, Graphics.FONT_TINY, "RECOVERY SCORE", Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cx, cy - 20, Graphics.FONT_NUMBER_HOT, _score.toString(),
            Graphics.TEXT_JUSTIFY_CENTER);
        // draw the seven day chart
        // drawWeekChart(dc, width, height);

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function getRecoveryColor(score) {
        if (score >= 70) {
            return Graphics.COLOR_GREEN;
        } else if (score >= 50) {
            return Graphics.COLOR_YELLOW;
        } else {
            return Graphics.COLOR_RED;
        }
    }
    
    function onHide() as Void {
    }

}
