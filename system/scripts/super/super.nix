{ pkgs, userSettings, ... }:
let superScript = builtins.readFile ./super.sh;
in
{
    environment.systemPackages = [
        (pkgs.writeScriptBin "super" superScript)
    ];
}