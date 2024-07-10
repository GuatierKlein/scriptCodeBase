//clientside
params["_unit","_name"];

private _baseUnit = "B_Soldier_F";

[
	_unit,
	("Recruit " + _name),
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3", 
	"_caller distance _target < 3",
	{},
	{},
	{ 
		params ["_target", "_caller", "_actionId", "_arguments"];
		[_target] execVM "scripts\AIRecruit\spawnRecruit.sqf";
	},
	{},
	[], 
	1, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;