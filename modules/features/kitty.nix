{ ... }: {
  flake.nixosModules.kitty = { pkgs, ... }: {
    fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

    home-manager.users.savvyhex = { pkgs, ... }: {
      programs.kitty = {
        enable = true;
        font.name = "JetBrainsMono Nerd Font";
        extraConfig = ''
          include current-theme.conf

          cursor_trail 1
          cursor_trail_decay 0.1 0.4
          cursor_trail_start_threshold 2
        '';
      };
    };
  };
}
