{
  description = "Personal Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = { self, nixpkgs, home-manager, mac-app-util }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ (import ./overlays.nix) ];
      };

      pkgs-mac = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
        overlays = [ (import ./overlay-darwin.nix) ];
      };
    in
    {
      homeConfigurations = {
        # TODO: nix-ld-rs - might fix VirtualBox
        "leonard" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = import ./modules/leonard;
        };

        "leonardm" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-mac;
          modules = import ./modules/leonardm ++ [ mac-app-util.homeManagerModules.default ];
        };
      };
      leonard = self.homeConfigurations."leonard".activationPackage;
    };
}
