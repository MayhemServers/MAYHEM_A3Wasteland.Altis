private ["_targetPlayer","_targetPlayerName","_bountyAmount"];
_targetPlayerName = _this select 0;
_bountyAmount = _this select 1;


{
	if(name _x == _targetPlayerName) then
	{
		_targetPlayer = _x;
	};
}foreach playableUnits;

if(!isnil "_targetPlayer") then
{
[_targetPlayer,_bountyAmount] call startSystemBounty;
};

