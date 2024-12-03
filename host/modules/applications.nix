{
	config,
	lib,
	pkgs,
	...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    wl-clipboard # Clipboard provider for nixvim in privileged directories
  ];

  # For better gnome/gtk theming effects
  programs = {
    dconf.enable = true;
  };
}
