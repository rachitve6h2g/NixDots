let
  myShellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    svi = "sudo vim";
    syscon = "cd /etc/nixos/";
    update = "sudo nixos-rebuild switch";
    backit = "cp -r /etc/nixos/* /home/chris/.dotfiles/NixDots/";
  };
  extraRc = ''
    export WLR_NO_HARDWARE_CURSORS="1";

    # Start the SSH agent if it's not already running
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)" > /dev/null
    fi

    # Add SSH key only if it's not already added
    if ! ssh-add -l | grep -q "$(ssh-keygen -lf ~/.ssh/id_ed25519 | awk '{print $2}')"; then
        ssh-add ~/.ssh/id_ed25519 > /dev/null
    fi

    function yy() {
    	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    	yazi "$@" --cwd-file="$tmp"
    	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    		builtin cd -- "$cwd"
    	fi
    	rm -f -- "$tmp"
    }
  '';
in
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion = {
        enable = true;
        strategy = [ "completion" ];
      };
      cdpath = [
        "/etc/nixos/"
        "/home/chris"
      ];
      history.size = 100;

      oh-my-zsh = {
        enable = true;
        theme = "junkfood";
        plugins = [
          "git"
          "emotty"
          "emoji"
          "sudo"
          "colored-man-pages"
          "colorize"
        ];
      };

      shellAliases = myShellAliases;

      initExtra = extraRc;
    };

    bash = {
      enable = true;
      shellAliases = myShellAliases;
      initExtra = extraRc;
    };
  };
}