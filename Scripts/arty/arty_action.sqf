_object = _this select 0;

_object addAction
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
	"true", 	// condition
	5,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];