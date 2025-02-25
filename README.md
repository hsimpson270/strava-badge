# Strava Badge

## Overview

This repo contains a GitHub Action that fetches your latest Strava stats and generates a [Shields.io](https://shields.io/) badge that you can add to your Github profile README. The stats update automatically once each day.

## Example

![Strava](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/hsimpson270/strava-badge/main/strava.json&logo=strava&cacheSeconds=60)

To view it in action, [check out my profile](https://github.com/hsimpson270)!

## Setup Instructions

### 1️⃣ &nbsp;Fork This Repo

Click the **"Fork"** button to create your own copy of this repository.

### 2️⃣ &nbsp;Get Your Strava API Credentials

1. Make sure you are logged in to your Strava account and navigate to [Strava API Settings](https://www.strava.com/settings/api).
2. Create a new app. The values to enter into the fields are as follows:

```
Application Name: Github Badge
Category: Other
Website: Na
Description: Show stats in a Github badge.
Authorization Callback Domain: developers.strava.com
```

NOTE: The only required value here to make this work is `Authorization Callback Domain`. The other values can be anything you want them to be.

3. Make note of your **Client ID**, **Client Secret**, and **Refresh Token**. You will need this later.

4. Navigate to your profile to get your **Athlete ID**. You will be able to copy this from the URL. Example: https://www.strava.com/athletes/YOUR_ID

### 3️⃣ &nbsp;Add Secrets to GitHub

1. In your forked repo, navigate to **Settings** → **Secrets and variables** → **Actions**.
2. Click **New Repository Secret** and add the following:
   - `STRAVA_ATHLETE_ID` (technically doesn't need to be secret, but is for consistency's sake)
   - `STRAVA_CLIENT_ID`
   - `STRAVA_CLIENT_SECRET`
   - `STRAVA_REFRESH_TOKEN`

### 4️⃣ &nbsp;Enable GitHub Actions

1. Go to the **Actions** → **General** tab in your repo.
2. Select **Allow {YOUR_USERNAME}, and select non-{YOUR_USERNAME}, actions and reusable workflows**.
3. Check **Allow actions created by GitHub**.
4. Under **Workflow Permissions**, ensure **Read and write permissions** is selected.
5. Make sure everything is saved.

### 5️⃣ &nbsp;Kick off your first workflow

Navigate to **Actions** and then **Update Strava Badge** → **Run workflow**. If successful, you should see a newly generated `strava.json` file in the root of your repo.

### 6️⃣ &nbsp;Add the Badge to Your README

Navigate to your `README.md` file and add the following code. Replace `YOUR_GITHUB_USERNAME` with your actual GitHub username:

```markdown
![Strava](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/strava-badge/main/strava.json&logo=strava&cacheSeconds=86400)
```

## Customization

### Distance Type

By default, this badge will show your running distance, but Strava supports a number of different activities. To update your badge, navigate to `script/fetch-strava.sh` and update everything below line 16 as needed. The full response object from the Strava API is as follows:

```json
{
  "biggest_ride_distance": 0,
  "biggest_climb_elevation_gain": 0,
  "recent_ride_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  },
  "recent_run_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  },
  "recent_swim_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  },
  "ytd_ride_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  },
  "ytd_run_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  },
  "ytd_swim_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  },
  "all_ride_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  },
  "all_run_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  },
  "all_swim_totals": {
    "count": 0,
    "distance": 0,
    "moving_time": 0,
    "elapsed_time": 0,
    "elevation_gain": 0,
    "achievement_count": 0
  }
}
```

NOTE: As of the time of this writing (2-25-25), there is an ongoing issue with the Strava API where some `all_BLANK_totals` may not return their correct values. That is why this repo defaults to `ytd_run_totals`.

### Units

Prefer kilometers instead of miles? Navigate to `scripts/fetch-strava.sh` and update `RUN_DISTANCE` to be divided by `1000` instead of `1609.34`. Don't forget to update `message`!

### Update Frequency

To update how often the action fetches new data from Strava, update the schedule within `.github/workflows/update-strava.yml` to your desired interval. By default, it will update once every day.
