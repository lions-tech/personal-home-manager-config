# My home-manager configuration
This is my personal home-manager configuration.
See it as an example of how to do certain things with home-manager.
You might want to checkout the fixed packages in `pkgs/`.

## Bootstrapping
Be sure to be in a graphical environment and run these commands:
```bash
nix run github:nix-community/home-manager/ -- init --switch
cd ~/.config/home-manager
rm *
git clone https://github.com/lions-tech/personal-home-manager-config .
# uncomment ciscoPacketTracer8 in modules/leonard/home.nix
home-manager switch
# before starting the systemd user services
dropbox start
```
