class DailyMetrics {
    var rhr;
    var bodyBattery;
    var hrvTier;
    var timestamp;

    function initialize(rhr, bodyBattery, hrvTier, timestamp) {
        me.rhr = rhr;
        me.bodyBattery = bodyBattery;
        me.hrvTier =hrvTier;
        me.timestamp = timestamp;
    }
}
