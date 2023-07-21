{
  description = "Personal Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # TODO: contribute fixes to nixpkgs and home-manager
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
        "leonard" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = import ./modules/leonard;
        };

        "manuel" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = import ./modules/manuel;
        };
      };

      leonard = self.homeConfigurations."leonard".activationPackage;
      manuel = self.homeConfigurations."manuel".activationPackage;
      default = self.leonard;
    };
}
