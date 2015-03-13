private ["_targetPlayer","_sourcePlayer","_bountyAmount"];
_targetPlayer = _this select 0;
_bountyAmount = _this select 1;

[getPlayerUID _targetPlayer,'SYSTEM'] execVM format ["server\systems\bounties\playerLoop.sqf"];