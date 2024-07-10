params["_dummy"];

private _className = typeOf _dummy;
private _loadout = getUnitLoadout _dummy;
private _unitTraits = getAllUnitTraits _dummy;

private _newUnit = group player createUnit [_className, position player, [], 0, "FORM"];
//loadout
_newUnit setUnitLoadout _loadout;

//set units trait 
{
	_newUnit setUnitTrait [_x select 0, _x select 1]
} foreach _unitTraits;

//rank 
_newUnit setRank (rank _dummy);

//skills 
_newUnit setSkill (skill _dummy);

//GDGM specific
_newUnit setVariable ["GDGM_owner", side _newUnit];

_newUnit addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if(!isServer) exitWith {};

	[_unit getVariable "GDGM_owner", -1] call GDGM_fnc_addReserves;
}];	