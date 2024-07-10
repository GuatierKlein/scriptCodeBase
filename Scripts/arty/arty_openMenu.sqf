//clientside
createDialog "dialogArty";

artillery_pieces_array_client = [];
ammo_array = [];
_artillery_names_array = [];

ctrlSetText [040512,GDGM_art_X_coord]; //X
ctrlSetText [040513,GDGM_art_Y_coord]; //Y
ctrlSetText [040515,GDGM_art_shots]; //shots
ctrlSetText [040518,GDGM_art_dist]; //dist
ctrlSetText [040519,GDGM_art_angle]; //angle

GDGM_artillery_names_array = 
[["81mm mortar",
	[
		["Sh_82mm_AMOS","81mm HE"],
		["Smoke_82mm_AMOS_White","81mm smoke shells"],
		["Flare_82mm_AMOS_White","Flares"]
	]
], 
["155mm gun",
	[
		["Sh_155mm_AMOS","155mm HE"],
		["Smoke_120mm_AMOS_White","155mm smoke shells"]
	]
]];

//get display name
{
	lbAdd [040514,_x select 0];
} foreach GDGM_artillery_names_array;

//get and display ammo
_display = findDisplay 04051;
_lb_piece = _display displayCtrl 040514;

//EH lb changed
_lb_piece ctrlAddEventHandler ["LBSelChanged", 
{
	_index = lbCurSel 040514;
	lbClear 040516;
	private _arty_piece = GDGM_artillery_names_array select _index;
	ammo_array = _arty_piece select 1;
	{
		lbAdd [040516,_x select 1];		
	} foreach ammo_array;
}];

while {dialog} do {
	GDGM_art_X_coord = ctrlText 040512;
	GDGM_art_Y_coord = ctrlText 040513;
	GDGM_art_shots = ctrlText 040515;
	GDGM_art_dist = ctrlText 040518;
	GDGM_art_angle = ctrlText 040519;
	sleep 0.3;
};


