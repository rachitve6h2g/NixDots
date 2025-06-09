{ pkgs, ... }:
{
  programs.cmus = {
    enable = true;
    theme = "rose-pine";
  };
  xdg.configFile."cmus/rose-pine.theme".source = (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/Iorvethe/cmus/refs/heads/main/src/rose-pine.theme";
      hash = "sha256-T6GSfDfoR6cjPIUdWW8pPahgh1echWBiX/ZBcx5LsU4=";
    }
  );
}
