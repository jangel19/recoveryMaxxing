using Toybox.Math as Math;

function clamp(val, low, high) {
    if (val < low) { return low; }
    if (val > high) { return high; }
    return val;
}
function max(a, b) {
    return (a > b) ? a : b;
}

function min(a, b) {
    return (a < b) ? a : b;
}

function calculateRecScore(todayRHR, rhrMean, rhrStd, bodyBatteryWake, hrv_tier) {
    // prevent divide by 0
    rhrStd = max(rhrStd, 1.0);


    // get raw z scores of the 28 basleine
    var rhr_z = (todayRHR - rhrMean) / rhrStd;
    var hrv_z = 1.0;// idk how to do this yet

    // clamp to precent anomaly
    rhr_z = clamp(rhr_z, -3.0, 3.0);
    hrv_z = 1.0;

    // have ot invert the z score because lower rhr is better
    // 70 is neutral
    var raw_rhr_score = 70 - (rhr_z * 15);

    // calmp to scale
    var rhr_score = clamp(raw_rhr_score, 0.0, 100.0);

    // using garmins hrv (not gonna get approved an im not a enterprise dev)
    var hrv_score;
    if (hrv_tier == "Optimal") {
    if (hrv_z > 2.0) {
        // we are using a bell curve to penalize teh extreme changes
        hrv_score = 10.0;
    } else {
        hrv_score = 100.0;
    }
    } else if (hrv_tier == "Good") {
        hrv_score = 85.0;
    } else if (hrv_tier == "Balanced") {
        hrv_score = 60.0;
    } else if (hrv_tier == "Poor") {
        hrv_score = 10.0;
    } else {
        // this is the fallback if tier is missing
        hrv_score = 100.0 * Math.pow(2.71828, -0.5 * Math.pow((hrv_z - 0.5) / 1.0, 2.0));
        hrv_score = clamp(hrv_score, 10.0, 100.0);
    }
    // over training override
    if (hrv_score <= 20 && rhr_z <= -1.0) {
        rhr_score = 10.0; // makes sure we dont reward low rhr
    }
    // cap the hrv if bb is low to avoid an inflated score
    if (bodyBatteryWake < 25 && hrv_score > 60) {
        hrv_score = min(hrv_score, 75);
    }

    var bb_score = clamp(bodyBatteryWake, 0.0, 100.0);

    // final score heh
    var final_score = (hrv_score * 0.50) + (rhr_score * 0.25) + (bb_score * 0.25);

    final_score = clamp(final_score, 0.0, 100.0);

    return Math.round(final_score);
}
