# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include other modules
      ../modules
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernel = {
      enable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ 
      "i915.force_probe=a7a0" 
    ];
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        theme = pkgs.stdenv.mkDerivation {
          name = "tartarus-grub-theme";
          src = inputs.tartarus-grub;
          installPhase = ''
            cp tartarus -r $out
          '';
        };
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  networking = {
    hostName = "mynixos"; # Define your hostname.

    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true; # Easiest to use and most distros use this by default. 
      plugins = lib.mkForce [];
    };

    # Enable firewall with allowed TCP ports
    firewall = {
      enable = true;
      package = pkgs.nftables;
      allowedTCPPortRanges = [ 
        # the dynamic ports used by KDEConnect
        {from = 1714; to = 1764;}
      ];
      allowedUDPPortRanges = [
        # the dynamic ports used by KDEConnect
        {from = 1714; to = 1764;}
      ];
    };

    # Enable nftables, the newer stuff
    nftables.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
    
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS="1";
      NIXOS_OZONE_WL="1";
      MOZ_ENABLE_WAYLAND = "1";
    };

    systemPackages = with pkgs; [
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      git
      gparted
      mtools
      dosfstools
      xorg.xhost
      sof-firmware
      pciutils
      alsa-tools
      home-manager
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

  # Security
  security = {
  	rtkit.enable = true;
	  polkit.enable = true;
    sudo = {
      enable = true;
      package = pkgs.sudo.override{ withInsults = true; };
      extraConfig = ''
        Defaults insults
      '';
    };
    pam.services = {
      swaylock = {};
    };
  };

  # systemd services
  systemd = {
    user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };

    services.nixos-upgrade.serviceConfig = {
      MemoryHigh = [ "500M" ];
      MemoryMax = [ "2048M" ];

      CPUWeight = [ "20" ];
      CPUQuota = [ "85%" ];
      IOWeight = [ "20" ];
    };
  };
}
