
//	@file Name: bountyMissionController.sqf
//	@file Author: Centrifugal

#define MISSION_CTRL_PVAR_LIST BountyMissions
#define MISSION_CTRL_TYPE_NAME "Bounty"
#define MISSION_CTRL_FOLDER "bountyMissions"
#define MISSION_CTRL_DELAY (["A3W_bountyMissionDelay", 1*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE bountyMissionColor

#include "bountyMissions\bountyMissionDefines.sqf"
#include "missionController.sqf";
