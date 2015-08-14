// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: confirmSuicide.sqf
//	@file Author: AgentRev


if (!alive player) exitWith {};

_Bounty = player getVariable "BountyTarget";
if (_Bounty) exitWith
{
titleText ["You cannot take the easy route as the bounty target.", "PLAIN", 0.5];
};

if (["Are you sure you want to suicide?", "Confirm", "Yes", true] call BIS_fnc_guiMessage) then
{
		player allowDamage true;
		player setDamage 1;
};
