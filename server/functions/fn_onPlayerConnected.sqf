// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_onPlayerConnected.sqf
//	@file Author: AgentRev

private ["_id", "_uid", "_name", "_bountydisconnect","_result"];
_id = _this select 0;
_uid = _this select 1;
_name = _this select 2;
/*
if(_name != "__SERVER__") then
{
	

	{
		if(_uid == getPlayerUID _x) then
		{
			_x addMPEventHandler ["mprespawn", {[_x] call fn_onPlayerRespawn;}];	
			diag_log format ["Adding Respawn Event Handler: %1 (%2)", _name, _uid];
		};
		
	}foreach playableUnits;
	
	_bountydisconnect = 0;
	if(!isNil "_uid") then
	{
	_result = [format ["checkPlayerBountyDisconnect:%1:%2:%3", 1 , 1, _uid],2] call extDB_Database_async;
	diag_log format["WASTELAND SERVER - Bounty Disconnect Result '%1' Player - '%2'", _result, _uid];
	_bountydisconnect = _result select 0;
	
	};

	if(_bountydisconnect > 0) then
	{
		pvar_BountySystemReconnects = pvar_BountySystemReconnects + [_uid];
		diag_log format["WASTELAND SERVER - Bounty Reconnected '%1'", _uid];
	};
};

*/
diag_log format ["Player connected: %1 (%2)", _name, _uid];
