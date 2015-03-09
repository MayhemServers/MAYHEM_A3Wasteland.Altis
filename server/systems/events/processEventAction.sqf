
//	@file Name: processEventAction.sqf
//	@file Author: [s3k] Centrifugal

private ["_type","_uid"];

_type = [_this, 0, "", [""]] call BIS_fnc_param;


switch (_type) do
{
	case "start":
	{
		//Safety checks to make sure create/delete are not clicked multiple times.
		if(pvar_EventArenaCreating == 0) then
		{
			if(pvar_EventArenaCreated == 0) then
			{
				pvar_EventArenaCreating = 1;
				call CreateEventArena;
				
				pvar_EventArenaCreated = 1;
				pvar_EventArenaCreating = 0;
				
				
			};
		};
	
		
	};
	case "end":
	{
		//Safety checks to make sure create/delete are not clicked multiple times.
		if(pvar_EventArenaDeleting == 0) then
		{
			if(pvar_EventArenaCreating == 0) then
			{
				if(pvar_EventArenaCreated == 1) then
				{
					pvar_EventArenaDeleting = 1;
					{
						deleteVehicle _x;
					} forEach pvar_EventArenaBaseParts;
					
					pvar_EventArenaCreated = 0;
					pvar_EventArenaDeleting = 0;
					
				};
			};
		};
		
	};
	case "teleport":
	{
		_uid = [_this, 1, "", [""]] call BIS_fnc_param;
		{    
			if(_uid == getPlayerUID _x) then
			{
				_x setPosATL [3764,7940,1];
				
				sleep 1;
				
				_x setPosASL [7203 - 70,919 + 100,1];      
			};
		}foreach playableUnits;  
	};
	case "joingroup":
	{

	};
};
