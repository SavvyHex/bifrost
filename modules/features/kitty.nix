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
          cursor_shape beam

          window_margin_width 21.75
          confirm_os_window_close 0

	  map ctrl+plus  change_font_size all +1
	  map ctrl+equal  change_font_size all +1
	  map ctrl+kp_add  change_font_size all +1
	  map ctrl+minus       change_font_size all -1
	  map ctrl+underscore       change_font_size all -1
	  map ctrl+kp_subtract       change_font_size all -1
	  map ctrl+0 change_font_size all 0
	  map ctrl+kp_0 change_font_size all 0
        '';
      };
    };
  };
}
