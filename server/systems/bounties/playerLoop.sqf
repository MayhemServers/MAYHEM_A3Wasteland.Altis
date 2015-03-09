//	@file Name: init.sqf
//	@file Author: [s3k] Centrifugal
// Bounty system for player use.

#define MISSION_PROC_COLOR_DEFINE "#0054fe"
#define MISSION_PROC_TYPE_NAME "Bounty Hunt"
#define bountyMissionTimeout 30*60
#define bountyMissionDelayTime 20*60
#define missionRadiusTrigger 50
#define bountyMissionColor "#0054fe"
#define failMissionColor "#FF1717"
#define successMissionColor "#17FF41"
#define subTextColor "#FFFFFF"

#define BOUNTY_MISSION_ACTIVE 0
#define BOUNTY_MISSION_END_KILLED 1
#define BOUNTY_MISSION_END_SURVIVED 2
#define BOUNTY_MISSION_END_TEAMKILLED 3
#define BOUNTY_MISSION_END_SUICIDE 4
#define BOUNTY_MISSION_END_DISCONNECT 5

if (!isServer) exitWith {};


private ["_targetUID","_targetName","_targetPlayer","_targetSide","_targetSideName","_targetFriendlies","_killer","_killerUID","_killerName","_killerSide","_targetMarker","_BountyType","_missionHintText","_missionPicture","_missionMarkerName","_missionType","_hint","_players","_marker","_count", "_mission_state", "_startTime", "_currTime","_missionEndStateNames","_alivePlayerCount"
,"_finished","_p", "_destPlayerUID", "_playerSideName", "_iterations", "_timeLeftIterations", "_killerSideName", "_playerMoney","_isPlayerOnServer","_sourceUID","_successHintMessage","_failedHintMessage","_targetGroup","_targetGroupID","_killerIsFriendly"];


_targetFriendlies = [];
_targetUID = _this select 0;
_BountyType = _this select 1;

_mission_state = BOUNTY_MISSION_ACTIVE;

pvar_BountySystemActiveTargets = pvar_BountySystemActiveTargets + [_targetUID];

{
		if(_targetUID == getPlayerUID _x) then
		{
			_targetPlayer = _x;
			_targetName = name _x;		
		};
		
}foreach playableUnits;

_targetSide = side _targetPlayer;
_targetSideName = 
switch (_targetSide) do 
{
	case west: {"Blufor"}; 
	case east: {"Opfor"};
	case civilian: {"A.I."};
	case independent: {"Rebels"};
	default {"Unknown"};
};


_targetGroup = group _targetPlayer;

if(!isnil "_targetGroup") then
{
	_targetGroupID = groupID _targetGroup;
	{
		_targetFriendlies = _targetFriendlies + [name _x];
	}foreach units _targetGroup;
	
};





if(_BountyType == 'COWARD') then
{
_missionHintText = format ["<br/><t align='center' color='%2'>------------------------------</t><br/><t color='%3' size='1.0'>The coward %1 on %4 has reconnected and a bounty is still on his head. Let's hope he doesn't run away like a pussy again! You have 30 minutes to kill him! Killer gets $50,000 and his side gets $5,000 per person. If he's protected he gets the $50,000 and his side gets $5,000 per person.</t>", _targetName, bountyMissionColor, subTextColor, _targetSideName];
_missionType = "Coward Bounty";
};

if(_BountyType == 'SYSTEM') then
{
_missionHintText = format ["<br/><t align='center' color='%2'>------------------------------</t><br/><t color='%3' size='1.0'>%1 on %4 has a bounty on his head. You have 30 minutes to kill him! Killer gets $50,000 and his side gets $5,000 per person. If he's protected he gets the $50,000 and his side gets $5,000 per person.</t>", _targetName, bountyMissionColor, subTextColor, _targetSideName];
_missionType = "Bounty";
};

if(_BountyType == 'PLAYER') then
{
_missionHintText = format ["<br/><t align='center' color='%2'>------------------------------</t><br/><t color='%3' size='1.0'>%1 on %4 has a bounty on his head. You have 30 minutes to kill him! Killer gets $50,000 and his side gets $5,000 per person. If he's protected he gets the $50,000 and his side gets $5,000 per person.</t>", _targetName, bountyMissionColor, subTextColor, _targetSideName];
_missionType = "Player Bounty";
};


_missionPicture = getText (configFile >> "CfgWeapons" >> "A3_Weapons_F_LongRangeRifles_M320" >> "picture");;


_targetPlayer addMPEventHandler ["mpkilled", {[_this] call onBountySystemPlayerDied;}];

[
	format ["%1 Objective", MISSION_PROC_TYPE_NAME],
	_missionType,
	_missionPicture,
	_missionHintText,
	MISSION_PROC_COLOR_DEFINE
]
call missionHint;

if(isnil "_sourceUID") then
{
	_sourceUID = '0';
};

