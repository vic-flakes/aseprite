{
  description = "A very basic flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }: {
    packages.aarch64-darwin.default = let
      pkgs = (import nixpkgs {
        system = "aarch64-darwin";
        config = { allowUnfree = true; };
        overlays = [
          (final: prev: {
            libdrm = throw "libdrm evaluated";
            valgrind = throw "valgrind evaluated";
          })
        ];
      });
      skia-aseprite = pkgs.callPackage ./skia-aseprite/package.nix { };
    in pkgs.callPackage ./package.nix { skia-aseprite = skia-aseprite; };
  };
}
