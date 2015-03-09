private ["_player","_killer"];
_player = (_this select 0) select 0;
_killer = (_this select 0) select 1;

if(_killer isKindOf "AllVehicles") then
{
	if(count (units _killer) > 0) then { _killer = (units _killer) select 0;};
};


if(isnil "_killer") then { _killer = _player;};

pvar_BountySystemTargetDeaths = pvar_BountySystemTargetDeaths + [[_player,_killer]];

