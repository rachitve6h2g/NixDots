{ pkgs, ... }:
{
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep-all;
    arguments = [
      "--max-columns-preview"
      "--colors=line:style:bold"
      "--hidden"
      "--smart-case"
    ];
  };
}
