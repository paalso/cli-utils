#!/bin/bash

#==================[ Configuration ]==================#
declare -A LIBRESPEED_SERVERS=(
  [69]="Vilnius, Lithuania (RackRay)"
  [74]="Poznan, Poland (INEA) (https://speedtest.kamilszczepanski.com)"
  [79]="Prague, Czech Republic (CESNET) (http://speedtest.cesnet.cz)"
  [85]="Prague, Czech Republic (Turris) (http://librespeed.turris.cz)"
  [28]="Nuremberg, Germany (1) (Hetzner)"
)

LOG_FILE="$HOME/.local/share/netlog/speedtest_log.csv"
LOCATION_FILE="$HOME/.current_location"
SERVER_ID=74

#==================[ Functions ]==================#

print_help() {
  cat <<EOF
Usage: log-speed.sh

Measures internet speed using librespeed CLI and logs results to CSV.

CSV columns:
location,server_id,timestamp,duration_sec,download_mbps,upload_mbps
EOF
}

run_test() {
  local tmpfile=$(mktemp)

  START_TIME=$(date +%s)
  script -q -c "     -server $SERVER_ID" "$tmpfile"
  END_TIME=$(date +%s)
  DURATION=$((END_TIME - START_TIME))

  DOWNLOAD=$(awk -F': *' '/Download rate/ {print $2}' "$tmpfile" | awk '{print $1}')
  UPLOAD=$(awk -F': *' '/Upload rate/ {print $2}' "$tmpfile" | awk '{print $1}')
  rm -f "$tmpfile"
}

log_result() {
  mkdir -p "$(dirname "$LOG_FILE")"
  if [[ ! -f "$LOG_FILE" ]]; then
    echo "location,server_id,timestamp,duration_sec,download_mbps,upload_mbps" > "$LOG_FILE"
  fi
  echo "$LOCATION,$SERVER_ID,$TIMESTAMP,$DURATION,$DOWNLOAD,$UPLOAD" >> "$LOG_FILE"
}

main() {
  if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    print_help
    exit 0
  fi

  if [[ ! -f "$LOCATION_FILE" ]]; then
    echo "❌ Location file not found: $LOCATION_FILE"
    echo "Set it like: echo flat_gosprom > $LOCATION_FILE"
    exit 1
  fi

  LOCATION=$(cat "$LOCATION_FILE")
  TIMESTAMP=$(date -Iseconds)
  NOW_HUMAN=$(date '+%Y-%m-%d %H:%M:%S')
  SERVER_NAME="${LIBRESPEED_SERVERS[$SERVER_ID]}"

  echo ""
  echo "═══════════════════════════════════════════════════════════════════════"
  echo "🟡 Starting speed test @ $NOW_HUMAN"
  echo "📡 Trying with server $SERVER_ID: $SERVER_NAME"
  echo "═══════════════════════════════════════════════════════════════════════"

  run_test

  if [[ -z "$DOWNLOAD" || -z "$UPLOAD" ]]; then
    echo "⚠️  Speed test failed or output not recognized"
    exit 1
  fi

  log_result

  echo "✅ Speed test logged:"
  echo "📍 Location: $LOCATION"
  echo "🌍 Server:   $SERVER_NAME"
  echo "⏰ Time:     $TIMESTAMP"
  echo "⏱️ Duration: ${DURATION}s"
  echo "📥 Download: $DOWNLOAD Mbps"
  echo "📤 Upload:   $UPLOAD Mbps"
}

#==================[ Entry Point ]==================#
main "$@"
