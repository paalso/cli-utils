#!/bin/bash

# preview.sh
# This script prints the first N and last M lines of a file,
# with a message indicating how many lines were skipped in between.
# Usage:
#   ./preview.sh <file> [head_lines] [tail_lines]
# Defaults:
#   head_lines = 5
#   tail_lines = 5
# Help:
#   ./preview.sh --help
#   ./preview.sh -h

# Show help if requested
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo "Usage: $0 <file> [head_lines] [tail_lines]"
  echo
  echo "Prints the first and last lines of a file with a summary of skipped lines."
  echo
  echo "Arguments:"
  echo "  file         Path to the input file"
  echo "  head_lines   Number of lines to show from the top (default: 5)"
  echo "  tail_lines   Number of lines to show from the bottom (default: 5)"
  exit 0
fi

file="$1"
head_lines="${2:-5}"  # Default to 5
tail_lines="${3:-5}"  # Default to 5

# Check if file exists
if [[ ! -f "$file" ]]; then
  echo "Error: File '$file' not found"
  exit 1
fi

total_lines=$(wc -l < "$file")
skip_lines=$((total_lines - head_lines - tail_lines))

# Print lines
if (( skip_lines <= 0 )); then
  cat "$file"
else
  head -n "$head_lines" "$file"
  echo -e "\n... <$skip_lines lines skipped> ...\n"
  tail -n "$tail_lines" "$file"
fi
