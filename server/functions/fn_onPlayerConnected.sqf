// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_onPlayerConnected.sqf
//	@file Author: AgentRev

private ["_id", "_uid", "_name", "_bountydisconnect","_result"];
_id = _this select 0;
_uid = _this select 1;
_name = _this select 2;
_ifcheck = 2;
_bountydisconnect = 0;


if(_name != "__SERVER__") then
{
_ifcheck = 0;
_vars =
[
        ["MissionState", 1] // >4
        //["Reconnect", 1] // 1

];

_columns = "";

        {
        _columns = _columns + ((if (_columns != "") then { "," } else { "" }) + (_x select 0));
        } forEach _vars;

//Apoc - Bounty System - Check connecting player for Coward status  ///////////////////////////////////////
        _result = [format ["checkPlayerBountyDisconnect:%1:%2:%3", call A3W_extDB_ServerID, _uid, _columns],2] call extDB_Database_async;
        diag_log format["WASTELAND SERVER - Bounty Disconnect Result '%1' Player - '%2'", _result, _uid];

        if ( count _result < 1) then {diag_log format ["Player connected: %1 (%2)", _name, _uid];
        }else{
        _bountydisconnect = _result select 0;


                if(_bountydisconnect > 4) then
                {
                        pvar_BountySystemReconnects = pvar_BountySystemReconnects + [_uid];
                        diag_log format["WASTELAND SERVER - Bounty Reconnected '%1'", _uid];
                }else{

                        if(_bountydisconnect < 5) then
                        {
                        diag_log format ["Player connected has no Bounty: %1 (%2)", _name, _uid];
                        };
                };

        };
//Apoc - Bounty System - Check connecting player for Coward status End ///////////////////////////////////////

};
if (_ifcheck == 2) then {diag_log format ["Player connected: %1 (%2)", _name, _uid]};