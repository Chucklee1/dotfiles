{
  description = "i dont know what im doing'";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };      
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # Function for dynamic host profiles
    makeNixosConfig = host: {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/${host}/configuration.nix
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.goat = import ./home.nix;
        }
      ];
    };

  in 
  {
    # specific hosts configs
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem (makeNixosConfig "desktop");
      laptop = nixpkgs.lib.nixosSystem (makeNixosConfig "laptop");
    };
  };
}
# toggleable modules eg:
# options = {
#  module1.enable = lib.mkEnableOption = "enable option 1";
#};

#config = lib.mkIf.config.module1.enable {
# option1 = 5;
# option2 = true;
