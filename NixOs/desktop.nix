{ pkgs, modulesPath, ... }:

{
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot.kernelPackages = pkgs.linuxPackages_latest;

	sound.enable = true;
	hardware.pulseaudio = {
		enable = true;
		package = pkgs.pulseaudioFull;
	};

	services = {
		printing.enable = true;

		xserver = {
			enable = true;

			layout = "us";
			xkbOptions = "eurosign:e";

			displayManager.gdm.enable = true;
		};

		geoclue2.enable = true;
	};
	
	services.openssh.enable = true;
	virtualisation.libvirtd.enable = true;
	programs.dconf.enable = true;
	users.users.dinasty.extraGroups = [ "libvirtd" ];

	environment.systemPackages = with pkgs; [ firefox virt-manager ];
}
