{ ... }: {
  flake.nixosModules.kitty = { pkgs, ... }: {
    fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

    home-manager.users.savvyhex = { pkgs, ... }: {
      programs.kitty = {
        enable = true;
        font.name = "JetBrainsMono Nerd Font";
        extraConfig = ''
          include current-theme.conf
        '';
      };
    };
  };
}
