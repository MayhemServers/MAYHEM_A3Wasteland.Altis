
//	@file Name: mission_TownInvasion.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, Zenophon
//  @file Information: JoSchaap's Lite version of 'Infantry Occupy House' Original was made by: Zenophon

if (!isServer) exitwith {};

#include "bountyMissionDefines.sqf"

private ["_missionMarkerName","_missionType","_hint","_players","_marker","_count", "_foundPlayer", "_mission_state", "_playerName", "_playerSide", "_startTime", "_currTime","_missionEndStateNames","_alivePlayerCount"
,"_finished","_p", "_destPlayerUID", "_playerSideName", "_iterations", "_timeLeftIterations", "_killerSideName", "_playerMoney", "_randomIndex","_ignoreAiDeaths","_isPlayerOnServer"];


_setupVars =
{
    _ignoreAiDeaths = true;
	_missionMarkerName = "Bounty_Marker";
	_missionType = "Bounty Hunt";
	_missionEndStateNames = ["was killed", "survived", "was teamkilled", "suicided"];
};

_setupObjects =
{
	diag_log format["WASTELAND SERVER - Bounty Mission '%1' started", _missionType];

diag_log format["WASTELAND SERVER - Bounty Mission '%1' waiting to run", _missionType];
//[bountyMissionDelayTime] call createWaitCondition;
diag_log format["WASTELAND SERVER - Bounty Mission '%1' resumed", _missionType];

//select a random player
_players = playableUnits;
_count = count _players;

// Find out how many players are currently alive
_alivePlayerCount = 0;
for "_x" from 0 to (_count - 1) do {
	_p = _players select _x;
	if (alive _p) then {
		_alivePlayerCount = _alivePlayerCount + 1;
	};
};

// Fuck this language - seconded by s3kshun61 XD
if (_alivePlayerCount == 0) exitWith {};

// Keep looping over players until we find an alive one
_finished = 0;
	scopeName "main";
while {true} do {
	_random = floor(random _count);
	_potentialPlayer = _players select _random;

	if (alive _potentialPlayer) then {
		_foundPlayer = _potentialPlayer;
		_finished = 1;
	};

	if (_finished == 1) then {breakTo "main"}; // Breaks all scopes and return to "main"
	sleep 0.1;
};

_playerSide = side _foundPlayer;
_playerSideName =
switch (_playerSide) do
{
	case west: {"Blufor"};
	case east: {"Opfor"};
	case civilian: {"A.I."};
	case independent: {"Rebels"};
	default {"Unknown"};
};

_missionHintText = format ["<t align='center' color='%2' shadow='2' size='1.75'>Bounty Hunt</t><br/><t align='center' color='%2'>------------------------------</t><br/><t color='%3' size='1.0'>%1 on %4 has a bounty on his head. You have 30 minutes to kill him! Killer gets $50,000 and his side gets $5,000 per person. If he's protected he gets the $50,000 and his side gets $5,000 per person.</t>", name _foundPlayer, bountyMissionColor, subTextColor, _playerSideName];
//messageSystem = _hint;
//if (!isDedicated) then { call serverMessage };
//publicVariable "messageSystem";


_missionPos = position _foundPlayer;

//_marker = createMarker [_missionMarkerName, position _foundPlayer];
//_marker setMarkerType "mil_destroy";
//_marker setMarkerSize [1.25, 1.25];
//_marker setMarkerColor "ColorRed";
//_marker setMarkerText "Bounty Target";

//add the MP died event
_foundPlayer addMPEventHandler ["mpkilled", {[_this] call server_BountyDied;}];
_foundPlayer setVariable ["BountyTarget", true, true];

//get the variables so that if _foundPlayer instance changes we aren't fucked
_playerName = name _foundPlayer;
_destPlayerUID = getPlayerUID _foundPlayer;
_iterations = 0;
_timeLeftIterations = 0;
_mission_state = BOUNTY_MISSION_ACTIVE;
//failed conditions 0 - null, 1-pass, 2-timeout, 3-tk, 4-suic

_startTime = floor(time);

[format ["addBounty:%1:%2:%3:%4:%5:%6:%7:%8", call A3W_extDB_ServerID, call A3W_extDB_MapID, 'SYSTEM', getPlayerUID _foundPlayer, '0', _mission_state, 5000, 50000]] call extDB_Database_async;

};

