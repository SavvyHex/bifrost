{ self, inputs, ... }: {
  flake.nixosModules.thorConfiguration = { config, pkgs, lib, ... }: {
    imports = [ 
      self.nixosModules.thorHardware
      self.nixosModules.niri
      self.nixosModules.ly
      self.nixosModules.docker
    ];

    boot.loader = {
      systemd-boot.enable = false;

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };

      efi = {
        canTouchEfiVariables = true;
      };
    };

    networking.hostName = "thor";
    networking.wireless.enable = true;

    networking.networkmanager.enable = true;

    networking.firewall.allowedTCPPorts = [ 20128 20129 20132 ];

    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemu.swtpm.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    programs.virt-manager.enable = true;

    time.timeZone = "Asia/Kolkata";

    i18n.defaultLocale = "en_IN";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    users.users."savvyhex" = {
      isNormalUser = true;
      description = "Saketh Sunil Pai";
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "kvm" ];
      packages = with pkgs; [];
    };

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    environment.systemPackages = with pkgs; [
      vim 
      wget
      python3
      git
      tree
      uv
      easyeffects
      yt-dlp
      blueman
      swaylock
      swayidle
      mission-center
      networkmanagerapplet
      awww
      jq
      glib
      gtk3
      gtk4
      gsettings-desktop-schemas
      coreutils
      bash
      vscode
      nautilus
      claude-code
      freerdp
      virt-manager
      dnsmasq
      steam

      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

      adwaita-icon-theme
      papirus-icon-theme
      hicolor-icon-theme
    ];

    programs.steam.enable = true;

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];

    fonts.packages = with pkgs; [
      material-symbols
      nerd-fonts.jetbrains-mono   
    ];

    environment.variables.GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    environment.variables.LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
    ]; 

    programs.dconf.enable = true;

    # Audio — required for easyeffects, volume keybinds, and the Volume widget
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Battery reporting — required for the battery widget to show a percentage
    services.upower.enable = true;

    services.openssh.enable = true;

    system.stateVersion = "26.05";
  };
}