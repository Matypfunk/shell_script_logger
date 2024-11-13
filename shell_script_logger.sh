#!/bin/sh

# Call function to retrieve the timestamp in epoch format
create_timestamp() {
    echo $(date +%s)
}

# Call function to generate a full log entry as JSON
generate_log_entry() {
    local level=$1
    local message="$2"
    local timestamp=$(create_timestamp)

    echo "{\"timestamp\":$timestamp, \"loglevel\":\"$level\", \"message\":\"$message\"}"
}


# Call function to log a message with the specified level
log_message() {
    local level=$1
    local message=$2
    local full_file=$3

    # Set IFS (Internal Field Separator) to comma for splitting
    IFS='.' read -r -a values <<< "$full_file"

    # Print the elements of the array
    base_file="${values[0]}"

    # Reset IFS to default value after use
    IFS=' '

    if [ -z "$message" ]; then
        echo "Message cannot be empty"
        return 1
    fi

    local log_file="./$base_file/$3.log"
    
    # Create log file if it does not exist
    touch "$log_file"

    local log_entry=$(generate_log_entry $level "$message")
    
    # Write the log entry to the dynamically named log file
    echo $log_entry >> "$log_file"
    
    return 0
}

# Generate an info message in the log
info() {
    log_message "info" "$1" "$2"
}

# Generate an warn message in the log
warn() {
    log_message "warn" "$1" "$2"
}

# Generate an error message in the log
error() {
    log_message "error" "$1" "$2"
}

# Call function to initialize log directory
initialize_log_directory() {
    local app_name="$1"
    
    # Create the log directory if it does not exist
    if ! mkdir -p "./$app_name"; then
        echo "Error: Could not create log directory for $app_name" >&2
        return 1
    fi
    
    echo "Log directory initialized successfully."
}

# Start here Main
main() {
    local app_name="${1:-$(basename "${BASH_SOURCE[0]}" .sh)}"
    
    # Check if app_name is set and the log directory does not exist
    if [[ -n "$app_name" && ! -d "./$app_name" ]]; then
        initialize_log_directory "$app_name"
    else
        echo "Log directory already exists or app_name is not provided."
    fi
}

# Check if script was sourced or executed directly and handle arguments accordingly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    app_name=$(basename "${BASH_SOURCE[0]}" .sh)
    # When the script is executed directly, process command-line arguments
    main "$app_name"
else
    # When the script is sourced, set app_name based on filename
    app_name="$1"
    
    if [[ -n "$1" ]]; then
        readonly SOURCED_ARG="$1"
        echo "Sourced argument passed: ${SOURCED_ARG}"
    else
        echo "No argument passed to sourced script."
    fi
    
    # Call main function with the derived app_name when sourced
    main "${app_name}"
fi
