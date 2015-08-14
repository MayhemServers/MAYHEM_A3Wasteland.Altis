//	@file Name: init.sqf
//	@file Author: [s3k] Centrifugal
// Bounty system for player use.

#define bountyMissionDelayTime 20*60
#define bountyMissionColor "#ffff00"
#define subTextColor "#FFFFFF"

if (!isServer) exitWith {};

private ["_lastSystemMission","_currentTime","_IsPlayerAlive","_IsPlayerBounty","_alivePlayerCount","_players","_count","_random","_potentialPlayer","_foundPlayer"];

diag_log "WASTELAND SERVER - Bounty System Main Loop Started";

sleep 150;
_lastSystemMission = floor(time);

[
		parseText format
		[
			"<t color='%1' shadow='2' size='1.75'>%2 Objective%3</t><br/>" +
			"<t color='%1'>------------------------------</t><br/>" +
			"<t color='%4' size='1.0'>Starting in %5 minutes</t>",
			bountyMissionColor,
			'Bounty',
			'',
			subTextColor,
			bountyMissionDelayTime / 60
		]
] call hintBroadcast;


while {true} do
{
	sleep 30;
	_currentTime = floor(time);
	private ["_dequeuedBounties"];
	_dequeuedBounties = [];
	_players = playableUnits;
	{
		private ["_currentPlayerUID"];
		_currentPlayerUID = getPlayerUID _x;
		{
			if(_currentPlayerUID == _x) then
			{
				_dequeuedBounties = _dequeuedBounties + [_x];
				[_x,'COWARD'] execVM format ["server\systems\bounties\playerLoop.sqf"];
			};
		}foreach pvar_BountySystemReconnects;
	}foreach _players;

	pvar_BountySystemReconnects = [];
	_dequeuedBounties = [];

	if (_currentTime - _lastSystemMission >= bountyMissionDelayTime) then
	{
			_lastSystemMission = floor(time);

			_foundPlayer = nil;
			_IsPlayerAlive = false;
			_IsPlayerBounty = false;

			_players = playableUnits;
			_count = count _players;

			_alivePlayerCount = 0;
			for "_x" from 0 to (_count - 1) do {
				_p = _players select _x;
				if (alive _p) then {
					_alivePlayerCount = _alivePlayerCount + 1;
				};
			};


			if (_alivePlayerCount == 0) exitWith {};

			// Keep looping over players until we find an alive one

			while {true} do {
				_random = floor(random _count);
				_potentialPlayer = _players select _random;

				if (alive _potentialPlayer) then {
					_foundPlayer = _potentialPlayer;
					_IsPlayerAlive = true;
				};

				{
					if(getPlayerUID _foundPlayer == _x) then
					{
						_IsPlayerBounty = true;
					};
				}foreach pvar_BountySystemActiveTargets;

				if(_IsPlayerAlive && (!_IsPlayerBounty)) exitWith {};


			};

			if(!isnil "_foundPlayer") then
			{
				[getPlayerUID _foundPlayer,'SYSTEM'] execVM format ["server\systems\bounties\playerLoop.sqf"];
			};
	};

};

