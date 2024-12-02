### When installing a new version always remember to change the system.stateVersion number
After installing the system
1. Update to a nixos-unstable channel
2. Enable root user to use GUI applications using xhost (see the ArchWiki for this)

# Notes #
- There is an error in Thunar: "cannot find archive manager" when opening an Archive file.
- Need to do a thorough reading of all the Nix
- Need to set up a notification for low battery power
- Can install nix-colors which will help to rice nix from just one configuration file (Done)
    - Should also try Stylix
- Swaync configuration has not worked for the wifi button (Probably wouldn't need it after setting up AGS)
- Enable wlogout (Done) 
- Learn CSS for ricing waybar (Almost done)
- Waybar bluetooth module should show bluetooth symbol and battery of the bluetooth device (not set up yet) (Not needed after AGS setup)
- Configure AGS (learn javascript & typescript for that)
- Learn Bashscript in Nix syntax
- Configure QuteBrowser keymaps and keybinds 
- Configure mpv and mpv-mpris
- Learn to make btrfs using disko, enable impermanence
- Set user.js for mozilla
- Set search.engines for Mozilla firefox
*** Must learn how to use nixpkgs overlays ***

### Not needed after ags setup ###
- Waybar
- Swaync

***In case home manager fails***
```
$journalctl --unit home-manager.service
```
*will show what actually is happening*
