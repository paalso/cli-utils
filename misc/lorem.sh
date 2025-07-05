#!/usr/bin/env bash

# Fake lorem generator — supports units: words, sentences, paragraphs

show_help() {
  echo "Usage: $0 [--count N] [--units words|sentences|paragraphs]"
  echo
  echo "Options:"
  echo "  --count N          Number of units to generate (default: 1)"
  echo "  --units TYPE       Type of text: words, sentences, or paragraphs (default: paragraphs)"
  echo "  -h, --help         Show this help message and exit"
}

# Default values
count=1
units="paragraphs"

# Parse args
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --count) count="$2"; shift ;;
    --units) units="$2"; shift ;;
    -h|--help) show_help; exit 0 ;;
    *) echo "Unknown option: $1"; show_help; exit 1 ;;
  esac
  shift
done

# Static lorem sample
lorem="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor."

generate() {
  for ((i = 0; i < count; i++)); do
    case $units in
      words)
        echo "$lorem" | tr ' ' '\n' | head -n "$count" | tr '\n' ' '
        echo
        break
        ;;
      sentences)
        echo "$lorem" | grep -o '[^\.!?]*[\.!?]' | head -n 1
        ;;
      paragraphs)
        echo "$lorem"
        echo
        ;;
      *)
        echo "Unsupported unit type: $units"
        exit 1
        ;;
    esac
  done
}

generate
