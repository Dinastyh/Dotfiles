{ pkgs, lib, ... }:
{
	imports = [ ./desktop.nix ];

	networking = 
	{
		useNetworkd = true;
		hostName = "nix-dinasty";
		useDHCP = false;
	}; 

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
		layout = "us";
		xkbVariant = "altgr-intl";
	};

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

	boot.loader = {
		efi.canTouchEfiVariables = true;
		grub = {
			enable = true;
			version = 2;
			efiSupport = true;
			device = "nodev";
			configurationLimit = 1;
		};
		systemd-boot.enable = false;

	}; 

#Faut bouger ca mais flemme pour le moment
	environment.systemPackages = with pkgs; 
	[	
		vim 
			wget
			firefox
			slack
			k3s
			zsh
			wget
			polybar
			vscode
			virt-manager
			minecraft
			openstackclient

			(python38.withPackages(p: with p; [psutil]))

			jdk11
			flameshot
			terraform
			killall
			argocd
			arandr
			teams
			pavucontrol
			jetbrains.idea-ultimate
			jetbrains.clion
			clang
			clang-tools
			gnumake
			neovim
			nodejs
			virtualbox
			discord
			alacritty
			teamspeak_client
			feh
			git
			htop
			thunderbird
			yubikey-manager-qt
			];

#override vi and vim command
	nixpkgs.overlays = [
		(self: super: {
		 neovim = super.neovim.override {
		 viAlias = true;
		 vimAlias = true;
		 };
		 })
	];
	environment.variables.EDITOR = "nvim";
#services.k3s.enable = true;

	fonts.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" ]; })
	]; 
}
