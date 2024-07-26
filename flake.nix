{
  description = "Personal Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import ./overlays.nix) ];
      };
    in
    {
      homeConfigurations = {
        # TODO: nix-ld-rs - might fix VirtualBox
        "leonard" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = import ./modules/leonard;
        };
      };
      leonard = self.homeConfigurations."leonard".activationPackage;
    };
}
