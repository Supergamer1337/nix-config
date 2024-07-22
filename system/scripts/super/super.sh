DIRECTORY=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ "$1" = "sync" ]; then
    if [ "$#" = 1 ]; then
        $DIRECTORY/helpers/sync.sh;
        exit 0;
    elif [ "$2" = "user" ]; then
        $DIRECTORY/helpers/sync-user.sh;
        exit 0;
    elif [ "$2" = "system" ]; then
        $DIRECTORY/helpers/sync-system.sh;
        exit 0;
    else
        echo "Please pass a 'system' or 'user' if supplying a second argument"
    fi
fi