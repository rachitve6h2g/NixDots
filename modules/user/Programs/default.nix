{pkgs, ...}: {
  imports = [
    ./btop.nix
    ./git.nix
    ./imv.nix
    ./mpv.nix
    ./peaclock.nix
    ./qutebrowser.nix
    ./yazi.nix
  ];

  # Misc
  home.packages = with pkgs; [
    trash-cli

    (uget.override {
	aria2 = pkgs.aria2; 
    })
  ];
}
