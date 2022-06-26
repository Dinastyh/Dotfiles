{ pkgs, ...}:

{
	imports = [
		./local.nix
	];

	console = {
		font = "Lat2-Terminus16"; 
	};

	time.timeZone = "Europe/Paris";

	users.users.dinasty = import ./dinasty.nix { inherit pkgs; };

	virtualisation.docker.enable = true;

	environment.systemPackages = with pkgs; [ vim git ];
	nixpkgs.config.allowUnfree = true;

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
		zsh = {
			ohMyZsh = {
				enable = true;
				plugins = [ "git" ];
				theme = "robbyrussell";
			};

			enable = true;
		};
	};

}
