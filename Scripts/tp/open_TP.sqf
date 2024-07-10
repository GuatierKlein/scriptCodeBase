GDGM_allowTPNearEnnemies = false; // true -> on peut se tp si des ennemis sont proches du joueur cible
_unit = _this select 0;

createdialog "dialogTeleport";

_headlessClients = entities "HeadlessClient_F";
_humanPlayers = allPlayers - _headlessClients;

_display = findDisplay 17041;
_display setVariable ["GDGM_unit_to_tp", _unit];

allPlayersArray = [];

//remplissage liste
{
	lbAdd [170411, name _x];
	allPlayersArray pushBack _x;
} foreach _humanPlayers;

//teleport button

waitUntil { sleep 0.2; lbCurSel 170411 != -1 };

buttonSetAction [170412, "
	[] spawn GDGM_fnc_tpToPlayer;
"];

GDGM_fnc_tpToPlayer = {	
	_target_unit = objnull;
	_display = findDisplay 17041;
	_unit_to_tp = _display getVariable 'GDGM_unit_to_tp';	
	_index = lbCurSel 170411;
	_target_unit = allPlayersArray select _index;
	private _nearestBaddies = _target_unit nearEntities [["Man", "Car", "Tank", "Motorcycle"], 125];

	if((_nearestBaddies findIf {side _x != side _target_unit && side _x != civilian}) != -1 && !GDGM_allowTPNearEnnemies) exitWith {
		hint "Ennemis trop proche de la cible";
	};

	closeDialog 0;

	//cam up 
	private _camera = "camera" camCreate [0, 0, 0];
	_camera camPrepareTarget player;
	_camera camCommitPrepared 0; // needed for relative position
	_camera camPrepareRelPos [0, 0, 2];
	_camera cameraEffect ["internal", "back"];
	_camera camCommitPrepared 0;
	waitUntil { camCommitted _camera };

	_camera camPrepareRelPos [0, 0, 500];
	_camera camCommitPrepared 3;
	waitUntil { camCommitted _camera };
	titleCut ["", "BLACK", 2];
	sleep 2;

	//cam down 
	titleText ["Transport en cours...","PLAIN",5];
	titleFadeOut 2;
	sleep 5;
	//tp 
	_camera camPreparePos ((getPosASL _target_unit) vectorAdd [0,0,500]);
	_camera camPrepareTarget (getPosASL _target_unit);
	_camera camCommitPrepared 0;
	sleep 4;

	_camera camPrepareRelPos [0, 0, 4];
	_camera camCommitPrepared 3;
	titleCut ["", "BLACK IN", 1];

	waitUntil { camCommitted _camera };
	[_unit_to_tp,getPosASL _target_unit] remoteExec ['setPosASL',2];
	titleCut ["", "BLACK", 1];


	sleep 2;
	[worldName, mapGridPosition player, str(date select 1) + "." + str(date select 2) + "." + str(date select 0)] spawn BIS_fnc_infoText;
	"dynamicBlur" ppEffectEnable true;   
	"dynamicBlur" ppEffectAdjust [6];   
	"dynamicBlur" ppEffectCommit 0;     
	"dynamicBlur" ppEffectAdjust [0.0];  
	"dynamicBlur" ppEffectCommit 5;  

	titleCut ["", "BLACK IN", 5];

	_camera cameraEffect ["terminate", "back"];
	camDestroy _camera;	
};










