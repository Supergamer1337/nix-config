NIX_DIR=$HOME/.nix-config

function sync_user() {
    home-manager switch --flake $NIX_DIR#user;
}

function sync_system() {
    sudo nixos-rebuild switch --flake $NIX_DIR#system;
}

function update_flake() {
    sudo nix flake update $NIX_DIR;
}

function upgrade_system() {
    update_flake
    sync_system
    sync_user
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
elif [ "$1" = "update" ]; then
    update_flake
elif [ "$1" = "upgrade" ]; then
    upgrade_system
else
    echo "No arguments where supplied."
fi
