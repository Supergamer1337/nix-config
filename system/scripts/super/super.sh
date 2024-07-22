if [ "$1" = "sync" ]; then
    if [ "$#" = 1 ]; then
        ${dirname $0}/helpers/sync.sh;
        exit 0;
    elif [ "$2" = "user" ]; then
        ${dirname $0}/helpers/sync-user.sh;
        exit 0;
    elif [ "$2" = "system" ]; then
        ${dirname $0}/helpers/sync-system.sh;
        exit 0;
    else
        echo "Please pass a 'system' or 'user' if supplying a second argument"
    fi
fi