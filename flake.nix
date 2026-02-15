{
  description = "Cupcake - The User Friendly NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home Manager for user-level configuration
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Plasma Manager for declarative KDE configuration
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/default/default.nix
          ./modules

          # Home Manager as NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            home-manager.extraSpecialArgs = {
              inherit inputs;
              mactahoe-gtk-theme = nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/mactahoe-gtk-theme.nix {};
              mactahoe-icon-theme = nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/mactahoe-icon-theme.nix {};
              plasma-manager = inputs.plasma-manager;
            };

            home-manager.users.cupcake = import ./hosts/default/home.nix;
          }
        ];
      };
    };
    
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      nativeBuildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        git
        just
        neovim
      ];
      
      shellHook = ''
        echo "🍎 Welcome to Cupcake Dev Environment!"
        echo "Run 'just vm' to test the system in QEMU."
        
        # Alias nix to always use experimental features in this shell
        alias nix="nix --extra-experimental-features 'nix-command flakes'"
      '';
    };
  };
}
