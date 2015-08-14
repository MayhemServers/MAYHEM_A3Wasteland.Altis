//	@file Name: init.sqf
//	@file Author: [s3k] Centrifugal
// Bounty system for player use.

if (!isServer) exitWith {};

pvar_BountySystemReconnects = [];
publicVariable "pvar_BountySystemReconnects";

pvar_BountySystemFriendlies = [];
publicVariable "pvar_BountySystemFriendlies";

pvar_BountySystemActiveTargets = [];
publicVariable "pvar_BountySystemActiveTargets";

pvar_BountySystemTargetDeaths = [];
publicVariable "pvar_BountySystemTargetDeaths";

[] execVM format ["server\systems\bounties\mainLoop.sqf"];