_waitUntilMarkerPos =
{
		sleep 2;
		if(vehicle _foundPlayer == _foundplayer) then { _foundplayer = vehicle _foundplayer;};

		position _foundPlayer
};
_waitUntilExec = nil;
_waitUntilCondition =
{
	//diag_log format["WASTELAND SERVER - Bounty Mission '%1' Wait Until Failed Condition Start", _missionType];
//Mission Failed Condition
_currTime = (floor time);
if (_currTime - _startTime >= bountyMissionTimeout) then { _mission_state = BOUNTY_MISSION_END_SURVIVED; };

	//check to see if this player has been killed by someone
	if(!isNil "bKiller") then
	{
		_mission_state = BOUNTY_MISSION_END_KILLED;
		if(bKillerName == _playerName) then
		{
			_mission_state = BOUNTY_MISSION_END_SUICIDE;
		};
		if(bKillerSide == _playerSide) then
		{
			if(bkillerSide == independent) then
			{
				_mission_state = BOUNTY_MISSION_END_KILLED;
			}
			else
			{
				_mission_state = BOUNTY_MISSION_END_TEAMKILLED;
			};
		};
	};
		_isPlayerOnServer = 0;
		{
			if(name _x == _playerName) then
			{
				_isPlayerOnServer = 1;
			};
		}foreach playableUnits;


		if(_isPlayerOnServer == 0) then
		{
			_mission_state = BOUNTY_MISSION_END_DISCONNECT;
		};
	((_mission_state == BOUNTY_MISSION_END_SUICIDE) || (_mission_state == BOUNTY_MISSION_END_TEAMKILLED) || (_mission_state == BOUNTY_MISSION_END_SURVIVED) || (_mission_state == BOUNTY_MISSION_END_DISCONNECT))
};

_waitUntilSuccessCondition =
{
	//diag_log format["WASTELAND SERVER - Bounty Mission '%1' Wait Until Success Condition Start", _missionType];
//Mission Success Condition
_currTime = (floor time);
if(!isNil "bKiller") then
	{
		_mission_state = BOUNTY_MISSION_END_KILLED;
		if(bKillerName == _playerName) then { _mission_state = BOUNTY_MISSION_END_SUICIDE;};
		if(bKillerSide == _playerSide) then {
		if(bkillerSide == independent) then {_mission_state = BOUNTY_MISSION_END_KILLED;} else {_mission_state = BOUNTY_MISSION_END_TEAMKILLED;};
		};
	};

	//diag_log format["WASTELAND SERVER - Bounty Mission '%1' Wait Until Success Condition End", _missionType];
	//diag_log format["WASTELAND SERVER - Bounty Mission Success Status '%1'", (_mission_state == BOUNTY_MISSION_END_KILLED)];

	(_mission_state == BOUNTY_MISSION_END_KILLED)

};

