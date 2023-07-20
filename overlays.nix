final: prev:

{
  ciscoPacketTracer8 = prev.callPackage ./pkgs/ciscoPacketTracer8 { };

  dropbox = prev.callPackage ./pkgs/dropbox/default.nix { };

  dropbox-cli = prev.callPackage ./pkgs/dropbox/cli.nix { };

  wallpapers = prev.callPackage ./pkgs/wallpapers { };
}
