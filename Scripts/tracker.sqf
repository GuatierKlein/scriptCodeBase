//version 1.0
if!(isServer) exitWith {};

/*
Que fait ce script?
Ce script est inspiré des trackers du DLC vietnam
Il spawn dynamiquement des trackers qui traquent les joueurs dans un déclencheur 
Le script fonctionne comme un graphe, il grimpe d'état en état jusqu'a atteindre l'état maximum
Un état représente la statut d'alerte des ennemis, plus l'état est haut, plus la force ennemie sera grande 
Un augmente d'un état dès qu'un groupe de tracker localise un joueur (un groupe ne peut faire monter l'état qu'une fois)

Instrutions 

creer un déclencheur et le remplir ainsi

on act 
[thisTrigger,spawn cap,maxstate,usecar,usebuilding,sentriesaroundplayer] spawn GDGM_fnc_initTrackerTrigger;
exemple : [thisTrigger,100,10,true,true,false] spawn GDGM_fnc_initTrackerTrigger;

deact  
[thisTrigger] spawn GDGM_fnc_masterClean;

le script se lancera quand le déclencheur s'activera, et trackera les joueur DANS le déclencheur
il est préférable que le déclencheur soit un cercle, et entre 400 et 1000m de diamètre
A vous de tester tout les paramètres pour trouver les réglages qui vous conviennent

les paramètres du script :

thisTrigger : ne pas modifier 
spawn cap : nombre maximum de tracker qui peut spawn, NE PAS UTILISER POUR GERER LA DIFFICULTE, ceci sert uniquement pour les performance, idéalement, laisser à 100
maxstate : état maximum que peut atteindre le script, plus la valeur est grande, plus le script enverra de reserve sur vous, une valeur plus petite rend le script plus facile
	exemple : 5 = facile, 10 = moyen plus, 15 = difficile
usecar : 
	true : les tracker utiliseront des véhicules
	false : pas de véhicules
useBuilding : 
	true : les tracker utiliseront les batiment pour cacher leur spawn (à n'utiliser que dans les grande ville avec bcp de batiment ouverts et avec des positions préconfigurées)
	false : les tracker spawneront de manière normale sans se soucier des batiments 
sentriesaroundplayer : 
	true : le spawn des sentinelles de départ (état 0) se fait autour du joueur
	false : le spawn des sentinelles de départ (état 0) se fait autour du déclencheur
*/

//PARAMETRES
debug = false;
GDGM_trackerAmount = 0; //pas toucher
//side des tracker ->west, east ou resistance
GDGM_trackerSide = resistance;
//distance de spawn minimum avec le joueur
GDGM_tracker_safeDistance = 300;
//marker dans lequel les tracker ne pourront pas spawner
GDGM_tracker_blackListMarker = "blacklistMarker";
//true : affiche les coms des trackers
GDGM_useOPFORcom = true;
//nombre de groupe de sentinelle au déclenchement du script
GDGM_baseSentryNb = 2;
//les tracker utilises des drones qui lache des bombes (! c'est violent)
GDGM_useDrone = false;
//side des joueurs
GDGM_friendly_side_string = "BLU"; //BLU,OPF,IND
GDGM_friendly_side = west; //west,east,resistance
//true : active le sript de fuite, attention à ce qu'il soit installé dans la mission, voir fleeing.sqf
GDGM_enableFleeingScript = true;
//spawn time
GDGM_tracker_minSpawnTime = 60;
GDGM_tracker_averageSpawnTime = 180;
GDGM_tracker_maxSpawnTime = 300;

//mannequins de matos pour les trackes si vous souhaitez utiliser des stuffs custom
GDGM_unit_kits = [
	kit1,
	kit2,
	kit3,
	kit4,
	kit5,
	kit6,
	kit7,
	kit8,
	kit9,
	kit10,
	kit11,
	kit12,
	kit13,
	kit14
];

//runs on every unit's spawn
GDGM_unit_initFunction = {
	params ["_unit"];

	//exemple de code à lancer à chaque spawn
	//implémentation des stuffs custom
	_unit setUnitLoadout getUnitLoadout (selectRandom GDGM_unit_kits);
	//mettre une voix russe
	_unit setSpeaker selectRandom ["Male01RUS","Male02RUS","Male03RUS"];

	//compétences IA
	_unit setskill 0.15;
	_unit setskill ["aimingAccuracy",0.15];
	_unit setskill ["SpotDistance",1];
	_unit setskill ["commanding",0.25];
	_unit setskill ["spotTime",1];
};

