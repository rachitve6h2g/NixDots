{ pkgs, ... }: {
	services.wlsunset = {
		enable = true;
		package = pkgs.wlsunset;
		
		sunset = "18:00";
		sunrise = "08:00";
		temperature = {
			day = "7000";
			night = "5000";
		};
	};
}
