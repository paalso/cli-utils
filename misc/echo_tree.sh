#!/bin/bash

# echo_tree.sh - 
#Script to recursively print the contents of files within a directory.
# Usage: echo_tree.sh [--no-parent] <directory>
#   --no-parent: Exclude the parent directory path from the printed file paths.
#   <directory>: The directory whose contents need to be printed.
#
# Example usage:
#   echo_tree.sh python-project-lvl1
#   echo_tree.sh --no-parent python-project-lvl1

function echo_tree_content() {
    local path=$1
    local base_path=$2

    for entry in "$path"/*; do
        if [[ -f "$entry" ]]; then
            echo -e "\n# ${entry#$base_path/}\n"
            cat "$entry"
            echo -e "\n-----\n"
        elif [[ -d "$entry" ]]; then
            echo_tree_content "$entry" "$base_path"
        fi
    done
}

if [[ "$1" == "--no-parent" ]]; then
    shift
    no_parent="--no-parent"
else
    no_parent=""
fi

if [[ -d "$1" ]]; then
    echo_tree_content "$1" "$1" "$no_parent"
else
    echo "Usage: $0 [--no-parent] <directory>"
fi

