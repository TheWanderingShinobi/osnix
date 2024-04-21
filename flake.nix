{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    sddm-sugar-candy-nix = {
    url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };


    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    sddm-sugar-candy-nix,

    ...
  }: 
    let
      user = "keeper";
    in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self user;};
      modules = [
        ./hosts/laptop/system/configuration.nix
#        ./hosts/laptop/system/battery.nix
#        ./hosts/laptop/system/virtualisation.nixosModules
        home-manager.nixosModules.home-manager
        sddm-sugar-candy-nix.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.keeper = import ./hosts/laptop/config/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs self user;};
        }
      ];
    };
  };
}
