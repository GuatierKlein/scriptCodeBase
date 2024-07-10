systemChat "Changing kit...";

_index = lbCurSel 240411;
if (_index != -1 ) then {
	_kit_unit = available_kits select _index;
	[_kit_unit] call BAR_fnc_setKit;		
	call BAR_fnc_applyKit;
	closeDialog 0;
};