APOC_PM_Lock = {
	private["_player"];
	_player = _this select 0;
	{if ((typeof _x) in R3F_LOG_CFG_objets_deplacables) then
		{
		if !(_x getVariable ["objectLocked",false]) then 
			{
			_x setVariable ["objectLocked",true,true];
			_x setVariable ["ownerUID", getPlayerUID _player, true];
			};
		};
		sleep .1;
	} forEach (position _player nearObjects 50);
	//diag_log "PM_Lock function called";
	hint "Nearby objects locked";
};

APOC_PM_Unlock = {
	private["_player"];
	_player = _this select 0;	
	{if ((typeof _x) in R3F_LOG_CFG_objets_deplacables) then
		{
		if (_x getVariable ["ownerUID",""]==(getPlayerUID _player)) then 
			{
				_x setVariable ["objectLocked", false, true];
				_x setVariable ["ownerUID", nil, true];
				_x setVariable ["baseSaving_hoursAlive", nil, true];
				_x setVariable ["baseSaving_spawningTime", nil, true];
			};
		};
		sleep .1;
	} forEach (position _player nearobjects 50);
	//diag_log "PM_Unlock function called";
	hint "Nearby objects unlocked";
};

APOC_PM_InventoryLock = {
	private["_player"];
	_player = _this select 0;
	{if (({_x isKindOf "ReammoBox_F"})&&(_x getVariable ["ownerUID",""]==(getPlayerUID _player))&&(_x getVariable ["objectLocked",true])) then
		{
			_x setVariable ["A3W_inventoryLockR3F", true, true]; //Lock access to crate
			_x setVariable ["R3F_LOG_disabled", true, true]; //Remove logistics actions from crates/objects (makes them immobile)
		};
		sleep .1;
	} forEach (position _player nearObjects 50);
	//diag_log "PM_InventoryLock function called";
	hint "Nearby crates padlocked";	
};

APOC_PM_InventoryUnlock = {
	private["_player"];
	_player = _this select 0;
	{if (({_x isKindOf "ReammoBox_F"})&&(_x getVariable ["ownerUID",""]==(getPlayerUID _player))&&(_x getVariable ["objectLocked",true])&&(_x getVariable ["A3W_inventoryLockR3F",true])) then
		{
			_x setVariable ["A3W_inventoryLockR3F", false, true]; //Unlock access to crate
			_x setVariable ["R3F_LOG_disabled", false, true]; //Remove logistics actions from crates/objects (makes them immobile)
		};
		sleep .1;
	} forEach (position _player nearObjects 50);
	//diag_log "PM_InventoryLock function called";
	hint "Padlocks removed from nearby crates";	
};