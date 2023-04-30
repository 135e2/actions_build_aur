#!/bin/bash

# Convert seconds into other formats
function time_parser() {
    local input_seconds=$1
    local hours=$((input_seconds / 3600))
    local seconds=$((input_seconds % 3600))
    local minutes=$((seconds / 60))
    seconds=$((input_seconds % 60))

    printf "%02d:%02d:%02d\n" $hours $minutes $seconds
}