//OPFOR COM lines
GDGM_OPFORCOM_spottedBegArray = 
	["Ici ",
	"De "];
GDGM_OPFORCOM_spottedEndArray = 
	[" repéré en ",
	" en visuel en ",
	" trouvé en ",
	" repéré coodronnées ",
	" en visuel coodronnées "];
GDGM_OPFORCOM_goEndArray = 
	[" on se déplace en ",
	" on attaque vers ",
	" on se déplace vers le contact en ",
	" on progresse vers les ennemis en ",
	" on bouge vers "];
GDGM_OPFORCOM_goSearchArray = 
	[" pas d'ennemis en vue, on continue la patrouille",
	" on traque",
	" on commence la traque",
	" on traque les ennemis",
	" pas de contact on continue la recherche"];

//Liste de véhicules de transport non armés utilisés par les trackers
GDGM_openJeepArray = [
	"UK3CB_CCM_I_Lada", 
	"UK3CB_CCM_I_UAZ_Closed", 
	"UK3CB_CCM_I_UAZ_Open", 
	"UK3CB_CCM_I_Gaz24", 
	"UK3CB_CCM_I_S1203"
];

//Liste des classnames des trackers
ennemyUnitsArray = 
	["I_L_Looter_Rifle_F"];

//NE PAS MODIFIER EN DESSOUS
//inits trigger for tracker scripts
GDGM_fnc_initTrackerTrigger = {
	params ["_trigger","_spawnCap","_maxState","_useCars","_trackerUseBuilding","_sentriesAroundPlayer"];

	if(isNil "_useCarSentries") then {_useCarSentries = true};
	if(isNil "_trackerUseBuilding") then {_trackerUseBuilding = false};
	if(isNil "_sentriesAroundPlayer") then {_sentriesAroundPlayer = false};

	//atributes
	_trigger setVariable ["GDGM_posTrigger",getPos _trigger];
	_trigger setVariable ["GDGM_trackerUseBuilding",_trackerUseBuilding];
	_trigger setVariable ["GDGM_sentriesAroundPlayer",_sentriesAroundPlayer];
	_trigger setVariable ["GDGM_useCars",_useCars];
	_trigger setVariable ["GDGM_spawnCap",_spawnCap];
	_trigger setVariable ["GDGM_spawnNb",0];
	_trigger setVariable ["GDGM_maxState",_maxState];
	_trigger setVariable ["GDGM_state",0];
	_trigger setVariable ["GDGM_spawnedGrp",[]];
	_trigger setVariable ["GDGM_huntingGroups",[]];
	_trigger setVariable ["GDGM_radius",(triggerArea _trigger) select 0];
	_trigger setVariable ["GDGM_sentriesNb",1];
	_trigger setVariable ["GDGM_sentriesCarNb",0];

	//sentries nb
	if(_trigger getVariable "GDGM_radius" > 250) then {_trigger setVariable ["GDGM_sentriesNb",GDGM_baseSentryNb]};
	if(_trigger getVariable "GDGM_radius" > 500) then {
		_trigger setVariable ["GDGM_sentriesNb",GDGM_baseSentryNb + 1];
		if(_useCars) then {
			_trigger setVariable ["GDGM_sentriesCarNb",1];
		};
	};
	
	//statetement
	//add clean up fnc	
	[_trigger] spawn GDGM_fnc_startTracker;
	true;
};

//starts tracker process
GDGM_fnc_startTracker = {
	params["_trigger"];

	_grp = grpNull;
	_useBuildings = _trigger getVariable "GDGM_trackerUseBuilding";

	for [{private _z = 0}, {_z < (_trigger getVariable "GDGM_sentriesNb")}, {_z = _z + 1}] do {
		_house = [_trigger,_trigger getVariable "GDGM_posTrigger",_trigger getVariable "GDGM_radius",_useBuildings,false] call GDGM_fnc_findSpawnPos;
		_grp = [_trigger, _house, 2, GDGM_trackerSide] call GDGM_fnc_spawnGrp;
		[_grp, _trigger] spawn GDGM_fnc_spotWatcher;
		[_grp, _trigger] spawn GDGM_fnc_search;	
	};

	//car sentries
	for [{private _z = 0}, {_z < (_trigger getVariable "GDGM_sentriesCarNb")}, {_z = _z + 1}] do {
		_grp = [_trigger] call GDGM_fnc_sentryCar;
		[_grp, _trigger] spawn GDGM_fnc_spotWatcher;
		[_grp, _trigger, 500, true] spawn GDGM_fnc_search;	
	};
};

