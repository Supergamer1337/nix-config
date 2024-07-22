NIX_DIR=$HOME/.nix-config

function sync_user {
    home-manager switch --flake $NIX_DIR#user;
}

function sync_system {
    sudo nixos-rebuild switch --flake $NIX_DIR#system;
}

function update_flake {
    sudo nix flake update $NIX_DIR;
}

function upgrade_system {
    update_flake
    sync_system
    sync_user
}

function gc {
    if [ "$1" = "full" ]; then
        sudo nix-collect-garbage --delete-old;
        nix-collect-garbage --delete-old;
    else
        sudo nix-collect-garbage --delete-older-than $1;
        nix-collect-garbage --delete-older-than $1;
    fi

    # Update the bootloader
    sudo nixos-rebuild boot --flake $NIX_DIR#system
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
elif [ "$1" = "gc" ]; then
    if [ "$#" -gt 2 ]; then
        echo "Warning: The 'gc' command only accepts one argument (collect_older_than)";
    fi

    if [ "$2" = "full" ]; then
        gc "full"
    elif [ "$2" ]; then
        gc $2
    else
        gc "30d"
    fi        
else
    echo "No arguments where supplied."
fi
