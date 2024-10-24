{
	description = "I don't know what im doing";

  inputs = {
  	# nix os link
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		# home manager links
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  }; # inputs
	
	outputs = { self, nixpkgs, home-manager, ... }: 
		let
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			# system
			nixosConfigurations = {
				goat = lib.nixosSystem { 
					inherit system;
					modules = [ ./configuration.nix ];	
				}; 
			}; 
			
			homeConfigurations = {
				goat = home-manager.lib.homeManagerConfiguration { 
					inherit pkgs;
					modules = [ ./home.nix ];	
				}; 
			};
		}; # let in outputs 

} # flake

## -------- ##
## COMMANDS ##
## -------- ##

## nix flakes ##

# update: nix flake update
# build system: sudo nixos-rebuild switch AND NOW --flake /home/goat/zeige/

## home manager ##

# home-manager switch --flake /home/goat/zeige#goat