GDGM_fnc_masterClean = {
	params["_trigger"];

	_array = _trigger getVariable "GDGM_spawnedGrp";
	{
		if(count ((leader _x) targets [true,300,[sideUnknown],60]) == 0) then 
		{
			{
				if(vehicle _x == _x) then {
					deleteVehicle _x;
				} else {
					deleteVehicle vehicle _x;
					deleteVehicle _x;
				}
			} foreach units _x;
		};
	} foreach _array;
};

GDGM_fnc_sentryCar = {
	params["_trigger"];
	
	_spawnPos = [_trigger getVariable "GDGM_posTrigger"] call GDGM_findSpawnRoad;
	
	_grp = createGroup [GDGM_trackerSide,true]; 	
	_jeep = (selectRandom GDGM_openJeepArray) createVehicle _spawnPos;

	for [{private _y = 0}, {_y < 2}, {_y = _y + 1}] do {
		_unit = _grp createUnit [selectRandom ennemyUnitsArray,  _spawnPos, [], 0, "FORM"];	
		_unit moveInAny _jeep;
		[_unit] spawn GDGM_unit_initFunction;

		_array = _trigger getVariable "GDGM_spawnedGrp";
		_array pushBack _grp;
		_trigger setVariable ["GDGM_spawnedGrp",_array];
	};	
	_grp;
};

GDGM_fnc_search = {
	params ["_grp","_trigger","_error","_stayOnRoad"];
	
	if(isNil "_stayOnRoad") then {_stayOnRoad = false};
	
	_wpPos = [_trigger] call GDGM_fnc_getRandomPlayerPosInArea;
	if(isNil "_wpPos") exitwith {[_grp] spawn GDGM_fnc_deleteGroup}; //delete group

	_grp setBehaviour "safe";
	_wp = _grp addWaypoint [_wpPos ,100];
	_wp setWaypointBehaviour "safe";
	_wp setWaypointFormation "COLUMN";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointTimeout [120, 120, 120];

	//stay on road
	if(_stayOnRoad) then {
		_road = [getWPPos [_grp,1], 100] call BIS_fnc_nearestRoad;
		if!(isNil "_road") then {
			_wp setWaypointPosition [getPos _road,0];
		};
	};
	
	_huntingArray = (_trigger getVariable "GDGM_huntingGroups"); 
	_huntingArray pushBack _grp;
	_trigger setVariable ["GDGM_huntingGroups", _huntingArray];
	//opforcom 
	[leader _grp,objNull,3,objNull,60] spawn GDGM_fnc_OPFORcom; 

	sleep 60;

	if(isNil "_error") then {
		_error = 100;
	};

	while {{ alive _x } count units _grp > 0} do { 
		_wpPos = [_trigger] call GDGM_fnc_getRandomPlayerPosInArea;
		if(isNil "_wpPos") exitwith {[_grp] spawn GDGM_fnc_deleteGroup}; 
		_error = _error -10;
		if(_error < 0) then {_error = 0};		
		_wp setWaypointPosition [_wpPos,_error];
		//stay on road
		if(_stayOnRoad) then {
			_road = [getWPPos [_grp,1], 100] call BIS_fnc_nearestRoad;
			if!(isNil "_road") then {
				_wp setWaypointPosition [getPos _road,0];
			};
		};
		sleep 60;
	};
};

GDGM_fnc_deleteGroup = {
	params["_grp"];
	{
		deleteVehicle _x;	
		GDGM_trackerAmount = GDGM_trackerAmount - 1;
	} forEach units _grp;
};


