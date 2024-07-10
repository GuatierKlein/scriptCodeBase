BAR_enableCustomKitOnRespawn = false; 
//true = le kit sauvegardé à l'arsenal sera automatiquement appliqué au respawn en plus de la spécialisation du mannequin choisit
//false = le kit du mannequin et la spécialisation sera appliqué au respawn sans le kit sauvegardé à l'arsenal

//NE PAS MODIFIER EN DESSOUS
player setVariable ["BAR_kit", kit_ne];
BAR_customKit = getUnitLoadout kit_ne;

BAR_fnc_setKit = {
	params ["_kit"];
	private _res = false;
	//test if enough points 
	private _varName = "";

	switch (side player) do {
		case west: { _varName = "GDGM_BLUFOR_supplies" };
		case east: { _varName = "GDGM_OPFOR_supplies" };
		case independent: { _varName = "GDGM_IND_supplies" };
		default { };
	};

	player setVariable ["BAR_kit",_kit];
};

BAR_fnc_applyKit = {
	_kit_unit = player getVariable "BAR_kit";

	_loadout = getUnitLoadout _kit_unit;
	player setUnitLoadout _loadout;
	player setUnitRank (rank _kit_unit);
	
	private _eng = _kit_unit getVariable ["GDGM_isEng", false];
	private _medic = _kit_unit getVariable ["GDGM_isMedic", false];

	player setUnitTrait ["medic", _medic]; 
	player setUnitTrait ["engineer", _eng]; 
	player setUnitTrait ["explosiveSpecialist", _eng]; 

	//ace
	if(_eng) then {
		player setVariable ["ACE_IsEngineer",2, true]; 
		player setVariable ["ACE_isEOD", true, true];
	} else {
		player setVariable ["ACE_IsEngineer",0, true]; 
		player setVariable ["ACE_isEOD", false, true];
	};

	if(_medic) then {
		player setVariable ["ace_medical_medicclass", 1, true];
	}else {
		player setVariable ["ace_medical_medicclass", 0, true];
	};
	
	systemChat ("AuxSan : " + str (player getVariable "ace_medical_medicclass")); //affiche true si medic, false sinon
	systemChat ("Compétence d'ingénieur : " + str (player getVariable "ACE_IsEngineer")); //affiche 1 ou 2 si sapeur, 0 sinon
	systemChat ("Expert explosif : " + str (player getVariable "ACE_isEOD")); //affiche 1 ou 2 si EOD, 0 sinon
	systemChat ("Grade : " + rank player); //affiche le grade reçu
	call BAR_fcn_applyInsignia;
};

//insignes
BAR_fcn_applyInsignia = {
	[player, ""] call BIS_fnc_setUnitInsignia;
	[player, player getVariable "playerInsigne"] call BIS_fnc_setUnitInsignia;
};

BAR_fnc_setInsignia = {
	params ["_insigne"];
	player setVariable ["playerInsigne",_insigne];
	call BAR_fcn_applyInsignia;
};

player setVariable ["playerInsigne","base"];