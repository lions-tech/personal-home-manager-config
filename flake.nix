{
  description = "Personal Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # TODO: add cmdtime-plugin
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      zshCustomPlugins = [ ];

      customOverlays = import ./overlays.nix;

      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ customOverlays ];
      };
    in
    {
      homeConfigurations."leonard" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = import ./modules;

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