GDGM_fnc_spotWatcher = {
	params ["_grp","_trigger","_useDrone"];

	if(!isServer) exitwith {};
	if(debug) then {systemChat ("Watching " + str _grp)};
	if(isNil "_useDrone") then {_useDrone = true};

	waitUntil { sleep 5; count ((leader _grp) targets [true,300]) > 0 || { alive _x } count units _grp == 0};

	if({ alive _x } count units _grp == 0) exitwith {if(debug) then {systemChat "Group died"}};

	//if spotted
	if(debug) then {hint "spotted!"};	
	_newState = (_trigger getVariable "GDGM_state") + 1;
	_target = selectRandom ((leader _grp) targets [true]);
	[leader _grp, _target, 1] spawn GDGM_fnc_OPFORcom;
	
	if(_newState > _trigger getVariable "GDGM_maxState") exitwith {
		if(debug) then {systemChat "Max state reached"}; 
		if(random 1 > 0.75 && _useDrone) then {
			_pos = [_trigger,getPos _target, 300, false] call GDGM_fnc_findSpawnPos;
			[_pos,getPos _target] spawn GDGM_fnc_bombDrone;
			[leader _grp, _target,4] spawn GDGM_fnc_OPFORcom;
		};
	};
	
	_trigger setVariable ["GDGM_state", _newState];

	
	//bonus
	if(random 1 > 0.75) then 
	{
		if(random 1 > 0.5 && _useDrone) then {
			_pos = [_trigger,getPos _target, 300, false] call GDGM_fnc_findSpawnPos;
			[_pos,getPos _target] spawn GDGM_fnc_bombDrone;
		} else { 
			[_target] spawn GDGM_fnc_motoRush;
		};
	};
	
	//QRF group
	sleep (random [GDGM_tracker_minSpawnTime,GDGM_tracker_averageSpawnTime,GDGM_tracker_maxSpawnTime]);
	[_trigger, getPos _target,1] spawn GDGM_fnc_attackGroup;
};

GDGM_fnc_OPFORcom = {
	params ["_spotter","_spotted","_type","_pos","_waitTime"];

	if(!GDGM_useDrone && _type == 4) exitwith {};
	if(isNil "_spotter" || isNil "_spotted" || !GDGM_useOPFORcom) exitwith{};
	if(isNil "_waitTime") then {_waitTime = 10};

	_msg = "OPFOR COM : ";
	switch (_type) do {
		case 1 : {
			//spotted
			_beginning = selectRandom GDGM_OPFORCOM_spottedBegArray;
			_end = selectRandom GDGM_OPFORCOM_spottedEndArray;
			_spottedClass = typeOf _spotted;
			_spottedName = gettext (configfile >> "CfgVehicles" >> _spottedClass >> "displayName");
			_msg = _msg + _beginning + name _spotter + ", " + _spottedName + _end + mapGridPosition (getPosASL _spotted);
		};
		case 2 : {
			//going to
			_beginning = selectRandom GDGM_OPFORCOM_spottedBegArray;
			_end = selectRandom GDGM_OPFORCOM_goEndArray;
			_msg = _msg + _beginning + name _spotter + _end + mapGridPosition _pos;
		};
		case 3 : {
			//going back to searching
			_beginning = selectRandom GDGM_OPFORCOM_spottedBegArray;
			_end = selectRandom GDGM_OPFORCOM_goSearchArray;
			_msg = _msg + _beginning + name _spotter + _end;

		};
		case 4 : {
			//drone
			_beginning = selectRandom GDGM_OPFORCOM_spottedBegArray;
			_msg = _msg + _beginning + name _spotter + " on envoie un drone coordonnées " + mapGridPosition (getPosASL _spotted);
		};
		default { };
	};

	sleep (floor (random _waitTime));
	[[GDGM_friendly_side, GDGM_friendly_side_string], _msg] remoteExec["sideChat", [0,-2]];
};

GDGM_fnc_attackGroup = {
	params ["_trigger","_contactPos"];

	//how many units
	_state = _trigger getVariable "GDGM_state";

	switch (_state) do {
		case 0; 
		case 1: { 
			if(random 1 > 0.20) then {
				//send truck to investigate
				[_trigger,1,_contactPos] spawn GDGM_fnc_attackGroupCar;
			} else {
				//send group
				[_trigger,1,_contactPos] spawn GDGM_fnc_attackGroupSquad;
			};
		};
		case 2: { 
			[_trigger,1,_contactPos] spawn GDGM_fnc_attackGroupSquad;
		};
		case 3;
		case 4;
		case 5: { 
			if(random 1 > 0.50) then {
				//send truck to investigate
				[_trigger, 1,_contactPos, true] spawn GDGM_fnc_attackGroupCar;
			} else {
				//send group
				[_trigger, 1,_contactPos] spawn GDGM_fnc_attackGroupSquad;
			};
		};
		case 6 : {
			[_trigger, 1,_contactPos, true] spawn GDGM_fnc_attackGroupCar;
		};
		default {[_trigger,1,_contactPos] spawn GDGM_fnc_attackGroupSquad};
	};
};

