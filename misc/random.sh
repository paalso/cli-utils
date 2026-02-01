#!/usr/bin/env bash
#
# random.sh — generate a random integer.
# Usage:
#   random.sh                # prints a random number (default behavior)
#   random.sh MAX            # prints a random integer between 0 and MAX (inclusive)
#   random.sh MIN MAX        # prints a random integer between MIN and MAX (inclusive)
#

show_help() {
  cat <<EOF
Usage: $(basename "$0") [MIN] MAX
Generate a random integer.

  No arguments       – prints a random integer (default behavior, see note below).
  One argument MAX   – prints an integer in the range [0..MAX].
  Two arguments MIN MAX – prints an integer in the range [MIN..MAX].

Examples:
  $(basename "$0")         →  15724
  $(basename "$0") 10      →  1..10
  $(basename "$0") 5 15    →  5..15

Note:
  Uses Bash builtin \$RANDOM, which yields 0..32767 uniformly.
EOF
}

# If help requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# Decide bounds
if [[ $# -eq 0 ]]; then
  min=0
  max=32767
elif [[ $# -eq 1 ]]; then
  min=1
  max=$1
elif [[ $# -eq 2 ]]; then
  min=$1
  max=$2
else
  echo "Error: wrong number of parameters" >&2
  show_help >&2
  exit 1
fi

# Validate min/max
if ! [[ "$min" =~ ^-?[0-9]+$ && "$max" =~ ^-?[0-9]+$ ]]; then
  echo "Error: min and max must be integers" >&2
  exit 1
fi

if (( max < min )); then
  echo "Error: max < min" >&2
  exit 1
fi

# Generate
# Use Bash builtin $RANDOM (0–32767)
# Formula: min + RANDOM % (max - min + 1)
range=$(( max - min + 1 ))
rand=$(( RANDOM % range + min ))
echo "$rand"
