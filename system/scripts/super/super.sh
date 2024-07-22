function sync_user() {
    home-manager switch --flake $HOME/.nix-config#user;
}

function sync_system() {
    sudo nixos-rebuild switch --flake $HOME/.nix-config#system;
}


# Structure of running the correct function
if [ "$1" = "sync" ]; then
    if [ "$#" = 1 ]; then
        sync_system
        sync_user
        exit 0;
    elif [ "$2" = "user" ]; then
        sync_user
        exit 0;
    elif [ "$2" = "system" ]; then
        sync_system
        exit 0;
    else
        echo "Please pass a 'system' or 'user' if supplying a second argument"
    fi
else
    echo "No arguments where supplied."
fi
