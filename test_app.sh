#!/bin/sh

app_name=$(basename "${BASH_SOURCE[0]}" .sh)
full_file_name=$(basename "${BASH_SOURCE[0]}")

# Source the logging script
source ./log_assistant.sh $app_name

# Example usage of the logging functions
info "This is an info message." $full_file_name
warn "This is a warning message." $full_file_name
error "This is an error message." $full_file_name
