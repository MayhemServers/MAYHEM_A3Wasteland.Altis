// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: confirmSuicide.sqf
//	@file Author: AgentRev

private ["_IsBountyTarget"];
_IsBountyTarget = false;
if (!alive player) exitWith {};

If (player getVariable ["isBountyTarget",false]) then
{
	_IsBountyTarget = true;
};


if (["Are you sure you want to suicide?", "Confirm", "Yes", true] call BIS_fnc_guiMessage) then
{	
	if !(_IsBountyTarget) then
	{
		player allowDamage true;
		player setDamage 1;
	} else
	{
		hint "You cannot suicide when you are the bounty target!";
	};
};
