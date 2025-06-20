# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8e693011-b67d-4ef7-8f87-0c0d8155db9d";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "autodefrag"
      "discard=async"
      "noatime"
      "ssd"
      "space_cache=v2"
      "compress=zstd"
    ];
  };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/97b579d0-b7c1-4d26-af58-6d4c3e191d38";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/8e693011-b67d-4ef7-8f87-0c0d8155db9d";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "autodefrag"
      "discard=async"
      "noatime"
      "ssd"
      "space_cache=v2"
      "compress=zstd"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/8e693011-b67d-4ef7-8f87-0c0d8155db9d";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "autodefrag"
      "discard=async"
      "noatime"
      "ssd"
      "space_cache=v2"
      "compress=zstd"
    ];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/8e693011-b67d-4ef7-8f87-0c0d8155db9d";
    fsType = "btrfs";
    options = [
      "subvol=swap"
      "autodefrag"
      "discard=async"
      "noatime"
      "ssd"
      "space_cache=v2"
      "compress=zstd"
    ];
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/1387-D87E";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
