{
  description = "i dont know what im doing'";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
    
    # stylix.url = "githun";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    
    in 
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./host/desktop/configuration.nix
          inputs.home-manager.nixosModules.default
        ];   
      };
      home-manager.nixosModules.default = ./home.nix;
      
      # nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      # specialArgs = {inherit inputs;};
      # modules = [
      #   ./configuration.nix
      #   ./host/laptop/hardware-configuration.nix
      #    inputs.home-manager.nixosModules.default
      # ];   
      # }; 
       
    };  
}
