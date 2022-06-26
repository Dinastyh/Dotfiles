{ pkgs, ... }:

{
	description = "Dinasty";	
	isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" "docker" "lxd" "vboxusers" ];
    shell = pkgs.zsh;
}
