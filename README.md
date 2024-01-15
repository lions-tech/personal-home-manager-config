# My home-manager configuration

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

## Resources

These are the repos I've learned and copied from.

Thank You!

- [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [saimoomedits/eww-widgets](https://github.com/saimoomedits/eww-widgets)
- [EliverLara/terminator-themes](https://github.com/EliverLara/terminator-themes/tree/master/schemes)

