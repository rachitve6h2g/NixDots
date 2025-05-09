{pkgs, ...}: { 
	imports = [
		./git.nix
		./qutebrowser.nix
		./yazi.nix
	];

        # Misc
        home.packages = with pkgs; [
                trash-cli
        ];
}
