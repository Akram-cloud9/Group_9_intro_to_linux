#!/bin/bash

LOG_DIR="hospital_data/active_logs"
REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/analysis_report.txt"

# Ensure report directory exists
mkdir -p "$REPORT_DIR"

echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
read -p "Enter choice (1-3): " choice

case "$choice" in
  1)
    LOG_FILE="$LOG_DIR/heart_rate.log"
    LOG_NAME="Heart Rate"
    ;;
  2)
    LOG_FILE="$LOG_DIR/temperature.log"
    LOG_NAME="Temperature"
    ;;
  3)
    LOG_FILE="$LOG_DIR/water_usage.log"
    LOG_NAME="Water Usage"
    ;;
  *)
    echo "❌ Invalid choice. Please enter 1, 2, or 3."
    exit 1
    ;;
esac

if [[ ! -f "$LOG_FILE" ]]; then
  echo "❌ Log file not found: $LOG_FILE"
  exit 1
fi

echo "----------------------------------------" >> "$REPORT_FILE"
echo "Analysis Report - $(date)" >> "$REPORT_FILE"
echo "Log Type: $LOG_NAME" >> "$REPORT_FILE"
echo "Log File: $(basename "$LOG_FILE")" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "Device Entry Count:" >> "$REPORT_FILE"
awk '{print $2}' "$LOG_FILE" | sort | uniq -c >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "First Log Entry:" >> "$REPORT_FILE"
head -n 1 "$LOG_FILE" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Last Log Entry:" >> "$REPORT_FILE"
tail -n 1 "$LOG_FILE" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Analysis completed successfully." >> "$REPORT_FILE"

echo "✅ Analysis complete. Results saved to $REPORT_FILE"
