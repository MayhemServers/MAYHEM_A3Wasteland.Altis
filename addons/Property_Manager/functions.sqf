PM_Lock = {
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
	diag_log "PM_Lock function called";
	hint "Nearby objects locked";
};

PM_Unlock = {
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
	diag_log "PM_Unlock function called";
	hint "Nearby objects unlocked";
};