_failedExec =
{
	diag_log format["WASTELAND SERVER - Bounty Mission '%1' Failed Started", _missionType];
	diag_log format["WASTELAND SERVER - Bounty Mission Player Side '%1'", _playerSide];
	// Mission failed
	if (_mission_state == BOUNTY_MISSION_END_SURVIVED) then {

		// Money for survivor + extra money for team
		_playerMoney = _foundPlayer getVariable "cmoney";
		_playerMoney = _playerMoney + 50000;
		[format ["updateBounty:%1:%2:%3:%4", _destPlayerUID, _destPlayerUID,'0', _mission_state]] call extDB_Database_async;
		[format ["setPlayerBountyDisabled:%1", _destPlayerUID]] call extDB_Database_async;
		_foundPlayer setVariable["cmoney", _playerMoney, true];
		{
			if(side _x == _playerSide)then
			{
				if(_playerName != name _x) then
				{
					_playerMoney = _x getVariable "cmoney";
					_playerMoney = _playerMoney + 5000;
					_x setVariable["cmoney",_playerMoney,true];
				};
			};
		}foreach playableUnits;

		_failedHintMessage = format ["<t align='center' color='%2' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%2' size='1.25'>%1 lives!</t><br/><br/><t align='center' color='%3'>%1 gets $10,000 and every member of %4 get $1,000!</t>", _playerName, failMissionColor, subTextColor, _playerSideName];
	};

	// Unlucky
	if (_mission_state == BOUNTY_MISSION_END_TEAMKILLED) then {
		// Loop over each player on that side and remove their money and guns
		{
			if(side _x == bKillerSide)then
			{
				_x setVariable["cmoney", 0, true];
				removeAllWeapons _x;
				[format ["updateBounty:%1:%2:%3:%4", _destPlayerUID, '0', getPlayerUID _x, _mission_state]] call extDB_Database_async;
				[format ["setPlayerBountyDisabled:%1", _destPlayerUID]] call extDB_Database_async;
			};
		}foreach playableUnits;

		_failedHintMessage = format ["<t align='center' color='%2' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%3' size='1.25'>%1 was teamkilled!</t><br/><br/><t align='center' color='%3'>Naughty naughty team players. As a penalty %4 has lost all their weapons and money!</t>", _playerName, failMissionColor, subTextColor, _playerSideName];
	};

	// Dumbass
	if (_mission_state == BOUNTY_MISSION_END_SUICIDE) then {
		_failedHintMessage =  format ["<t align='center' color='%2' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%3' size='1.25'>PUSSY!!</t><br/><br/><t align='center' color='%3'>%1 took the coward's way out and committed suicide!</t>", _playerName, failMissionColor, subTextColor];
		[format ["updateBounty:%1:%2:%3:%4", _destPlayerUID, '0','0', _mission_state]] call extDB_Database_async;
		[format ["setPlayerBountyDisabled:%1", _destPlayerUID]] call extDB_Database_async;
	};

	// Coward
	if (_mission_state == BOUNTY_MISSION_END_DISCONNECT) then {
		_failedHintMessage =  format ["<t align='center' color='%2' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%3' size='1.25'>PUSSY!!</t><br/><br/><t align='center' color='%3'>%1 took the coward's way out and disconnected! He will become the bounty when he reconnects!</t>", _playerName, failMissionColor, subTextColor];
		[format ["updateBounty:%1:%2:%3:%4", _destPlayerUID, '0','0', _mission_state]] call extDB_Database_async;
	};

	//remove the event
	//_foundPlayer removeAllMPEventHandlers "mpkilled";

	//reset the bountykiller variables
	bKiller = nil;
	bKillerName = nil;
	bKillerSide = nil;

	//diag_log format["WASTELAND SERVER - Bounty Mission '%1' Failed End", _missionType];

};

_successExec =
{
	// Mission completed
	diag_log format["WASTELAND SERVER - Bounty Mission '%1' Success Start", _missionType];
	diag_log format["WASTELAND SERVER - Bounty Mission Player Side '%1'", _playerSide];

	// Mission success: The bounty was killed, so issue awards
	//the player and his team reap the rewards
	_playerMoney = bKiller getVariable "cmoney";
	_playerMoney = _playerMoney + 50000;
	[format ["updateBounty:%1:%2:%3:%4", _destPlayerUID, getPlayerUID bKiller, getPlayerUID bKiller, _mission_state]] call extDB_Database_async;
	[format ["setPlayerBountyDisabled:%1", _destPlayerUID]] call extDB_Database_async;

	bKiller setVariable["cmoney", _playerMoney, true];
	{
		if(side _x == bKillerSide) then
		{
			if(bKillerName != name _x) then
			{
				_playerMoney = _x getVariable "cmoney";
				_playerMoney = _playerMoney + 5000;
				_x setVariable["cmoney",_playerMoney,true];
			};
		};
	}foreach playableUnits;


	//remove the event
	//_foundPlayer removeAllMPEventHandlers "mpkilled";

	//reset the bountykiller variables
	bKiller = nil;
	bKillerName = nil;
	bKillerSide = nil;

	_successHintMessage = format ["<br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%6' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%3'>%1 has been killed by %4! %5 has earned $5,000 for each member and %4 has earned $50,000!</t>", _playerName, successMissionColor, subTextColor, bKillerName, _killerSideName, failMissionColor];

	diag_log format["WASTELAND SERVER - Bounty Mission '%1' Success End", _missionType];
};

_this call bountyMissionProcessor;
