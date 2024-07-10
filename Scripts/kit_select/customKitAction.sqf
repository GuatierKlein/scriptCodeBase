_object = _this select 0;

_object addAction
[
	"<t color='#FFFFFF' size='1.1'><img image='\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\backpack_ca.paa'></img><t color='#ffd700' size='1.1' font='PuristaBold'> Sauvegarder son équipement</t>",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script
		BAR_customKit = getUnitLoadout player;
		hint "Equipement sauvegardé";
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

_object addAction
[
	"<t color='#FFFFFF' size='1.1'><img image='\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\backpack_ca.paa'></img><t color='#ffd700' size='1.1' font='PuristaBold'> Récupérer équipement sauvegardé</t>",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script
		player setUnitLoadout BAR_customKit;
		hint "Equipement chargé";
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