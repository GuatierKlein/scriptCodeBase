_unit = _this select 0;

//creer un marker GDGM_camKit pour positionner la camera

available_kits = [
	kit_ne,
	kit_rifle,
	kit_medic,
	kit_eng,
	kit_radio
]; //mettre ici les noms des mannequins, laissez kit_ne pour le kit sans equipement car il 
//est referencé à d'autre endroit dans le code et causera des erreurs d'initalisation de variable si supprimé

_available_kits_name = [
	"Sans équipement",
	"Fusilier",
	"Medic",
	"Sapeur",
	"Radio (menu arty)"
]; //ici les noms d'affichages dans la liste (même ordre que les mannequins)

//NE PAS MODIFIER EN DESSOUS
KIT_unit = _unit;
createDialog "dialogKitSelect";

_animArray = [
	"Acts_Ambient_Relax_4",
	"Acts_Ambient_Relax_3",
	"Acts_Ambient_Relax_2"
];

{
	private _name = _x;
	private _dummy = available_kits select _foreachindex;
	lbAdd [240411,_name];
} foreach _available_kits_name;


//create mannequin
private _unitCreated = "C_man_1" createVehicleLocal (getMarkerPos "GDGM_camKit");
private _attachLogic = "Logic" createVehicle (getMarkerPos "GDGM_camKit");

_unitCreated attachTo [_attachLogic];
_unitCreated setDir 180;
_unitCreated disableAI "MOVE";
_unitCreated disableAI "AUTOCOMBAT";
_unitCreated disableAI "FSM";
_unitCreated disableAI "RADIOPROTOCOL";
_unitCreated allowDamage false;
_unitCreated setUnitLoadout (getUnitLoadout (player getVariable "BAR_kit"));
_unitCreated setDir 180;
_unitCreated switchMove selectRandom _animArray;

//cam stuff 
private _camera = "camera" camCreate (position _unitCreated);
_camera camPrepareTarget _unitCreated;
_camera camCommitPrepared 0; // needed for relative position
_camera camPrepareRelPos [0, 2.3, 1.5];
_camera camPrepareTarget ((getPos _unitCreated) vectorAdd [1,0,1.2]);
_camera cameraEffect ["internal", "back"];
_camera camCommitPrepared 0;

private _lightSource = "#lightpoint" createVehicleLocal ((getPosASL _camera) vectorAdd [0, 0, 2]);
_lightSource setLightBrightness 8;
_lightSource setLightIntensity 3000;
_lightSource setLightColor [0.25, 1, 1];
_lightSource setLightAmbient [1, 1, 1];

waitUntil { sleep 0.2; lbCurSel 240411 != -1 || !dialog};
if(!dialog) exitwith {
	_camera cameraEffect ["terminate", "back"];
	camDestroy _camera;
	deleteVehicle _unitCreated;
};

_index = lbCurSel 240411;
_kit_unit = available_kits select _index;
_actualKitUnit = _kit_unit;

while {dialog} do {
	_unitCreated hideObject false;
	_index = lbCurSel 240411;
	_kit_unit = available_kits select _index;	
	//demo unit
	_unitCreated setUnitLoadout (getUnitLoadout _kit_unit);

	if(_actualKitUnit != _kit_unit) then {
		_actualKitUnit = _kit_unit;
		_unitCreated switchMove selectRandom _animArray;
	};
	//get inventory
	_weapon = primaryWeapon _kit_unit;
	_uniform = uniform _kit_unit;
	_secondary_weapon = secondaryWeapon _kit_unit;
	_handgun = handgunWeapon _kit_unit;
	//get pics
	_picture_prim = getText (configFile >> "CfgWeapons" >> _weapon >> "picture");
	_picture_sec = getText (configFile >> "CfgWeapons" >> _secondary_weapon >> "picture");
	_picture_hg = getText (configFile >> "CfgWeapons" >> _handgun >> "picture");
	_picture_uni = getText (configFile >> "CfgWeapons" >> _uniform >> "picture");
	//set pics
	ctrlSetText [240413,_picture_prim];
	ctrlSetText [240412,_picture_sec];
	ctrlSetText [240414,_picture_hg];
	ctrlSetText [240415,_picture_uni];
	sleep 0.1;
};

_camera cameraEffect ["terminate", "back"];
camDestroy _camera;
deleteVehicle _unitCreated;
deleteVehicle _attachLogic;
deleteVehicle _lightSource;

