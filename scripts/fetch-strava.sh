#!/bin/bash

# Exit on error
set -e

# Get new Strava access token
ACCESS_TOKEN=$(curl -s -X POST https://www.strava.com/oauth/token \
  -d client_id=$STRAVA_CLIENT_ID \
  -d client_secret=$STRAVA_CLIENT_SECRET \
  -d refresh_token=$STRAVA_REFRESH_TOKEN \
  -d grant_type=refresh_token | jq -r '.access_token')

# Fetch athlete stats
STATS=$(curl -s -H "Authorization: Bearer $ACCESS_TOKEN" https://www.strava.com/api/v3/athletes/$STRAVA_ATHLETE_ID/stats)

# Extract distance in meters
# NOTE: Change this property to whatever you would like
DISTANCE=$(echo $STATS | jq -r '.ytd_run_totals.distance')

# Convert meters to miles
# NOTE: Change to 1000 if KM is preferred
CONVERTED_DISTANCE=$(echo "$DISTANCE / 1609.34" | bc -l)

# Format to 2 decimal places
FORMATTED_DISTANCE=$(printf "%.2f" $CONVERTED_DISTANCE)

# Get current year
# NOTE: Can be removed if not showing ytd stats
YEAR=$(date +"%Y")

# Create JSON output for Shields.io
# NOTE: Change verbiage to your desired output. label will be what is shown on the left side of the badge and message will be shown on the right side.
cat <<EOF > strava.json
{
  "schemaVersion": 1,
  "label": "$YEAR Distance Ran",
  "message": "$FORMATTED_DISTANCE miles",
  "color": "#FC4C02"
}
EOF
