params ["_vehicle"];

_vehicle setVariable ["GDGM_hasDriver",false,true];

[_vehicle,[
	"<t color='#FFFFFF' size='1.1'><img image='\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\car_ca.paa'></img><t color='#ffd700' size='1.1' font='PuristaBold'> Spawn AI pilot",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script

		[_target] execVM "scripts\addPilot\addPilot.sqf";
	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	false,		// hideOnUse
	"",			// shortcut
	"!(_target getVariable 'GDGM_hasDriver') && player in (crew _target)", 	// condition
	3,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
]] remoteExec ["addAction",0,true];

[_vehicle,[
	"<t color='#FFFFFF' size='1.1'><img image='\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\car_ca.paa'></img><t color='#ffd700' size='1.1' font='PuristaBold'> Delete AI pilot",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script

		deleteVehicle (_target getVariable "GDGM_driver");
		_target setVariable ["GDGM_hasDriver",false,true];
		hint "Conducteur supprimé";
	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"_target getVariable 'GDGM_hasDriver' && player in (crew _target)", 	// condition
	3,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
]] remoteExec ["addAction",0,true];