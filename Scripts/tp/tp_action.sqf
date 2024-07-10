_object = _this select 0;

_object addAction
[
	"<t color='#FFFFFF' size='1.1'><img image='\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\walk_ca.paa'></img><t color='#ffd700' size='1.1' font='PuristaBold'> Se téléporter",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script
		[_caller] execVM "scripts\tp\open_TP.sqf";
	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	5,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];
