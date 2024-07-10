_object = _this select 0;

_object addAction
[
	"<t color='#FFFFFF' size='1.1'><img image='\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\backpack_ca.paa'></img><t color='#ffd700' size='1.1' font='PuristaBold'> Recevoir son paquetage</t>",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script
		[_caller] execVM "Scripts\kit_select\open_kitSelectMenu.sqf";
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