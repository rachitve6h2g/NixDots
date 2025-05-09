{pkgs, ...}: {
  home.packages = with pkgs; [wl-clipboard-rs];
  services = {
    cliphist = {
      enable = true;
      allowImages = true;
      extraOptions = [
        "-max-dedupe-search"
        "10"
        "-max-items"
        "500"
      ];
    };
  };
}
