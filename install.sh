#!/usr/bin/env nix-shell
#!nix-shell -p git -p neovim
#!nix-shell -i bash

# Automatied installation of nix-config

# Clone files
git clone https://github.com/SuperGamer1337/nix-config.git ./nix-config

# Give some information that the scirpt can use when generating the initial configuration
echo "Installing new system..."
echo "What is the name of the machine?"
read MACHINE_NAME

# Check if machine name is already in flake, if so, use the existing configuration
if ! grep -q "$MACHINE_NAME = lib.nixosSystem {" ./nix-config/flake.nix; then

echo "What is the full name of the user? [Default: Felix Bjerhem Aronsson]"
read FULL_NAME
echo "What is the username? [Default: felbjar]"
read USERNAME
echo "What is the email? [Default: felix.b.aronsson@gmail.com]"
read EMAIL
echo "What is the configuration directory? [Default: ~/.nix-config]"
read CONFIG_DIR

if [ -z "$FULL_NAME" ]; then
        FULL_NAME="Felix Bjerhem Aronsson"
fi
if [ -z "$USERNAME" ]; then
        USERNAME="felbjar"
fi
if [ -z "$EMAIL" ]; then
        EMAIL="felix.b.aronsson@gmail.com"
fi

# Get the current state version from /etc/nixos/configuration.nix
STATE_VERSION=$(grep -oP 'system.stateVersion = "\K[^"]+' /etc/nixos/configuration.nix)

# Set the nix-config directory
if [ -z "$CONFIG_DIR" ]; then
        NIX_CONFIG_DIR=/home/$USERNAME/.nix-config
else
        NIX_CONFIG_DIR=$CONFIG_DIR
fi

echo "The following information will be used to generate the initial configuration:"
echo "Machine name: $MACHINE_NAME"
echo "Full name: $FULL_NAME"
echo "Username: $USERNAME"
echo "Email: $EMAIL"
echo "State version: $STATE_VERSION"
echo "Configuration directory: $NIX_CONFIG_DIR"

# Ask the user if they want to continue
read -p "Do you want to continue? [Y/n] " CONTINUE
if [ "$CONTINUE" = "n" ]; then
        echo "Aborting installation..."
        exit 1
fi

mkdir "$(dirname "$NIX_CONFIG_DIR")"

mv ./nix-config/ $NIX_CONFIG_DIR/

# Add the machine to the list of hosts
echo "Adding $MACHINE_NAME to the list of hosts..."
mkdir -p $NIX_CONFIG_DIR/hosts/$MACHINE_NAME

# Generate the hardware configuration for the new system
nixos-generate-config --show-hardware-config > $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/hardware-configuration.nix

# Copy the template configuration to the new machine
cp $NIX_CONFIG_DIR/hosts/TEMPLATE/configuration.nix $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/configuration.nix

# Remove the #% comments
sed -i "s/#%//g" $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/configuration.nix

# Replace the variables in the configuration
sed -i "s/%MACHINE_NAME%/$MACHINE_NAME/g" $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/configuration.nix
sed -i "s/%FULL_NAME%/$FULL_NAME/g" $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/configuration.nix
sed -i "s/%USERNAME%/$USERNAME/g" $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/configuration.nix
sed -i "s/%EMAIL%/$EMAIL/g" $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/configuration.nix
sed -i "s/%STATE_VERSION%/$STATE_VERSION/g" $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/configuration.nix

# Add the machine to the flake 
MACHINE_FLAKE_CONTENTS=$(cat "$NIX_CONFIG_DIR/flake.nix" | awk '
/^\s*TEMPLATE = lib\.nixosSystem \{/ { 
    in_block = 1 
    brace_count = 1 
    print
    next
}
in_block {
    print
    if (/{/ && !/}/) brace_count++
    if (/}/ && !/{/) brace_count--
    if (brace_count == 0) { 
        in_block = 0 
    }
}' | sed -E -e "s/TEMPLATE/$MACHINE_NAME/g")

# Update flake with new contents
temp_file=$(mktemp)

awk -v MACHINE_FLAKE_CONTENTS="$MACHINE_FLAKE_CONTENTS" '
$0 ~ /TEMPLATE = lib\.nixosSystem \{/ {
    print MACHINE_FLAKE_CONTENTS 
    print "" # Print a newline
}
{ print }
' "$NIX_CONFIG_DIR/flake.nix" > "$temp_file"

mv "$temp_file" "$NIX_CONFIG_DIR/flake.nix"

# Open configuration.nix in the editor, so the user can edit it (if they want to)
"${EDITOR:-nano}" $NIX_CONFIG_DIR/hosts/$MACHINE_NAME/configuration.nix

# Add the new files to git, so that they can be used by the flake.
cd $NIX_CONFIG_DIR
git add .

else
  echo "Machine name already in flake, using existing configuration..."
fi

# Rebuild and switch to the new system 
nixos-rebuild switch --flake $NIX_CONFIG_DIR#$MACHINE_NAME

echo "Installation complete!"

echo "Rebooting in"
echo "5 seconds..."
sleep 1
echo "4 seconds..."
sleep 1
echo "3 seconds..."
sleep 1
echo "2 seconds..."
sleep 1
echo "1 second..."
sleep 1
shutdown -r now