private ["_player","_killer"];
_player = (_this select 0) select 0;
_killer = (_this select 0) select 1;

if(_killer isKindOf "AllVehicles") then
{
	if(count (units _killer) > 0) then { _killer = (units _killer) select 0;};
};

_killer = _player getVariable "FAR_killerPrimeSuspect"; //Use revive system's killer detection to determine who killed player, same one as used for scoring //Apoc

bKiller = _killer;
publicVariable "bKiller";
bKillerName = name bKiller;
publicVariable "bKillerName";
bKillerSide = side bKiller;
publicVariable "bKillerSide";
diag_log format["Killer: %1", bKiller];
if(isnil "bKiller") then { bKiller = _player;};