//[format ["addBounty:%1:%2:%3:%4:%5:%6:%7:%8", call A3W_extDB_ServerID, call A3W_extDB_MapID, _BountyType, _targetUID, _sourceUID, _mission_state, 5000, 50000]] call extDB_Database_async;


_missionPos = position _targetPlayer;

_targetMarker = [_missionType, _missionPos] call createMissionMarker;

_startTime = floor(time);
diag_log "WASTELAND SERVER - Bounty System Main Loop Started";
private ["_bountyDeath"];

while {true} do
{
sleep 10;
_currTime = (floor time);




if (_currTime - _startTime >= bountyMissionTimeout) then 
{ 
		_mission_state = BOUNTY_MISSION_END_SURVIVED; 
};

//Update Marker
_targetMarker setMarkerPos (position _targetPlayer);

if(!isnil "_targetGroup") then
{
	{
		private ["_friendlyFound","_friendlyName"];
		_friendlyFound = false;
		_friendlyName = name _x;
		{
			if(_friendlyName == _x) then
			{
				_friendlyFound = true;
			};
		}foreach _targetFriendlies;
		
		if(!_friendlyFound) then
		{
			_targetFriendlies = _targetFriendlies + [_friendlyName];
		};
	}foreach units _targetGroup;
};


{

	


	private ["_player"];
	_player = _x select 0;
	

	if(name _player == _targetName) then
	{
		_bountyDeath = _x;
		_killer = _x select 1;
		_killerName = name _killer;
		_killerSide = side _killer;
		_killerUID = getPlayerUID _killer;
		
		_killerSideName = 
		switch (_killerSide) do 
		{
			case west: {"Blufor"}; 
			case east: {"Opfor"};
			case civilian: {"A.I."};
			case independent: {"Rebels"};
			default {"Unknown"};
		};
		
	};
	
	
		
}foreach pvar_BountySystemTargetDeaths;

if(!isNil "_killer") then
{ 
		_mission_state = BOUNTY_MISSION_END_KILLED;
		if(_killerName == _targetName) then 
		{ 
			_mission_state = BOUNTY_MISSION_END_SUICIDE;
		}
		else 
		{
			if(_killerSide == _targetSide) then 
			{ 
				if(_killerSide == independent) then 
				{
					
					_killerIsFriendly = 0;
					diag_log format ["Is Killer Friendly: %1", _killerIsFriendly];
					diag_log format ["_killerName: %1", _killerName];
					diag_log format ["_targetFriendlies: %1", _targetFriendlies];
					{
						if(_killerName == _x) then
						{
							_killerIsFriendly = 1;
						};
					}foreach _targetFriendlies;
					
					if(_killerIsFriendly == 1) then
					{
						_mission_state = BOUNTY_MISSION_END_TEAMKILLED;
					}
					else
					{
						_mission_state = BOUNTY_MISSION_END_KILLED;
					};
				} 
				else 
				{
					_mission_state = BOUNTY_MISSION_END_TEAMKILLED;
				};
			};
		};
};

if(!(_mission_state == BOUNTY_MISSION_END_SUICIDE || _mission_state == BOUNTY_MISSION_END_TEAMKILLED || _mission_state == BOUNTY_MISSION_END_KILLED)) then
{
	_isPlayerOnServer = 0;
	_players = playableUnits;
	{
			if(name _x == _targetName) then
			{
				_isPlayerOnServer = 1;
			};
	}foreach _players;
		
		
	if(_isPlayerOnServer == 0) then
	{
			 diag_log format ["Player Not On Server: %1 PlayerName: %2", _targetUID, _targetName];
			_mission_state = BOUNTY_MISSION_END_DISCONNECT;
	};
};

diag_log format ["Custom Bounty in Progress: %1", _targetUID];

if (_mission_state != BOUNTY_MISSION_ACTIVE) exitWith {};	

};

diag_log format ["Custom Bounty Cleanup: %1", _targetUID];
if(!isnil "_bountyDeath") then
{
	pvar_BountySystemTargetDeaths = pvar_BountySystemTargetDeaths - _bountyDeath;
};

//remove the event
_targetPlayer removeAllMPEventHandlers "mpkilled"; 

sleep 1;
//Mission Reward Logic Start

