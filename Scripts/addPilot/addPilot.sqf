params ["_veh"];

//mettre [this] execVM "scripts\addPilot\addPilotAction.sqf" dans l'init du véhicule
//mannequin pour l'équipement du pilot
_kit_used = kit_crew;
//classname du pilot
_baseUnit = "B_Soldier_F";

if(!isNull (driver _veh) && alive (driver _veh)) exitwith {hint "Place conducteur déjà occupée"};

if(isNull (driver _veh)) then {
	deleteVehicle (driver _veh);
};

_grpEQUI = createGroup west;
_crewDriver = _grpEQUI createUnit [_baseUnit, [0,0], [], 0, "NONE"]; hint "Conducteur d'engin créé";
_crewDriver setUnitLoadout getUnitLoadout _kit_used;
_crewDriver moveInDriver _veh;
_crewDriver disableAI "ALL";

_veh setVariable ["GDGM_driver",_crewDriver,true];
_veh setVariable ["GDGM_hasDriver",true,true];
_crewDriver setVariable ["GDGM_linkedVeh",_veh,true];
_crewDriver addEventHandler ["GetOutMan",{deleteVehicle (_this select 0); hint "Conducteur d'engin supprimé";}];
_crewDriver addEventHandler ["SeatSwitchedMan",{deleteVehicle (_this select 0); hint "Conducteur d'engin supprimé";}];

_crewDriver addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	(_unit getVariable "GDGM_linkedVeh") setVariable ["GDGM_hasDriver",false,true];
}];


