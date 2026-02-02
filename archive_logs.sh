#!/bin/bash

LOG_DIR="hospital_data/active_logs"

echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

case $choice in
  1)
    log="heart_rate_log.log"
    archive_dir="hospital_data/heart_data_archive"
    archive_prefix="heart_rate"
    ;;
  2)
    log="temperature_log.log"
    archive_dir="hospital_data/temperature_data_archive"
    archive_prefix="temperature"
    ;;
  3)
    log="water_usage_log.log"
    archive_dir="hospital_data/water_usage_data_archive"
    archive_prefix="water_usage"
    ;;
  *)
    echo "Invalid choice"
    exit 1
    ;;
esac

if [[ ! -f "$LOG_DIR/$log" ]]; then
  echo "Log file does not exist: $LOG_DIR/$log"
  echo "Tip: Run 'python3 heart_rate_monitor.py start' first."
  exit 1
fi

mkdir -p "$archive_dir" || { echo "Archive directory error"; exit 1; }

archive_name="${archive_prefix}_${timestamp}.log"

mv "$LOG_DIR/$log" "$archive_dir/$archive_name"

touch "$LOG_DIR/$log"

echo "Successfully archived to $archive_dir/$archive_name"
