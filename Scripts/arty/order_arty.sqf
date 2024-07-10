//clientside
_adj_pos = [0,0,0];

//recup la pos grid
_x_coord = ctrlText 040512;
_y_coord = ctrlText 040513;

_pos_grid = _x_coord + _y_coord;

_realPosition = _pos_grid call BIS_fnc_gridToPos;

_pos = _realPosition select 0;
_pos_real = [_pos select 0,_pos select 1,0];

//adjust pos
_dist = ctrlText 040518;
_dist = parseNumber _dist;
_angle = ctrlText 040519;
_angle = parseNumber _angle;

if (_angle != 0 || _dist != 0) then {
	_logic = createAgent ["Logic", _pos_real, [], 0, "FORM"];
	_adj_pos = _logic getRelPos [_dist, _angle];
	deleteVehicle _logic;
} else {
	_adj_pos = _pos_real;
};

//arty fire
_index = lbCurSel 040514;
_index_ammo = lbCurSel 040516;

_shots = ctrlText 040515;
_shots = parseNumber _shots;

_ammo = (((GDGM_artillery_names_array select _index) select 1) select _index_ammo) select 0;
_ammo_display = (((GDGM_artillery_names_array select _index) select 1) select _index_ammo) select 1;

// private _points = [side player] call GDGM_fnc_getPoints;
// if(_shots / 2 > _points) exitWith {hint "Not enough points"};

if (_shots != 0 && _x_coord != "000" && _y_coord != "000") then {
	// [player, getMissionPath "Sounds\Voices\arty_request.ogg"] remoteExec ["say3D", 0];
	player sideRadio "radio_arty_request";
	[player,"Requesting artillery at grid " + _pos_grid] remoteExec ["globalChat",0];
	sleep 3;
	[player,str _shots + " shots of " + _ammo_display] remoteExec ["globalChat",0];
	sleep 20;
	[west, "Base"] sideRadio "radio_arty_computing";
	sleep 40;

	[west, "Base"] sideRadio "radio_arty_incoming";
	sleep 20;

	private _volley = floor(_shots / 4);
	private _rest = _shots % 4;

	for [{private _i = 0}, {_i < _volley}, {_i = _i + 1}] do {
		[_adj_pos, _ammo, 20, 4, 0.25] spawn BIS_fnc_fireSupportVirtual;
		sleep (5 + floor(random 2));
	};
	sleep (5 + floor(random 2));
	[_adj_pos, _ammo, 20, _rest, 0.25] spawn BIS_fnc_fireSupportVirtual;
	[west, "Base"] sideRadio "radio_arty_roundsOver";
} else {
	systemChat "Shots and coordinates can't be 0";	
};