if (_mission_state == BOUNTY_MISSION_END_SURVIVED) then {

		// Money for survivor + extra money for team
		_playerMoney = _targetPlayer getVariable "cmoney";
		_playerMoney = _playerMoney + 50000;
		//[format ["updateBounty:%1:%2:%3:%4", _targetUID, _targetUID,'0', _mission_state]] call extDB_Database_async;
		//[format ["setPlayerBountyDisabled:%1", _targetUID]] call extDB_Database_async;
		_targetPlayer setVariable["cmoney", _playerMoney, true];
		_players = playableUnits;
		{
			if(side _x == _targetSide)then
			{
				if(_targetName != name _x) then
				{
					_playerMoney = _x getVariable "cmoney";
					_playerMoney = _playerMoney + 5000;
					_x setVariable["cmoney",_playerMoney,true];
				};
			};
		}foreach _players;

		_failedHintMessage = format ["<br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%2' size='1.25'>%1 lives!</t><br/><br/><t align='center' color='%3'>%1 gets $50,000 and every member of %4 get $5,000!</t>", _targetName, failMissionColor, subTextColor, _targetSideName];
	};

	// Unlucky
	if (_mission_state == BOUNTY_MISSION_END_TEAMKILLED) then {
		// Loop over each player on that side and remove their money and guns
		
		//[format ["updateBounty:%1:%2:%3:%4", _targetUID, '0', _killerUID, _mission_state]] call extDB_Database_async;
		//[format ["setPlayerBountyDisabled:%1", _targetUID]] call extDB_Database_async;
		
		_players = playableUnits;
		{
			private ["_currentLoopPlayer"];
			_currentLoopPlayer = _x;
			if(_killerSide == independent) then
			{
				{
					if(!isnil "_x") then
					{
						if(name _currentLoopPlayer == _x) then
						{
							_currentLoopPlayer setVariable["cmoney", 0, true];
							removeAllWeapons _currentLoopPlayer;
						};	
					};
				}foreach _targetFriendlies;
			}
			else
			{
				if(side _currentLoopPlayer == _killerSide)then
				{
					_currentLoopPlayer setVariable["cmoney", 0, true];
					removeAllWeapons _currentLoopPlayer;
					
				};
			};
			
		}foreach _players;

		_failedHintMessage = format ["<t align='center' color='%2' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%3' size='1.25'>%1 was teamkilled!</t><br/><br/><t align='center' color='%3'>Naughty naughty team players. As a penalty %4 has lost all their weapons and money!</t>", _targetName, failMissionColor, subTextColor, _targetSideName];
	};

	// Dumbass
	if (_mission_state == BOUNTY_MISSION_END_SUICIDE) then {
		_failedHintMessage =  format ["<t align='center' color='%2' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%3' size='1.25'>PUSSY!!</t><br/><br/><t align='center' color='%3'>%1 took the coward's way out and committed suicide!</t>", _targetName, failMissionColor, subTextColor];
		//[format ["updateBounty:%1:%2:%3:%4", _targetUID, '0','0', _mission_state]] call extDB_Database_async;
		//[format ["setPlayerBountyDisabled:%1", _targetUID]] call extDB_Database_async;
	};
	
	// Coward
	
		if (_mission_state == BOUNTY_MISSION_END_DISCONNECT) then {
			_failedHintMessage =  format ["<br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%3' size='1.25'>PUSSY!!</t><br/><br/><t align='center' color='%3'>%1 took the coward's way out and disconnected! He will become the bounty when he reconnects!</t>", _targetName, failMissionColor, subTextColor];
			//[format ["updateBounty:%1:%2:%3:%4", _targetUID, '0','0', _mission_state]] call extDB_Database_async;
			
		};
	
	
	if (_mission_state == BOUNTY_MISSION_END_KILLED) then 
	{
		_playerMoney = _killer getVariable "cmoney";
		
		if(!isnil "_playerMoney") then
		{
			_playerMoney = _playerMoney + 50000;
			//[format ["updateBounty:%1:%2:%3:%4", _targetUID, _killerUID, _killerUID, _mission_state]] call extDB_Database_async;
			//[format ["setPlayerBountyDisabled:%1", _targetUID]] call extDB_Database_async;
			
			_killer setVariable["cmoney", _playerMoney, true];
			{
				if(side _x == _killerSide) then
				{
					if(_killerName != name _x) then
					{
						_playerMoney = _x getVariable "cmoney";
						_playerMoney = _playerMoney + 5000;
						_x setVariable["cmoney",_playerMoney,true];
					};
				};
			}foreach playableUnits;
		};
		_successHintMessage = format ["<br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%6' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%3'>%1 has been killed by %4! %5 has earned $5,000 for each member and %4 has earned $50,000!</t>", _targetName, successMissionColor, subTextColor, _killerName, _killerSideName, failMissionColor];

	
	};

//Mission Reward Logic End
sleep 1;
//Mission End Notifications Start
if(!isnil "_failedHintMessage") then
{
	[
		"Objective Failed",
		_missionType,
		_missionPicture,
		_failedHintMessage ,
		failMissionColor
	]
	call missionHint;
};

if(!isnil "_successHintMessage") then
{
	[
		"Objective Complete",
		_missionType,
		_missionPicture,
		_successHintMessage,
		successMissionColor
	]
	call missionHint;
};

//Mission End Notifications End

diag_log format ["Custom Bounty ended: %1", _targetUID];

deleteMarker _targetMarker;

pvar_BountySystemActiveTargets = pvar_BountySystemActiveTargets - [_targetUID];

diag_log format ["Custom Bounty Remaining Targets %1", pvar_BountySystemActiveTargets];

