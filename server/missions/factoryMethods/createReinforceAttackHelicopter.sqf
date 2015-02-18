// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileHelicopter.sqf
//	@file Author: JoSchaap, AgentRev

if (!isServer) exitwith {};
//#include "sideMissionDefines.sqf"

private ["_vehicleClass", "_vehicle", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2", "_callLocation"];

_callLocation _this select 0;  //parameter passed from the missionProcessor which called for help, set as ai location when reinforcement was called

_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);  //we'll use this to have random start locations for the reinforcement helos

_vehicleClass = ["B_Heli_Attack_01_F", "O_Heli_Attack_02_black_F","B_Heli_Light_01_armed_F", "O_Heli_Light_02_F", "I_Heli_light_03_F"] call BIS_fnc_selectRandom;

_createVehicle =
{
	private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

	_type = _this select 0;
	_position = _this select 1;
	_direction = _this select 2;

	_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
	_vehicle setVariable ["R3F_LOG_disabled", true, true];
	[_vehicle] call vehicleSetup;

	_vehicle setDir _direction;
	_aiGroup2 addVehicle _vehicle;

	// add a driver/pilot/captain to the vehicle
	// the little bird, orca, and hellcat do not require gunners and should not have any passengers
	_soldier = [_aiGroup2, _position] call createRandomSoldierC;
	_soldier moveInDriver _vehicle;

	switch (true) do
	{
		case (_type isKindOf "Heli_Transport_01_base_F"):
		{
			// these choppers have 2 turrets so we need 2 gunners
			_soldier = [_aiGroup2, _position] call createRandomSoldierC;
			_soldier moveInTurret [_vehicle, [1]];

			_soldier = [_aiGroup2, _position] call createRandomSoldierC;
			_soldier moveInTurret [_vehicle, [2]];
		};

		case (_type isKindOf "Heli_Attack_01_base_F" || _type isKindOf "Heli_Attack_02_base_F"):
		{
			// these choppers need 1 gunner
			_soldier = [_aiGroup2, _position] call createRandomSoldierC;
			_soldier moveInGunner _vehicle;
		};
	};

	// remove flares because it overpowers AI choppers
	if (_type isKindOf "Air") then
	{
		{
			if (["CMFlare", _x] call fn_findString != -1) then
			{
				_vehicle removeMagazinesTurret [_x, [-1]];
			};
		} forEach getArray (configFile >> "CfgVehicles" >> _type >> "magazines");
	};

	[_vehicle, _aiGroup2] spawn checkMissionVehicleLock;
	_vehicle
};

_aiGroup2 = createGroup CIVILIAN;

_vehicle = [_vehicleClass, _missionPos, 0] call _createVehicle;

_leader = effectiveCommander _vehicle;
_aiGroup2 selectLeader _leader;

_aiGroup2 setCombatMode "WHITE"; // Defensive behaviour
_aiGroup2 setBehaviour "AWARE";
_aiGroup2 setFormation "STAG COLUMN";

_speedMode = if (missionDifficultyHard) then { "FULL" } else { "NORMAL" }; //speed them up to get there 

_aiGroup2 setSpeedMode _speedMode;

// behaviour on waypoints

//Waypoint 1 - Get to Trouble Location
	_waypoint = _aiGroup2 addWaypoint _callLocation;
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 50;
	_waypoint setWaypointCombatMode "GREEN";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointFormation "STAG COLUMN";
	_waypoint setWaypointSpeed _speedMode;
	
//Waypoint 2 - Take Care of Business
	_waypoint2 = _aiGroup2 addWaypoint _callLocation;
	_waypoint2 setWaypointType "Loiter";
	_waypoint2 setWaypointLoiterRadius 500;
	_waypoint2 setWaypointCombatMode "RED";
	_waypoint2 setWaypointBehaviour "COMBAT";

/*
_missionPos = getPosATL leader _aiGroup2;

_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");

_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Intercept it and recover its cargo!", _vehicleName, sideMissionColor];

_numWaypoints = count waypoints _aiGroup2;


_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup2 >= _numWaypoints};

_failedExec = nil;

// _vehicle is automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	_box1 = createVehicle ["Box_NATO_Wps_F", _lastPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_Wps_F", _lastPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates have fallen near the wreck.";
};

_this call sideMissionProcessor;
*/