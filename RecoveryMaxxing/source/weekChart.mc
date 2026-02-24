import Toybox.Graphics;
import Toybox.WatchUi;

class weekChart extends WatchUi.View {
    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();

        var scores = [65, 72, 80, 45, 60, 10, 75];
        var chartTop = height / 3;
        var chartBottom = height - 60;
        var chartHeight = chartBottom - chartTop;
        var xSpacing = width / 10;
        var startX = xSpacing * 2;

        // draw title
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width/2, 10, Graphics.FONT_XTINY, "7 DAY RECOVERY", Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width - 10, chartTop, Graphics.FONT_XTINY, "100", Graphics.TEXT_JUSTIFY_RIGHT);

        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width - 10, chartTop + (chartHeight / 2), Graphics.FONT_XTINY, "50", Graphics.TEXT_JUSTIFY_RIGHT);
            // draw dot
            dc.setPenWidth(2);

            // pass 1 - lines only
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            for (var i = 1; i < 7; i++) {
                var prevX = startX + (xSpacing * (i - 1));
                var prevY = chartBottom - (scores[i-1] / 100.0) * chartHeight;
                var x = startX + (xSpacing * i);
                var y = chartBottom - (scores[i] / 100.0) * chartHeight;
                dc.drawLine(prevX, prevY, x, y);
            }

            // pass 2 - dots and labels on top
            for (var i = 0; i < 7; i++) {
                var x = startX + (xSpacing * i);
                var y = chartBottom - (scores[i] / 100.0) * chartHeight;
                if (scores[i] >= 70) {
                    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
                } else if (scores[i] >= 50) {
                    dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
                } else {
                    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
                }
                dc.fillCircle(x, y, 4);
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
                dc.drawText(x, y - 15, Graphics.FONT_XTINY, scores[i].toString(), Graphics.TEXT_JUSTIFY_CENTER);
        }
    }
    function initialize() {
        View.initialize();
    }
    function onLayout(dc as Dc) as Void {}
}
