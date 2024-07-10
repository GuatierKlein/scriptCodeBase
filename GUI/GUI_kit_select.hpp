
class dialogKitSelect
{
	idd = 24041;
	class controls 
	{
		class frame: RscText
		{
			idc = 1000;
			x = 0.461508 * safezoneW + safezoneX;
			y = 0.254064 * safezoneH + safezoneY;
			w = 0.505228 * safezoneW;
			h = 0.483957 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.5};
		};
		class listbox: RscListBox
		{
			idc = 240411;

			x = 0.479378 * safezoneW + safezoneX;
			y = 0.324016 * safezoneH + safezoneY;
			w = 0.093281 * safezoneW;
			h = 0.322001 * safezoneH;
		};
		class btnGet: RscButton
		{
			action = "execVM 'Scripts\kit_select\getKit.sqf'";

			idc = 1600;
			text = "OBTENIR KIT"; //--- ToDo: Localize;
			x = 0.489689 * safezoneW + safezoneX;
			y = 0.653986 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class btnClose: RscButton
		{
			action = "closedialog 0";

			idc = 1601;
			text = "FERMER"; //--- ToDo: Localize;
			x = 0.855722 * safezoneW + safezoneX;
			y = 0.653986 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class textWeapon: RscText
		{
			idc = 1002;
			text = "Arme : "; //--- ToDo: Localize;
			x = 0.582486 * safezoneW + safezoneX;
			y = 0.28002 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.0329999 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.3};
		};
		class picture: RscPicture
		{
			idc = 240413;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.582486 * safezoneW + safezoneX;
			y = 0.324016 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class textArmeSec: RscText
		{
			idc = 1003;
			text = "Arme secondaire : "; //--- ToDo: Localize;
			x = 0.582486 * safezoneW + safezoneX;
			y = 0.467003 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.0329999 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.3};
		};
		class picture_sec: RscPicture
		{
			idc = 240412;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.582486 * safezoneW + safezoneX;
			y = 0.510999 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class frame_arme: RscText
		{
			idc = 1004;
			x = 0.582486 * safezoneW + safezoneX;
			y = 0.324016 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.3};
		};
		class frame_arme_sec: RscText
		{
			idc = 1005;
			x = 0.582486 * safezoneW + safezoneX;
			y = 0.510999 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.3};
		};
		class textArme_poing: RscText
		{
			idc = 1006;
			text = "Arme de poing :"; //--- ToDo: Localize;
			x = 0.747459 * safezoneW + safezoneX;
			y = 0.28002 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.0329999 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.3};
		};
		class frame_arme_poing: RscText
		{
			idc = 1007;
			x = 0.747459 * safezoneW + safezoneX;
			y = 0.324016 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.3};
		};
		class picture_arme_poing: RscPicture
		{
			idc = 240414;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.747459 * safezoneW + safezoneX;
			y = 0.324016 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class textUniform: RscText
		{
			idc = 1008;
			text = "Uniforme : "; //--- ToDo: Localize;
			x = 0.747459 * safezoneW + safezoneX;
			y = 0.467003 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.0329999 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.3};
		};
		class picture_uniform: RscPicture
		{
			idc = 240415;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.747459 * safezoneW + safezoneX;
			y = 0.510999 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class frame_uniform: RscText
		{
			idc = 1009;
			x = 0.747459 * safezoneW + safezoneX;
			y = 0.510999 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.3};
		};
		class btnCdG: RscButton
		{
			action = "['cdg'] call BAR_fnc_setInsignia;";

			idc = 1602;
			text = "CdG"; //--- ToDo: Localize;
			x = 0.855722 * safezoneW + safezoneX;
			y = 0.335015 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
		};
		class btnCdE: RscButton
		{
			action = "['cde'] call BAR_fnc_setInsignia;";

			idc = 1603;
			text = "CdE"; //--- ToDo: Localize;
			x = 0.855722 * safezoneW + safezoneX;
			y = 0.368012 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
		};
		class btnMedic: RscButton
		{
			action = "['medic'] call BAR_fnc_setInsignia;";

			idc = 1604;
			text = "Medic"; //--- ToDo: Localize;
			x = 0.855722 * safezoneW + safezoneX;
			y = 0.401009 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
		};
		class btnBase: RscButton
		{
			action = "['base'] call BAR_fnc_setInsignia;";

			idc = 1605;
			text = "G-V"; //--- ToDo: Localize;
			x = 0.855722 * safezoneW + safezoneX;
			y = 0.434006 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
		};
		class btnCdS: RscButton
		{
			action = "['cds'] call BAR_fnc_setInsignia;";

			idc = 1606;
			text = "CdS"; //--- ToDo: Localize;
			x = 0.855722 * safezoneW + safezoneX;
			y = 0.302018 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
		};
		class btnCdGR: RscButton
		{
			action = "['cdgrouge'] call BAR_fnc_setInsignia;";

			idc = 1607;
			text = "CdG"; //--- ToDo: Localize;
			x = 0.89181 * safezoneW + safezoneX;
			y = 0.335015 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
			colorText[] = {1,0,0,1};
		};
		class btnCdER: RscButton
		{
			action = "['cderouge'] call BAR_fnc_setInsignia;";

			idc = 1608;
			text = "CdE"; //--- ToDo: Localize;
			x = 0.89181 * safezoneW + safezoneX;
			y = 0.368012 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
			colorText[] = {1,0,0,1};
		};
		class btnMedicR: RscButton
		{
			action = "['medicrouge'] call BAR_fnc_setInsignia;";

			idc = 1609;
			text = "Medic"; //--- ToDo: Localize;
			x = 0.89181 * safezoneW + safezoneX;
			y = 0.401009 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
			colorText[] = {1,0,0,1};
		};
		class btnBaseR: RscButton
		{
			action = "['baserouge'] call BAR_fnc_setInsignia;";

			idc = 1610;
			text = "G-V"; //--- ToDo: Localize;
			x = 0.89181 * safezoneW + safezoneX;
			y = 0.434006 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
			colorText[] = {1,0,0,1};
		};
		class btnCdGB: RscButton
		{
			action = "['cdgbleu'] call BAR_fnc_setInsignia;";

			idc = 1611;
			text = "CdG"; //--- ToDo: Localize;
			x = 0.927898 * safezoneW + safezoneX;
			y = 0.335015 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
			colorText[] = {0,0,1,1};
		};
		class btnCdEB: RscButton
		{
			action = "['cdebleu'] call BAR_fnc_setInsignia;";

			idc = 1612;
			text = "CdE"; //--- ToDo: Localize;
			x = 0.927898 * safezoneW + safezoneX;
			y = 0.368012 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
			colorText[] = {0,0,1,1};
		};
		class btnMedicB: RscButton
		{
			action = "['medicbleu'] call BAR_fnc_setInsignia;";

			idc = 1613;
			text = "Medic"; //--- ToDo: Localize;
			x = 0.927898 * safezoneW + safezoneX;
			y = 0.401009 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
			colorText[] = {0,0,1,1};
		};
		class btnBaseB: RscButton
		{
			action = "['basebleu'] call BAR_fnc_setInsignia;";

			idc = 1614;
			text = "G-V"; //--- ToDo: Localize;
			x = 0.927898 * safezoneW + safezoneX;
			y = 0.434006 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0249999 * safezoneH;
			colorText[] = {0,0,1,1};
		};
	};
};



////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Gautier, v1.063, #Rysera)
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
