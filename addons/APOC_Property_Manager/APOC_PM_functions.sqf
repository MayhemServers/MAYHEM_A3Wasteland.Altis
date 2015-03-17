//Function Defines for APOC's Property Manager (APOC_PM_) 
//Creator: Apoc
//bits and pieces borrowed from Cael87's BoS system.
#define PropertyManagerRadius 30

APOC_PM_Lock = {
	private["_player","_objects"];
	_player = _this select 0;
	_objects = [];
	_objects = nearestObjects [position player, ["thingX", "Building", "ReammoBox_F"], 30];
	{if (((typeof _x) in R3F_LOG_CFG_objets_deplacables) || (_x isKindOf "ReammoBox_F")) then
		{
			if !(_x getVariable ["objectLocked",false]) then 
				{
				_x setVariable ["objectLocked",true,true];
				_x setVariable ["ownerUID", getPlayerUID _player, true];
				};
		};
		sleep .1;
	} forEach _objects;
	//diag_log "PM_Lock function called";
	hint "Nearby objects locked";
};

APOC_PM_Unlock = {
	private["_player","_objects"];
	_player = _this select 0;	
	_objects = [];
	_objects = nearestObjects [position player, ["thingX", "Building", "ReammoBox_F"], 30];
	{if (((typeof _x) in R3F_LOG_CFG_objets_deplacables) || (_x isKindOf "ReammoBox_F")) then
		{
			if !((typeof _x) == "Land_Laptop_unfolded_F") then 
			{
				if (_x getVariable ["ownerUID",""]==(getPlayerUID _player)) then 
				{
					_x setVariable ["objectLocked", false, true];
					_x setVariable ["ownerUID", nil, true];
					_x setVariable ["baseSaving_hoursAlive", nil, true];
					_x setVariable ["baseSaving_spawningTime", nil, true];
				};
			};
		};
		sleep .1;
	} forEach _objects;
	//diag_log "PM_Unlock function called";
	hint "Nearby objects unlocked";
};

APOC_PM_InventoryLock = {
	private["_player","_objects"];
	_player = _this select 0;
	_objects = [];
	_objects = nearestObjects [position player, ["ReammoBox_F"], 30];
	{if ((_x getVariable ["ownerUID",""]==(getPlayerUID _player))&&(_x getVariable ["objectLocked",true])) then
		{
			_x setVariable ["A3W_inventoryLockR3F", true, true]; //Lock access to crate
			_x setVariable ["R3F_LOG_disabled", true, true]; //Remove logistics actions from crates/objects (makes them immobile)
		};
		sleep .1;
	} forEach _objects;
	//diag_log "PM_InventoryLock function called";
	hint "Nearby crates padlocked";	
};

APOC_PM_InventoryUnlock = {
	private["_player","_objects"];
	_player = _this select 0;
	_objects = [];
	_objects = nearestObjects [position player, ["ReammoBox_F"], 30];	
	{if ((_x getVariable ["ownerUID",""]==(getPlayerUID _player))&&(_x getVariable ["objectLocked",true])&&(_x getVariable ["A3W_inventoryLockR3F",true])) then
		{
			_x setVariable ["A3W_inventoryLockR3F", false, true]; //Unlock access to crate
			_x setVariable ["R3F_LOG_disabled", false, true]; //Remove logistics actions from crates/objects (makes them immobile)
		};
		sleep .1;
	} forEach _objects;
	//diag_log "PM_InventoryLock function called";
	hint "Padlocks removed from nearby crates";	
};

APOC_PM_DisableLogistics = {
	//taken from Cael's BoS functions (relock) and converted to removal protection system
	private ["_price", "_playerMoney","_objects","_ownedObjects","_maxLifetime"];
	_maxLifetime = ["A3W_objectLifetime", 0] call getPublicVar;
	_objects = [];
	_objects = nearestObjects [position player, ["thingX", "Building"], 30];
	_ownedObjects = {typeName _x == "OBJECT" && {!(isNil {_x getVariable "ownerUID"})} && !(_x getVariable "R3F_LOG_disabled") && !(_x iskindOf "ReammoBox_F")} count _objects; //Count of objects owned.
	_player = _this select 0;
	_playerMoney = player getVariable "cmoney";
	_price = (_ownedObjects) * 1000;

	if (!isNil "_price") then 
	{
		// Add total sell value to confirm message
		_confirmMsg = format ["Isolating %2 baseparts/objects will cost you $%1<br/>Range is %4 meters<br/>Objects will not load in after next restart if older than %3 hours.", _price, _ownedObjects, _maxLifetime, 30];

		// Display confirm message
		if ([parseText _confirmMsg, "Confirm", "OK", true] call BIS_fnc_guiMessage) then
		{	
			// Ensure the player has enough money

			if (_price > _playerMoney) exitWith
			{
				hint format ["You need $%1 to isolate %2 objects",  _price, _ownedObjects];
				playSound "FD_CP_Not_Clear_F";
			};
			
			player setVariable["cmoney",(player getVariable "cmoney")-_price,true];
			
			{
				if ((_x getVariable "objectLocked") && (_x getVariable ["ownerUID",""]==(getPlayerUID _player)) && !(_x iskindOf "ReammoBox_F")) then
				{
					_x setVariable ["R3F_LOG_disabled",true,true]; //Remove logistics ability for items.
				};
			} forEach _Objects;
		};
	};
};

APOC_PM_EnableLogistics = {
	//taken from Cael's BoS functions (relock) and converted to removal protection system
	private ["_objects","_confirmMsg"];
	_player = _this select 0;
	_objects = [];
	_objects = nearestObjects [position player, ["thingX", "Building"], 30];
	_ownedObjects = {typeName _x == "OBJECT" && {!(isNil {_x getVariable "ownerUID"})} && (_x getVariable "R3F_LOG_disabled") && !(_x iskindOf "ReammoBox_F")} count _objects; //Count of objects owned.
	
	// Add total sell value to confirm message
	_confirmMsg = format ["Enabling logistics on %1 baseparts/objects<br/>Range is 50 meters<br/> Ammo crates will not be affected. Use inventory unlock for those.", _ownedObjects];

	// Display confirm message
	if ([parseText _confirmMsg, "Confirm", "OK", true] call BIS_fnc_guiMessage) then
	{	
		{
			if ((_x getVariable "objectLocked") && !(_x iskindOf "ReammoBox_F") && (_x getVariable ["ownerUID",""]==(getPlayerUID _player))) then
			{
				_x setVariable ["R3F_LOG_disabled",false,true]; //Replace logistics ability for items.
			};
		} forEach _Objects;
	};
};

APOC_PM_CheckNearbyLaptops = {
	//Function taken from Epoch, specifically Plot4Life by Raymix.  Integration by Apoc


};