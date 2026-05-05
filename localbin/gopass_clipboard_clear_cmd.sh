#!/bin/bash

# 1. Run the search and store the output
# We use "$1" to pass the search term from this script to the dms command
SEARCH_RESULTS=$(dms clipboard search "$1")

# 2. Extract the last ID
# We look for lines starting with "ID:", take the last one, 
# and extract the number before the first pipe.
LAST_ID=$(echo "$SEARCH_RESULTS" | grep "^ID:" | tail -n 1 | awk -F'[:|]' '{print $2}' | xargs)

# 3. Check if an ID was actually found
if [[ -n "$LAST_ID" ]]; then
    echo "Deleting last ID found: $LAST_ID"
    dms clipboard delete "$LAST_ID"
else
    echo "No ID found for search term: $1"
fi
