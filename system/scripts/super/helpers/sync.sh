#!/bin/bash

# Script to synchronize system and user state 

# Sync system
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

$SCRIPT_DIR/sync-system.sh
$SCRIPT_DIR/sync-user.sh