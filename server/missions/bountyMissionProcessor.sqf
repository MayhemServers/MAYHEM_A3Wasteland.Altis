//	@file Name: bountyMissionProcessor.sqf
//	@file Author: Centrifugal

#define MISSION_PROC_TYPE_NAME "Bounty"
#define MISSION_PROC_TIMEOUT (["A3W_bountyMissionTimeout", 30*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE bountyMissionColor

#include "bountyMissions\bountyMissionDefines.sqf"
#include "missionProcessor.sqf";
