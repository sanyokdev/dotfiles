#!/bin/bash

# Logging
function LogDefault() {
    echo -e "$1"
}

function LogInfo() {
    echo -e "\e[1m\e[34m$1\e[0m"
}

function LogSuccess() {
    echo -e "\e[1m\e[32m$1\e[0m"
}

function LogError() {
    echo -e "\e[1m\e[31mError:\e[0m $1"
    exit 1
}

show_wait_error=false
function LogErrorWait() {
    echo -e "\e[1m\e[31mError:\e[0m $1"
    show_wait_error=true
}

function CheckGlobalVar() {
    local var_value="$(eval echo \$$1)"

    if [ -z "$var_value" ]; then
        LogErrorWait "CheckGlobalVar: '$1' environment variable not found!"
    fi
}

# Sync the selected aws s3 bucket
function SyncBucket() {
    local aws_source="$1"
    local aws_destination="$2"

    if [ -z "$1" ]; then
        LogError "SyncBucket: No source provided! (arg-1)"
    elif [ -z "$2" ]; then
        LogError "SyncBucket: No destination provided! (arg-2)"
    else
        local aws_cmd="aws s3 sync $aws_source $aws_destination --profile $S3_PROFILE --endpoint-url=$S3_ENDPOINT --delete"

        LogInfo "=== Syncing with AWS bucket ==="
        LogInfo "Command:"
        LogDefault "$aws_cmd"

        LogInfo "\nExecuting dry run!"
        eval "$aws_cmd --dryrun" >/dev/null
        exit_status=$?

        if [ $exit_status -eq 0 ]; then
            LogDefault "dry run completed successfully!"

            LogInfo "\nExecuting full run!"
            eval "$aws_cmd"
            LogSuccess "Sync complete!"
        else
            LogError "aws_cmd failed :("
        fi
    fi
}

# Global environment variable checks
CheckGlobalVar "S3_PROFILE"
CheckGlobalVar "S3_ENDPOINT"

CheckGlobalVar "S3_DIR_PERSONAL"
CheckGlobalVar "S3_URL_PERSONAL"

CheckGlobalVar "S3_DIR_DEVELOPMENT"
CheckGlobalVar "S3_URL_DEVELOPMENT"

if [ "$show_wait_error" = true ]; then
    exit 1
fi

# Script logic & error checks
error_msg="Use 'personal' or 'development' to sync their respective s3 buckets."
if [ "$#" -eq 0 ]; then
    LogError "No arguments provided: $error_msg" 

elif [ "$#" -eq 1 ]; then
    if [ "$1" = "personal" ]; then
        SyncBucket $S3_DIR_PERSONAL $S3_URL_PERSONAL
    elif [ "$1" = "development" ]; then
        SyncBucket $S3_DIR_DEVELOPMENT $S3_URL_DEVELOPMENT
    else
        LogError "Unsupported option: $error_msg" 
    fi

elif [ "$#" -gt 1 ]; then
    LogError "Too many arguments: $error_msg" 
fi
