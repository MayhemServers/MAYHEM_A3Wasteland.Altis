waitUntil {!(isNull (findDisplay 46))};
disableSerialization;
/*
	File: fn_statusBar.sqf
	Author: Some French Guy named Osef I presume, given the variable on the status bar
	Edited by: [midgetgrimm]
	Description: Puts a small bar in the bottom right of screen to display in-game information

*/
_rscLayer = "osefStatusBar" call BIS_fnc_rscLayer;
_rscLayer cutRsc["osefStatusBar","PLAIN"];
// systemChat format["IMPORTANT: Check the changelog on the map for changes", _rscLayer];


[] spawn {
	sleep 5;
	_counter = 180;
	_timeSinceLastUpdate = 0;
	while {true} do
	{
		sleep 1;
		_counter = _counter - 1;
		//((uiNamespace getVariable "osefStatusBar")displayCtrl 1000)ctrlSetText format["  Mayhem | 66.150.214.11:2702 | TS3: mayhem.tserverhq.com | FPS: %1  ", round diag_fps, _counter];
		((uiNamespace getVariable "osefStatusBar")displayCtrl 1000)ctrlSetText format["  Mayhem - TS3: mayhem.tserverhq.com | Players: %1 | FPS: %2  ", count playableUnits, round diag_fps];
	}; 
};
