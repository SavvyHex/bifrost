{ config, inputs, ... }: {
  flake.nixosModules.inir = { pkgs, ... }: {
    imports = [ inputs.inir.nixosModules.inir ];

    programs.inir = {
      enable = true;
      service.compositor = "niri";
      extraPackages = [ config.programs.niri.package ];
    };
  };
}
