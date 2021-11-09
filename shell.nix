{ nixpkgs ? import <nixpkgs> {

    overlays = [
      (self: super: rec {

        # TEMPORARY WORKAROUND
        python39 = super.python39.override {
          packageOverrides = self: super: {
            beautifulsoup4 = super.beautifulsoup4.overrideAttrs (old: {
              propagatedBuildInputs = super.pkgs.lib.remove super.lxml old.propagatedBuildInputs;
            });
          };
        };

        python39Packages = python39.pkgs;

      })
    ];

  }
}:
let

  pythonPackages = nixpkgs.python39Packages;

in
nixpkgs.mkShell {

  buildInputs = [
    pythonPackages.sphinx
    pythonPackages.sphinx-material
  ];

  name = "SADL-Guide";

}
