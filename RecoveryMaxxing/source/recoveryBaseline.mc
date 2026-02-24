using Toybox.Math as Math;

class recoveryBaseline {
    var _metrics;

    // array of daily metrics
    function initialize() { _metrics = []; }
    // function to store day
    function addDay(rhr, bodyBattery, hrvTier, timestamp) {
        _metrics.add(new DailyMetrics(rhr, bodyBattery, hrvTier, timestamp));
    }

    // get n last days
    function getLastNdays(n) {
        var count = _metrics.size();
        if (count == 0) {return [];}
        var start = count > n ? count - n : 0;
        return _metrics.slice(start, count);
    }
    // get the mean
    function getMean(field) {
        var recentDays = getLastNdays(28);
        var values = new [recentDays.size()];
        for (var i = 0; i < recentDays.size(); i++) {
            values[i] = recentDays[i][field];
        }
        return Math.mean(values);
    }

    // do standard dev of last 28 days
    function getStandardDev(field) {
        var recent = getLastNdays(28);
        var values = new [recent.size()];

        if (recent.size() == 0) {
            return null;
        }

        for (var i = 0; i < recent.size(); i++) {
            values[i] = recent[i][field];
        }
        return Math.stdev(values, null);
    }
}
