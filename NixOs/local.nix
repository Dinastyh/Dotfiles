{ ... }:

{
    imports = [
        ./crinasty.nix
		./hardware-configuration.nix
    ];
    
	system.stateVersion = "22.05"; 
}
