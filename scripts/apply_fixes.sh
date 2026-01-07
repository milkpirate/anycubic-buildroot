#!/bin/bash
# Get the directory where this script resides
SCRIPT_DIR="$(dirname $(realpath $0))"
SCRIPT_NAME="$(basename $0)"

echo "--- Starting Anycubic Board Fixes ---"

# Use find to locate all executable files in this folder
# excluding this master script itself
for script in $(find "$SCRIPT_DIR" -maxdepth 1 -executable -type f ! -name "$SCRIPT_NAME" | sort); do
    echo "Running: $(basename "$script")"
    "$script"

    if [[ $? != 0 ]]; then
        echo "Error: $(basename "$script") failed. Aborting."
        exit 1
    fi
done

echo "--- All fixes applied successfully ---"
