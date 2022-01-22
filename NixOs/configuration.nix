{ config, pkgs, ... }:

{
	nixpkgs.config = {
		allowUnfree = true;
	};
	imports =
		[ 
		./hardware-configuration.nix
		];

	boot.loader = {
		efi.canTouchEfiVariables = true;
		grub = {
			enable = true;
			version = 2;
			efiSupport = true;
			device = "nodev";
			#configurationLimit = 1;
		};
	};

# Langue
	time.timeZone = "Europe/Amsterdam";
	services.xserver.layout = "us";
	services.xserver.xkbOptions = "eurosign:e";
	i18n.defaultLocale = "en_US.UTF-8"; 

# Network
	networking.hostName = "nix-dinasty";
	networking.useDHCP = false;
	networking.interfaces.eno1.useDHCP = true;	

# Environnement
	services.xserver = {
		enable = true;

		displayManager.gdm.enable = true;
		displayManager.defaultSession = "none+i3";

		windowManager.i3 = {
			enable = true;
			package = pkgs.i3-gaps;
		};

		desktopManager.xterm.enable = false;
		libinput.enable = true;
		videoDrivers = [ "intel" ];
	};

# Enable sound
	sound.enable = true;
	hardware.pulseaudio.enable = true;

# User
	users.users.dinasty = {
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
	};

# Paquet
	environment.systemPackages = with pkgs; 
	[	
		discord
		vim 
		wget
		firefox
		slack	
	];

# SHH
	services.openssh.enable = true;
# Yubikey

	services.udev.packages = [ pkgs.yubikey-personalization ];
	environment.shellInit = ''
		export GPG_TTY="$(tty)"
		gpg-connect-agent /bye
		export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
		'';

	programs = {
		ssh.startAgent = false;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};

	system.stateVersion = "21.11"; 

}

