{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang-tools
    nixfmt-rfc-style
    nixd
  ];
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;

      # Wheter VSCodium can update/install extensions manually.
      mutableExtensionsDir = false;

      profiles = {
        default = {
          enableExtensionUpdateCheck = true;
          enableUpdateCheck = true;

          extensions = with pkgs.vscode-extensions; [
            foxundermoon.shell-format
            vscodevim.vim
            llvm-vs-code-extensions.vscode-clangd
            jnoortheen.nix-ide
            oderwat.indent-rainbow
            redhat.java
            tamasfe.even-better-toml
            timonwong.shellcheck
          ];

          userSettings = {
            "editor.lineNumbers" = "relative";
            "workbench.iconTheme" = "rose-pine-icons";
            "vim.easymotion" = true;
            "vim.incsearch" = true;
            "vim.useSystemClipboard" = true;
            "vim.hlsearch" = true;
            "vim.insertModeKeyBindings" = [
              {
                "before" = [
                  "j"
                  "j"
                ];
                "after" = [ "Esc" ];
              }
            ];

            "vim.normalModeKeyBindings" = [
              {
                "before" = [ "<Esc>" ];
                "after" = [ ":nohlsearch" ];
              }

              {
                "before" = [ "n" ];
                "after" = [ "nzz" ];
              }

              {
                "before" = [ "N" ];
                "after" = [ "Nzz" ];
              }

            ];

            "redhat.telemetry.enabled" = true;

            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
            "nix.serverSettings" = {
              "nixd" = {
                "formatting" = {
                  "command" = [ "nixfmt" ];
                };

                "options" = {
                  "nixos" = {
                    "expr" = ''(builtins.getFlake "/home/krish/.nixdots").nixosConfigurations.hppavilion.options'';
                  };
                };
              };
            };

            "nix.formatterPath" = "nixfmt";

            # Open git repo in parent folder (don't know what that means):
            "git.openRepositoryInParentFolders" = "always";
          };
        };
      };
    };
  };
}
