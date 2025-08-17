#!/usr/bin/env bash

SCRIPT_NAME=$(basename "$0")
RSYNC_OPTS="-avh --progress --stats"
VERSION="1.3"

# =========================
# Function: show usage help
# =========================
show_help() {
    cat <<EOF
${SCRIPT_NAME} — Backup script using rsync with a list of directories

Usage:
  ${SCRIPT_NAME} -l FILE -d DESTINATION [OPTIONS]

Options:
  -l, --list FILE         File containing a list of directories to back up
                          (one path per line, absolute or relative)
  -d, --dest DESTINATION  Target directory for the backup (will be created if missing)
  -o, --options "OPTS"    Additional rsync options (optional, merged with defaults)
  -n, --dry-run           Run in simulation mode (rsync --dry-run), nothing will be copied
  -v, --version           Show script version
  -h, --help              Show this help message

Example:
  ${SCRIPT_NAME} -l folders.txt -d /mnt/backup
  ${SCRIPT_NAME} -l folders.txt -d /mnt/backup -n
EOF
}

# =========================
# Function: show version
# =========================
show_version() {
    echo "${SCRIPT_NAME} v${VERSION}"
}

# =========================
# Function: run backup with rsync
# =========================
run_backup() {
    local list_file="$1"
    local dest_dir="$2"
    local rsync_opts="$3"

    # Check that the list file exists
    if [[ ! -f "$list_file" ]]; then
        echo "Error: list file not found: $list_file" >&2
        exit 1
    fi

    # Create destination directory if it does not exist
    if [[ ! -d "$dest_dir" ]]; then
        echo "Target directory does not exist, creating: $dest_dir"
        mkdir -p "$dest_dir" || { echo "Error: failed to create $dest_dir" >&2; exit 1; }
    fi

    # Run rsync for each line in the list file
    while IFS= read -r src; do
        # Skip empty lines or comments starting with #
        [[ -z "$src" || "$src" =~ ^# ]] && continue

        if [[ ! -d "$src" ]]; then
            echo "Warning: source directory does not exist, skipping: $src" >&2
            continue
        fi

        echo "Backing up: $src -> $dest_dir"
        rsync $rsync_opts "$src" "$dest_dir"
        echo "----------------------------------------"
    done < "$list_file"
}

# =========================
# Argument parsing
# =========================
LIST_FILE=""
DEST_DIR=""
CUSTOM_OPTS="$RSYNC_OPTS"
DRY_RUN_MODE=0

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -l|--list)
            [[ -z "$2" ]] && { echo "Error: missing file path after $1" >&2; exit 1; }
            LIST_FILE="$2"
            shift 2
            ;;
        -d|--dest)
            [[ -z "$2" ]] && { echo "Error: missing destination after $1" >&2; exit 1; }
            DEST_DIR="$2"
            shift 2
            ;;
        -o|--options)
            [[ -z "$2" ]] && { echo "Error: missing options string after $1" >&2; exit 1; }
            CUSTOM_OPTS="$CUSTOM_OPTS $2"
            shift 2
            ;;
        -n|--dry-run)
            DRY_RUN_MODE=1
            shift 1
            ;;
        -v|--version)
            show_version
            exit 0
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown parameter: $1" >&2
            show_help
            exit 1
            ;;
    esac
done

# =========================
# Validate required arguments
# =========================
if [[ -z "$LIST_FILE" || -z "$DEST_DIR" ]]; then
    echo "Error: both --list and --dest must be provided" >&2
    show_help
    exit 1
fi

# =========================
# Enable dry-run if requested
# =========================
if [[ "$DRY_RUN_MODE" -eq 1 ]]; then
    echo "Dry-run mode enabled (no data will be copied)"
    CUSTOM_OPTS="$CUSTOM_OPTS --dry-run"
fi

# =========================
# Start backup
# =========================
run_backup "$LIST_FILE" "$DEST_DIR" "$CUSTOM_OPTS"
