let
  inputs = import ./.tack;
in
  import (inputs.nixpkgs + "/nixos/lib/eval-config.nix") {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./nixos.nix
      ./hardware.nix
    ];
  }
