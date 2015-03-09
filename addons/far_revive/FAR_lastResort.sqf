// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: FAR_lastResort.sqf
//	@file Author: AgentRev

private ["_hasCharge", "_hasSatchel", "_mineType", "_pos", "_mine", "_IsBountyTarget"];

_hasCharge = "DemoCharge_Remote_Mag" in magazines player;
_hasSatchel = "SatchelCharge_Remote_Mag" in magazines player;
_IsBountyTarget = false;

{
	if(getPlayerUID player == _x) then
		{
			_IsBountyTarget = true;
		};
}foreach pvar_BountySystemActiveTargets;


if !(player getVariable ["performingDuty", false]) then
{
	if ((_hasCharge || _hasSatchel) && !(_IsBountyTarget)) then
	{
		if (["Perform your duty?", "", "Yes", "No"] call BIS_fnc_guiMessage) then
		{
			player setVariable ["performingDuty", true];
			playSound3D [call currMissionDir + "client\sounds\lastresort.wss", vehicle player, false, getPosASL player, 0.7, 1, 1000];

			if (_hasSatchel) then
			{
				_mineType = "SatchelCharge_F";
				player removeMagazine "SatchelCharge_Remote_Mag";
			}
			else
			{
				_mineType = "DemoCharge_F";
				player removeMagazine "DemoCharge_Remote_Mag";
			};

			sleep 1.75;

			_pos = getPosATL player;
			_pos set [2, (_pos select 2) + 0.5];

			_mine = createMine [_mineType, _pos, [], 0];
			_mine setDamage 1;
			player setDamage 1;
			player setVariable ["performingDuty", nil];
		};
	}
	else
	{
		If (_IsBountyTarget) Then
		{
		titleText ["You cannot take the easy route as the bounty target.", "PLAIN", 0.5];
		} Else 
		{
		titleText ["Get an explosive charge next time, my child.", "PLAIN", 0.5];
		};
	};
};
