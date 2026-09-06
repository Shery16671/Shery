# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page,
# on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
# Enable the Fish shell module
programs.fish = {
  enable = true;
  interactiveShellInit = ''
    set -g fish_greeting ""
  '';
};
  # ===========================================================================
  # 1. HARDWARE & SYSTEM IMPORTS
  # ===========================================================================
  imports = [
    # Includes the hardware scan results (CPU, drives, graphics)
    ./hardware-configuration.nix
  ];

  # Bootloader setup (UEFI / systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow proprietary/unfree software (like Steam)
  nixpkgs.config.allowUnfree = true;

  # Enable 32-bit hardware acceleration for your AMD Radeon Vega integrated graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable experimental features (Flakes & new CLI)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable Bluetooth hardware support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # ===========================================================================
  # 2. NETWORKING & LOCALIZATION
  # ===========================================================================
  networking.hostName = "shery"; # Define your hostname
  networking.networkmanager.enable = true; # Easily connect to Wi-Fi via KDE applet

  # Time zone and internationalization settings
  time.timeZone = "Asia/Karachi";
  i18n.defaultLocale = "en_US.UTF-8";

  # ===========================================================================
  # 3. DESKTOP ENVIRONMENT & SERVICES
  # ===========================================================================
  # Enable X11 / Wayland display server infrastructure
  services.xserver.enable = true;

  # Enable KDE Plasma 6 Desktop Environment and SDDM Display Manager
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable PipeWire sound architecture (Replaces legacy PulseAudio)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Flatpak support
  services.flatpak.enable = true;

  # Enable Printing support (CUPS)
  services.printing.enable = true;

  # Enable touchpad support
  services.libinput.enable = true;

  # ===========================================================================
  # 4. USER ACCOUNTS & PERMISSIONS
  # ===========================================================================
  users.users.shery = {
    isNormalUser = true;
    description = "shery";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish; # Added here!
  };

  # ===========================================================================
  # 5. SPECIAL PROGRAM MODULES
  # ===========================================================================
  # Programs configured via specific NixOS options (Handles firewall/libs automatically)
  programs.firefox.enable = true;
  programs.dms-shell.enable = true;

 # Enable Niri Window Manager
programs.niri.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # ===========================================================================
  # 6. SYSTEM PACKAGES
  # ===========================================================================
  # Standalone CLI tools, desktop apps, and graphical programs
  environment.systemPackages = with pkgs; [
    # Terminal Utilities
	wget
	git
	fastfetch
	htop
	kitty
	wine	
	ani-cli
	mpv
	fzf
	git
	fish
	nix-search-cli
	xwayland-satellite
	cava
	yt-dlp

     # Text Editors
	nano
	neovim
	ripgrep
  	fd
  	gcc
	unzip
	micro

    # Desktop Applications
	pkgs.prismlauncher
	vlc
	discord
	spotify
 	lutris
	
	
	
  ];

  # ===========================================================================
  # 7. SYSTEM STATE VERSION
  # ===========================================================================
  # Do not change this value after installation. Read manual for details.
  system.stateVersion = "26.05";
}
