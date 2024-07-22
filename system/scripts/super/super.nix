{ pkgs, userSettings, ... }:
let myScript = ''
    if [ "$1" = "sync" ]; then
        if [ "$#" = 1 ]; then
            ''+userSettings.nixFilesDir+''/system/scripts/super/helpers/sync.sh;
            exit 0;
        elif [ "$2" = "user" ]; then
            ''+userSettings.nixFilesDir+''/system/scripts/super/helpers/sync-user.sh;
            exit 0;
        elif [ "$2" = "system" ]; then
            ''+userSettings.nixFilesDir+''/system/scripts/super/helpers/sync-system.sh;
            exit 0;
        else
            echo "Please pass a 'system' or 'user' if supplying a second argument"
        fi
    fi
'';
in
{
    environment.systemPackages = [
        (pkgs.writeScriptBin "super" myScript)
    ];
}