GDGM_fnc_attackGroupCar = {
	params["_trigger","_nb","_contactPos","_fullCar"];

	if(debug) then {
		systemChat "Attck group car";
	};

	if(isNil "_fullCar") then {_fullCar = false};
	if!(_trigger getVariable "GDGM_useCars") exitwith {[_trigger,1,_contactPos] spawn GDGM_fnc_attackGroupSquad};
	
	_spawnPos = [_contactPos] call GDGM_findSpawnRoad;
	
	_grp = createGroup [GDGM_trackerSide,true]; 	
	_jeep = (selectRandom GDGM_openJeepArray) createVehicle _spawnPos;
	_vehSpots = count(fullCrew [_jeep, "", true]);
	_nb = 0;
	if(_fullCar) then {
		_nb = _vehSpots;
	} else {
		_nb = 2 + floor (random (_vehSpots - 1));
	};

	for [{private _y = 0}, {_y < _nb}, {_y = _y + 1}] do {
		_unit = _grp createUnit [selectRandom ennemyUnitsArray,  _spawnPos, [], 0, "FORM"];	
		_unit moveInAny _jeep;
		[_unit] spawn GDGM_unit_initFunction;
	};
	
	_grp setVariable ["GDGM_trigger",_trigger];
	[_grp,_trigger] spawn GDGM_fnc_spotWatcher;
	_wp = _grp addWaypoint [_contactPos ,5];	
	_wp setWaypointCompletionRadius 20;
	_wp setWaypointStatements ["true", "if(isserver) then {[group this,(group this) getVariable 'GDGM_trigger'] spawn GDGM_fnc_search}"];
	
	_array = _trigger getVariable "GDGM_spawnedGrp";
	_array pushBack _grp;
	_trigger setVariable ["GDGM_spawnedGrp",_array];

	[leader _grp,objnull,2,_contactPos] spawn GDGM_fnc_OPFORcom;
	
	if(GDGM_enableFleeingScript) then {
		[_grp] spawn GDGM_fnc_groupFlee;
	};
};

GDGM_fnc_attackGroupSquad = {
	params["_trigger","_nb","_contactPos"];

	if(debug) then {
		systemChat "Attck group";
	};

	_house = [_trigger, _contactPos, 300, _trigger getVariable "GDGM_trackerUseBuilding"] call GDGM_fnc_findSpawnPos;
	
	//squad size
	_state = _trigger getVariable "GDGM_state";
	_reinfNb = 0;
	switch (_state) do {
		case 0;
		case 1: {_reinfNb = 4};
		case 2;
		case 3: {_reinfNb = floor(random 3) + 4};
		default {_reinfNb = floor(random 5) + 4};
	};
	
	//spawn
	// _grp = grpNull;
	// if(_trigger getVariable "GDGM_trackerUseBuilding") then {
	// 	_grp = [_trigger, _house,_reinfNb,GDGM_trackerSide] call GDGM_fnc_spawnGrp;	
	// } else {

	// };

	_grp = [_trigger, _house,_reinfNb,GDGM_trackerSide] call GDGM_fnc_spawnGrp;	
	
	if(isNil "_grp" || isNull _grp) exitwith {};
	[_grp,_trigger] spawn GDGM_fnc_spotWatcher;
	_grp setVariable ["GDGM_trigger",_trigger];
	_wp = _grp addWaypoint [_contactPos ,5];	
	_wp setWaypointCompletionRadius 10;
	_wp setWaypointStatements ["true", "if(isserver) then {[group this,(group this) getVariable 'GDGM_trigger'] spawn GDGM_fnc_search}"];

	[leader _grp,objnull,2,_contactPos] spawn GDGM_fnc_OPFORcom;
		
	if(GDGM_enableFleeingScript) then {
		[_grp] spawn GDGM_fnc_groupFlee;
	};
};

GDGM_fnc_getRandomPlayerPosInArea = {
	params["_trigger"];
	_pos = objNull;
	_playerArray = allPlayers - entities "HeadlessClient_F";
	_player = selectRandom _playerArray;
	
	while {!(_player inArea _trigger) && count _playerArray > 0} do 
	{
		_player = selectRandom _playerArray;
		_playerArray = _playerArray - [_player];
	};

	if(!(_player inArea _trigger)) exitwith {};
	_pos = getPos _player;
	_pos;
};

