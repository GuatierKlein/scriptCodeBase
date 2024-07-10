
class dialogTeleport
{
	idd = 17041;
	class controls 
	{
		class frame: RscText
		{
			idc = -1;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.211406 * safezoneW;
			h = 0.484 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.5};
		};
		class textTitle: RscText
		{
			idc = -1;
			text = "TELEPORT TO PLAYER"; 
			x = 0.45875 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 170411;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.297 * safezoneH;
		};
		class btnClose: RscButton
		{
			idc = -1;
			text = "CLOSE"; 
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closedialog 0";
		};
		class btnTeleport: RscButton
		{
			idc = 170412;
			text = "TELEPORT"; 
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};



class dialogArty
{
	idd = 04051;
	class ControlsBackground
	{
		class frame: RscPicture
			{
				idc = -1;
				text = "Images\Support.paa";
				x = 0.164899 * safezoneW + safezoneX;
				y = -0.0169541 * safezoneH + safezoneY;
				w = 0.634113 * safezoneW;
				h = 1.03391 * safezoneH;
			};
	};
	class controls 
	{
		class btnOrder: RscButton
		{
			idc = 40511;
			action = "execVM 'scripts\arty\order_arty.sqf';";

			text = "FIRE FOR EFFECT"; //--- ToDo: Localize;
			x = 0.360804 * safezoneW + safezoneX;
			y = 0.170029 * safezoneH + safezoneY;
			w = 0.0670201 * safezoneW;
			h = 0.0549951 * safezoneH;
			tooltip = "Order the artillery barrage with the given coordinates, don't hesitate to fire smoke first to adjust your shot"; //--- ToDo: Localize;
		};
		class btnClose: RscButton
		{
			action = "closedialog 0";

			idc = 1601;
			text = "CLOSE"; //--- ToDo: Localize;
			x = 0.30925 * safezoneW + safezoneX;
			y = 0.807973 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.0440001 * safezoneH;
		};
		class editX: RscEdit
		{
			idc = 40512;

			text = "000"; //--- ToDo: Localize;
			x = 0.195832 * safezoneW + safezoneX;
			y = 0.71998 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.0440001 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.5};
			tooltip = "X coords"; //--- ToDo: Localize;
		};
		class editY: RscEdit
		{
			idc = 40513;

			text = "000"; //--- ToDo: Localize;
			x = 0.195832 * safezoneW + safezoneX;
			y = 0.774976 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.0440001 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.5};
			tooltip = "Y coords"; //--- ToDo: Localize;
		};
		class editShots: RscEdit
		{
			idc = 40515;

			text = "Shots"; //--- ToDo: Localize;
			x = 0.195832 * safezoneW + safezoneX;
			y = 0.664985 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.0440001 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.5};
			tooltip = "Number of shots"; //--- ToDo: Localize;
		};
		class editDist: RscEdit
		{
			idc = 40518;

			text = "Distance"; //--- ToDo: Localize;
			x = 0.283474 * safezoneW + safezoneX;
			y = 0.664985 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.0440001 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.5};
			tooltip = "Correction distance"; //--- ToDo: Localize;
		};
		class editAngle: RscEdit
		{
			idc = 40519;

			text = "Angle"; //--- ToDo: Localize;
			x = 0.283474 * safezoneW + safezoneX;
			y = 0.71998 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.0440001 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.5};
			tooltip = "Correction angle"; //--- ToDo: Localize;
		};
		class lbPieces: RscListbox
		{
			idc = 040514;
			x = 0.195832 * safezoneW + safezoneX;
			y = 0.456004 * safezoneH + safezoneY;
			w = 0.0773309 * safezoneW;
			h = 0.186983 * safezoneH;
		};
		class lbAmmo: RscListbox
		{
			idc = 040516;
			x = 0.283474 * safezoneW + safezoneX;
			y = 0.456004 * safezoneH + safezoneY;
			w = 0.0773309 * safezoneW;
			h = 0.186983 * safezoneH;
		};
		class map: RscMapControl
		{
			idc = 1800;
			x = 0.422669 * safezoneW + safezoneX;
			y = 0.445005 * safezoneH + safezoneY;
			w = 0.273236 * safezoneW;
			h = 0.472958 * safezoneH;
		};
	};
};




/* #Nemile
$[
	1.063,
	["dsq",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1200,"frame",[1,"Images\Support.paa",["0.164899 * safezoneW + safezoneX","-0.0169541 * safezoneH + safezoneY","0.634113 * safezoneW","1.03391 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"btnOrder",[1,"FIRE FOR EFFECT",["0.360804 * safezoneW + safezoneX","0.170029 * safezoneH + safezoneY","0.0670201 * safezoneW","0.0549951 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Order the artillery barrage with the given coordinates, don't hesitate to fire smoke first to adjust your shot","-1"],["idc = 40511;","action = |execVM ^scripts\arty\order_arty.sqf^;|;"]],
	[1601,"btnClose",[1,"CLOSE",["0.30925 * safezoneW + safezoneX","0.807973 * safezoneH + safezoneY","0.0567187 * safezoneW","0.0440001 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |closedialog 0|;"]],
	[1400,"editX",[1,"000",["0.195832 * safezoneW + safezoneX","0.71998 * safezoneH + safezoneY","0.0825 * safezoneW","0.0440001 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.5],[-1,-1,-1,-1],"X coords","-1"],["idc = 40512;"]],
	[1401,"editY",[1,"000",["0.195832 * safezoneW + safezoneX","0.774976 * safezoneH + safezoneY","0.0825 * safezoneW","0.0440001 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.5],[-1,-1,-1,-1],"Y coords","-1"],["idc = 40513;"]],
	[1402,"editShots",[1,"Shots",["0.195832 * safezoneW + safezoneX","0.664985 * safezoneH + safezoneY","0.0825 * safezoneW","0.0440001 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.5],[-1,-1,-1,-1],"Number of shots","-1"],["idc = 40515;"]],
	[1403,"editDist",[1,"Distance",["0.283474 * safezoneW + safezoneX","0.664985 * safezoneH + safezoneY","0.0825 * safezoneW","0.0440001 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.5],[-1,-1,-1,-1],"Correction distance","-1"],["idc = 40518;"]],
	[1404,"editAngle",[1,"Angle",["0.283474 * safezoneW + safezoneX","0.71998 * safezoneH + safezoneY","0.0825 * safezoneW","0.0440001 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.5],[-1,-1,-1,-1],"Correction angle","-1"],["idc = 40519;"]],
	[1500,"lbPieces",[1,"",["0.195832 * safezoneW + safezoneX","0.456004 * safezoneH + safezoneY","0.0773309 * safezoneW","0.186983 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"lbAmmo",[1,"",["0.283474 * safezoneW + safezoneX","0.456004 * safezoneH + safezoneY","0.0773309 * safezoneW","0.186983 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"map",[1,"",["0.422669 * safezoneW + safezoneX","0.445005 * safezoneH + safezoneY","0.273236 * safezoneW","0.472958 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



