class PM_dialog
{
	idd=-1;
	movingenable=true;
	
	class controls 
	{
		class PM_Box: BOX
		{
			idc = -1;
			text = ""; //--- ToDo: Localize;
			x = 0.387062 * safezoneW + safezoneX;
			y = 0.270 * safezoneH + safezoneY;
			w = 0.227875 * safezoneW;
			h = 0.42 * safezoneH;
		};
		class PM_Frame: RscFrame
		{
			idc = -1;
			text = "Property Manager Frame"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.418 * safezoneH;
		};
		class PM_Title: RscText
		{
			idc = -1;
			text = "Property Manager PRO"; //--- ToDo: Localize;
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
		};
		class PM_Button_Unlock: RscButton
		{
			idc = -1;
			text = "UNLOCK"; //--- ToDo: Localize;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Unlocks your nearby objects"; //--- ToDo: Localize;
			action = "closeDialog 0;_nil=[player]Spawn PM_Unlock";
		};
		class PM_Button_Lock: RscButton
		{
			idc = -1;
			text = "LOCK"; //--- ToDo: Localize;
			x = 0.546406 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Locks nearby objects."; //--- ToDo: Localize;
			action = "closeDialog 0;_nil=[player]Spawn PM_Lock";
		};
		class PM_Button_Cancel: RscButton
		{
			idc = -1;
			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Closes the Property Manager."; //--- ToDo: Localize;
			action = "closeDialog 0";
		};
		class PM_Text_Description: RscText
		{
			idc = -1;
			text = "Unlocking via property manager will unlock your objects within 50m.  Locking will lock all objects within 50m to your name."; //--- ToDo: Localize;
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.242 * safezoneH;
		};
	};
};