GDGM_fnc_findSpawnPos = {
	params ["_trigger","_pos","_radius","_useBuildings","_aroundPlayer"];

	if(isNil "_aroundPlayer") then {_aroundPlayer = true};
	_house = objNull;
	if(_useBuildings) then
	{		
		_buildings = nearestObjects [_pos, ["house"], _radius];
		if(count _buildings == 0) exitwith {}; 

		_house = selectRandom _buildings;
		_housePos = _house buildingPos -1;
		while {count _housePos == 0 || [getPos _house,GDGM_tracker_safeDistance] call GDGM_fnc_isPlayerTooClose || _house inArea GDGM_tracker_blackListMarker} do {
			_house = selectRandom _buildings;
			_housePos = _house buildingPos -1;
		};
		if(debug) then 
		{
			_marker = createMarker ["Marker1", getPosASL _house];
			_marker setMarkerType "hd_dot";
		};
		
	} else {
		if(_aroundPlayer) then {
			_pos = [_trigger] call GDGM_fnc_getRandomPlayerPosInArea;	
			//systemChat "test";		
		};
		//if(isNil "_pos") exitwith {};

		_spawnPos = _pos getPos [GDGM_tracker_safeDistance * 3, floor (random 360)];

		while {[_spawnPos,GDGM_tracker_safeDistance] call GDGM_fnc_isPlayerTooClose || _spawnPos inArea GDGM_tracker_blackListMarker} do {
			_spawnPos = _pos getPos [GDGM_tracker_safeDistance * 3, floor (random 360)];
		};

		_spawnPos = [ //position du spawn
		_spawnPos, 
		0, //min dist
		50, //max dist
		3, //object dist
		0, //water mode 0=no water
		0.8, //max grad between 0 and 1
		0, 
		[], 
		[_spawnPos, _spawnPos]] call BIS_fnc_findSafePos;
		_house = _spawnPos;
	};
	_house;
};

GDGM_fnc_isPlayerTooClose = {
	params ["_pos","_safeDistance","_maxDistance"];

	_playerArray = allPlayers - entities "HeadlessClient_F";
	_i = 0;
	_safeDistance = _safeDistance * _safeDistance;
	_continue = true;

	//if(!(isNil "_maxDistance")) then {_maxDistance = _maxDistance * _maxDistance};

	while {_i < count _playerArray && _continue} do {	
		_dist = (_playerArray select _i) distanceSqr _pos;	
		if (_dist < _safeDistance) then 
		{
			_continue = false;
		};
		_i = _i + 1;
	};
	_continue = !_continue;
	_continue;
};

GDGM_fnc_spawnGrp = { //use states 
	params ["_trigger","_houseOrPos","_grpSize","_gdgm_side"];

	if(debug) then {
		systemChat "Spawning group";
	};

	if((_trigger getVariable "GDGM_spawnNb") + _grpSize > _trigger getVariable "GDGM_spawnCap") exitwith {systemChat "Too many units spawned"};
	_grp_house = createGroup [_gdgm_side,true]; 
//	_useBuildings = _trigger getVariable "GDGM_trackerUseBuilding";
	_posType = typeName _houseOrPos;
	_allpos = [];
	
	//buidling or not
	/*
	if(_useBuildings) then {
		_allpos = _houseOrPos buildingPos - 1; 
	} else {
		_allpos = [_houseOrPos];
	};
	*/

	if(_posType == "OBJECT") then {
		_allpos = _houseOrPos buildingPos - 1; 
	};
	if(_posType == "ARRAY") then {
		_houseOrPos pushBack 0;
		_allpos = [_houseOrPos];		
	};
	
	for [ { private _j = 0 } , { _j < _grpSize } , { _j = _j + 1 } ] do {						
		_spawnPos = selectRandom _allpos; 
												
		//unit spawn
		_unit = _grp_house createUnit [selectRandom ennemyUnitsArray,  _spawnPos, [], 0, "FORM"];
		[_unit] spawn GDGM_unit_initFunction;		
		_unit setVariable ["GDGM_assocTrigger", _trigger];					
		_unit setPosATL _spawnPos;	
		_trigger setVariable ["GDGM_spawnNb", (_trigger getVariable "GDGM_spawnNb") + 1];
		
		_unit addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];

			_trg = _unit getVariable "GDGM_assocTrigger";
			_trg setVariable ["GDGM_spawnNb", (_trg getVariable "GDGM_spawnNb") - 1];
		}];
					
	};
	
	_array = _trigger getVariable "GDGM_spawnedGrp";
	_array pushBack _grp_house;
	_trigger setVariable ["GDGM_spawnedGrp",_array];

	_grp_house;
};

