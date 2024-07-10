params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

call BAR_fnc_applyKit;

if(!isNil "BAR_enableCustomKitOnRespawn") then {
	if(BAR_enableCustomKitOnRespawn) then {
		player setUnitLoadout BAR_customKit;
	};
};

waitUntil { !isNull player };

player addAction
[
	"<t color='#0044c2'>Arty menu</t>",	// title
	{
		execVM "scripts\arty\arty_openmenu.sqf";
	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"backpack player == 'B_radioBag_01_mtp_F'", 	// condition
	5,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];


