PM_Lock = {
	private["_player"];
	_player = _this select 0;
	{if !(_x getVariable ["objectLocked",false]) then 
		{
		_x setVariable ["objectLocked",true,true];
		_x setVariable ["ownerUID", getPlayerUID _player, true];
		};
	} forEach (position _player nearObjects [typeof in R3F_LOG_CFG_objets_deplacables, 50]);
	diag_log "PM_Lock function called";
};

PM_Unlock = {
	private["_player"];
	_player = _this select 0;	
	{if !(_x getVariable ["ownerUID",""]==(getPlayerUID _player)) then 
		{
			_x setVariable ["objectLocked", false, true];
			_x setVariable ["ownerUID", nil, true];
			_x setVariable ["baseSaving_hoursAlive", nil, true];
			_x setVariable ["baseSaving_spawningTime", nil, true];
		};
	} forEach (position _player nearobjects [typeof in R3F_LOG_CFG_objets_deplacables, 50]);
	diag_log "PM_Unlock function called";
};
R3F_LOG_CFG_objets_deplacables