GDGM_fnc_bombDrone = {
	if(!GDGM_useDrone) exitwith {};
	params["_pos","_target"];

	if(debug) then {
		systemChat "Bomb drone";
	};

	_UAV = createVehicle ["O_UAV_01_F", _pos, [], 0,""];
	_UAV setVariable ["GDGM_ordDropped", false];

	_UAV addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		if!(_unit getVariable "GDGM_ordDropped") then {
			 _bomb = createVehicle ['Sh_82mm_AMOS', getPos _unit, [], 0,'']; 
			 _bomb setVelocity [0,0,-0.9];
		};
	}];

	_UAV flyInHeight 75;
	createVehicleCrew _UAV; 
	_wp = (group _UAV) addWaypoint [_target,0];
	_wp setWaypointCompletionRadius 1;
	_wp setWaypointStatements ["true", "if(isserver) then {(vehicle this) setVariable ['GDGM_ordDropped', true]; _bomb = createVehicle ['Sh_82mm_AMOS', getPos vehicle this, [], 0,'']; _bomb setVelocity [0,0,-0.9];(vehicle this) setDamage 1}"];
};

GDGM_findSpawnRoad = {
	params["_pos"];

	_spawn_pos = [ //position du spawn
	_pos, 
	400, //min dist
	1000, //max dist
	5, //object dist
	0, //water mode 0=no water
	0, //max grad between 0 and 1
	0, 
	[], 
	[_pos, _pos]] call BIS_fnc_findSafePos;

	while {_spawn_pos inArea GDGM_tracker_blackListMarker} do {
		_spawn_pos = [ //position du spawn
		_pos, 
		400, //min dist
		1000, //max dist
		5, //object dist
		0, //water mode 0=no water
		0, //max grad between 0 and 1
		0, 
		[], 
		[_pos, _pos]] call BIS_fnc_findSafePos;
	};

	_road = [_spawn_pos , 1500] call BIS_fnc_nearestRoad;
	if (isNil "_road") exitwith {};
	
	_road_pos = getPosATL _road;
	_road_pos;
};

GDGM_fnc_motoRush = {
	params["_target"];

	if(debug) then {
		systemChat "Moto rush";
	};

	_spawnPos = [getPos _target] call GDGM_findSpawnRoad;

	for [{private _i = 0}, {_i < 3}, {_i = _i + 1}] do {
		_grp = createGroup [GDGM_trackerSide,true]; 	
		_moto = (selectRandom ["UK3CB_MEI_O_YAVA", "UK3CB_MEI_O_TT650"]) createVehicle _spawnPos;
		_unit = _grp createUnit [selectRandom ennemyUnitsArray,  _spawnPos, [], 0, "FORM"];	
		_unit moveInAny _moto;
		[_unit] spawn GDGM_unit_initFunction;
		_unit = _grp createUnit [selectRandom ennemyUnitsArray,  _spawnPos, [], 0, "FORM"];	
		_unit moveInAny _moto;	
		[_unit] spawn GDGM_unit_initFunction;

		[_target,_grp] spawn {
			params["_target","_grp"];
			_wp = _grp addWaypoint [getPos _target , 5];
			_wp setWaypointTimeout [120, 120, 120];
			while {{ alive _x } count units _grp > 0 && alive _target} do { 	
				_wp setWaypointPosition [getPos _target,0];
				sleep 15;
			};
		};
		sleep 5;
	};
};

//init
/*
[grpIED, trgIED, false] spawn GDGM_fnc_spotWatcher;
[group snip, trgIED, false] spawn GDGM_fnc_spotWatcher;
[grpHotage, trgHotage, false] spawn GDGM_fnc_spotWatcher;
*/

// _spotters = [
// 	sn,
// 	sn_1,
// 	sn_2,
// 	sn_3,
// 	sn_4
// ];

// {
// 	[group _x, trgWest, false] spawn GDGM_fnc_spotWatcher;
// } foreach _spotters;



