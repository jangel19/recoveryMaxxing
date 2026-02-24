# RecoveryMaxxing

A Garmin Connect IQ watch app that gives you a daily recovery score. Built because WHOOP is expensive, their new algorithm has been getting criticized, and their Training Readiness feature is centered around workouts rather than actual physiological recovery. This is my attempt at building something better and open.

## What it does

Opens to a recovery ring (0-100) showing your daily score with green/yellow/red zones. Swipe down to see a 7-day sparkline of your recovery history. The score is calculated from HRV Status, Body Battery, and resting heart rate deviation against your personalized 28-day rolling baseline.

## How the algorithm works

The score is a weighted composite of three inputs pulled from Garmin's sensors:

- HRV Status (50% weight) — converted from Garmin's 4-tier system using a bell curve that peaks at your personal baseline and penalizes both ends. Importantly, paradoxically high HRV is penalized rather than rewarded, since this is a known marker of overtraining syndrome where the autonomic nervous system overcorrects.
- Body Battery on wake (25% weight) — Garmin's proprietary metric already incorporates overnight HRV and sleep quality via Firstbeat's algorithm, so this acts as a proxy for sleep even though Garmin does not expose raw sleep stage data to third-party apps.
- RHR deviation (25% weight) — Z-scored against a 28-day rolling baseline. The score is inverted since lower RHR is better. A day where your RHR is 2 standard deviations below your baseline pushes your score up, not down.

The algorithm also includes an overtraining detection override: if HRV is suppressed (or paradoxically elevated) while RHR is abnormally low simultaneously, the algorithm flags this as a likely OTS pattern and does not reward the low RHR as if it were positive.

The double penalty problem is handled with a decorrelation buffer: if Body Battery is very low but HRV reads as Good, the HRV contribution is capped to prevent the two conflicting inputs from averaging out to a falsely inflated score.

## Recovery zones

- Green: 70 and above — ready to train hard
- Yellow: 50 to 69 — moderate readiness, consider lighter load
- Red: below 50 — prioritize recovery

## Supported devices

Forerunner 255, Forerunner 265, Forerunner 955, Forerunner 965, Forerunner 970, Venu 3S, and other devices running Connect IQ API 5.0 or above.

## What is still being built

Right now the score and chart run on placeholder data. The next steps are:

1. Connect real sensor data from Garmin's SensorHistory API (Body Battery, heart rate history for RHR)
2. Persist the 28-day rolling baseline using Application.Storage so it survives between sessions
3. Register a background wake event so the score calculates automatically each morning without needing to open the app

## Stack

Monkey C, Garmin Connect IQ SDK 8.4, built and tested in the Connect IQ simulator.

## Background

I built this as a CS and Applied Mathematics sophomore at UMass Lowell. The algorithm design was informed by research on how WHOOP, Oura, and Polar approach recovery scoring, including Firstbeat's EPOC methodology, Polar's Nightly Recharge framework, and published studies on HRV as a recovery marker. I came from WHOOP and wanted something I could actually trust and share with friends without anyone paying a subscription.
