{
  description = "eastxuelian's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    patch4pwn = {
      url = "github:AvavaAYA/autopatch-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lianvim-banner = {
      url = "github:AvavaAYA/lianvim-banner";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pwndbg = {
      url = "github:pwndbg/pwndbg";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      nixorb = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.eastxuelian = import ./home.nix;

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}

