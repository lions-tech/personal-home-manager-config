# My home-manager configuration
This is my personal home-manager configuration.
See it as an example of how to do certain things with home-manager.
You might want to checkout the fixed packages in `pkgs/`.

## Bootstrapping
```
mkdir -p ~/.config/home-manager/
cd ~/.config/home-manager/
git clone https://github.com/lions-tech/personal-home-manager-config.git .
nix run --no-write-lock-file github:nix-community/home-manager/ -- --flake ".#$USER" switch
```
