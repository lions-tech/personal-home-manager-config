final: prev:

{
  ciscoPacketTracer8 = prev.callPackage ./pkgs/ciscoPacketTracer8 { };


  dropbox = prev.callPackage ./pkgs/dropbox/default.nix { };

  dropbox-cli = prev.dropbox-cli.overrideAttrs (old:
    let
      version = "2022.12.05";
      dropboxd = "${final.dropbox}/bin/dropbox";
    in
    {
      src = prev.fetchurl {
        url = "https://linux.dropbox.com/packages/nautilus-dropbox-${version}.tar.bz2";
        sha256 = "0asrvvjkjgwnfqlrzk7l8wfwlq2rw5dh6klnpygav9b6dlbi67sc";
      };
      patches = [
        # only apply this patch, as the nautilus patch is not needed for the newer version
        (prev.substituteAll {
          src = ./pkgs/dropbox/fix-cli-paths.patch;
          inherit dropboxd;
        })
      ];
    });
}
