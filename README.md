# shell_script_logger
## Description: 
- This tool would be used within a Bourne-Again Shell/Shell script to provide a quick logging mechanism for your shell program/application/script. This is in development and not thoroughly tested so use at your own risk 

## Features:
### Initializes directory to write logs, as well as, log file: 
- Initializes a directory in the working directory of the parent script named "parent_app_name.sh" without the extention. 
 - i.e.
  - parent_app_name
### Generates JSON format logs: 
- Provides a constructor to generate a log entry in JSON format.
 - Params
  - level
   - indicates the logging level. this is currently not used for any filtering yet.
  - message
   - the information you would like to have the shell_script_logger to write to the log event
  - full_file
   - the $full_file_name on dependencies location
- i.e.
 - info "informational message here" $full_file_name
- Sample:
 - "{\"timestamp\":$timestamp, \"loglevel\":\"$level\", \"message\":\"$message\"}"


## Dependencies:
- Bash Version: 
 - Tested on BASH 3.2.57
- Two global variables must be passed to the parent app before the source:
 - app_name=$(basename "${BASH_SOURCE[0]}" .sh)
 - full_file_name=$(basename "${BASH_SOURCE[0]}")


## Installation
- Clone the repository:
 - git clone https://github.com/username/project-name.git
- Navigate to shell_script_logger:
 - cd shell_script_logger
- Make the script executable:
 - chmod +x shell_script_logger.sh

## Usage
- Source code in other shell script:
 - \# Source the logging script
    source ./shell_script_logger.sh $app_name

    info "This is an info message." $full_file_name
    warn "This is a warning message." $full_file_name
    error "This is an error message." $full_file_name


## Environment Variables
- N/A

## Logging
- Path to log: 
 - ./$app_name/$app_name.sh.log
- Formats:
 - json

## Contributing
Please feel free to. Follow these steps:

### Fork the project:
- Create a new branch 
 - git checkout -b feature/new-feature
- Commit your changes 
 - git commit -m 'Add new feature'
- Push to the branch 
 - git push origin feature/new-feature
- Open apull request.

## License
None - Use at your own risk. This code is as is and has been only tested on a handful of platforms. Please exercise caution when executing or at bare minimum try to understand what you are adding to your application.

## Acknowledgments
Thank you for those who inspired me to get something out there. I hope you all get some use out of this :)

