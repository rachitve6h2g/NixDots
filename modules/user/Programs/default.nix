{pkgs, ...}: { 
	imports = [
		./btop.nix
		./git.nix
		./qutebrowser.nix
		./yazi.nix
	];

        # Misc
        home.packages = with pkgs; [
                trash-cli
		peaclock
        ];
}
