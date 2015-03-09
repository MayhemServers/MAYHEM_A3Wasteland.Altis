private ["_targetPlayer","_sourcePlayer","_bountyAmount"];
_targetPlayer = _this select 0;
_sourcePlayer = _this select 1;
_bountyAmount = _this select 2;

[getPlayerUID _targetPlayer,'PLAYER'] execVM format ["server\systems\bounties\playerLoop.sqf"];