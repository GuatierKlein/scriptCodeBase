params["_objFrom", "_objTo", "_name"];

_objFrom addAction
[
	_name,
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_caller setPosASL getPosASL (_this select 3);
	},
	_objTo,
	1.5,
	true,
	true,
	"",
	"true",
	5,
	false,
	"",
	""
];