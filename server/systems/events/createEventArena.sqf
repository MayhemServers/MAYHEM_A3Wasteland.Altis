private ["_EastStep","_NorthStep","_XStart","_YStart","_MaxY","_MaxX","_ZStart","_MaxZ"];

_EastStep = 14.5;
_NorthStep = 41.2;

_XStart = 7203;
_YStart = 919;
_ZStart = -1;

_MaxY = 10;
_MaxX = 20;
_MaxZ = 50;



for "_CurrentX" from 1 to _MaxX step 1 do 
{
	for "_CurrentY" from 1 to _MaxY step 1 do 
	{
		private ["_XAdjustment","_NewX","_YAdjustment","_NewY","_basePart1","_basePart2","_basePart3"];

        _XAdjustment = _CurrentX * _EastStep;
        _NewX = _XStart - _XAdjustment;

        _YAdjustment = _CurrentY * _NorthStep;
        _NewY = _YStart + _YAdjustment;

		_basePart1 = "Land_Pier_F" createVehicle [_NewX,_NewY,_ZStart];
		_basePart1 setPosASL [_NewX,_NewY,_ZStart];
		_basePart1 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
	
		pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_basePart1];
	
	
	    _basePart2 = "Land_Pier_F" createVehicle [_NewX,_NewY,_MaxZ];
		_basePart2 setPosASL [_NewX,_NewY,_MaxZ];
		_basePart2 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,-1]];
		
		pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_basePart2];
		
		_basePart3 = "Land_Pier_F" createVehicle [_NewX,_NewY,_MaxZ + 2];
		_basePart3 setPosASL [_NewX,_NewY,_MaxZ + 2];
		_basePart3 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
		
		pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_basePart3];
	
	}; 
 
}; 

private ["_ZWallBase","_ZWallTop"];
_ZWallBase = 5;
_ZWallTop = 50;

for "_CurrentZ" from _ZWallBase to _ZWallTop step 10 do 
{
	for "_CurrentX" from 1 to _MaxX step 1 do 
	{
		private ["_XAdjustment","_NewX","_YAdjustment","_NewY","_basePart1","_basePart2"];
	
		_XAdjustment = _CurrentX * _EastStep;
        _NewX = _XStart - _XAdjustment;

		_YAdjustment = _MaxY * _NorthStep;
        _NewY = _YStart + _YAdjustment;
	
		_basePart1 = "Land_Pier_F" createVehicle [_NewX,_YStart + _NorthStep,_CurrentZ];
		_basePart1 setPosASL [_NewX,_YStart + _NorthStep,_CurrentZ];
		_basePart1 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
	
		pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_basePart1];
	
	    _basePart2 = "Land_Pier_F" createVehicle [_NewX,_NewY,_CurrentZ];
		_basePart2 setPosASL [_NewX,_NewY,_CurrentZ];
		_basePart2 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
		
		pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_basePart2];
		
	};
	
	for "_CurrentY" from 1 to _MaxY step 1 do 
	{
		private ["_XAdjustment","_NewX","_YAdjustment","_NewY","_basePart1","_basePart2"];
	
		_XAdjustment = _MaxX * _EastStep;
        _NewX = _XStart - _XAdjustment;
	
		_YAdjustment = _CurrentY * _NorthStep;
        _NewY = _YStart + _YAdjustment;
		
		_basePart1 = "Land_Pier_F" createVehicle [_XStart  - _EastStep,_NewY,_CurrentZ];
		_basePart1 setPosASL [_XStart  - _EastStep ,_NewY,_CurrentZ];
		_basePart1 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
		
		pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_basePart1];
	
	    _basePart2 = "Land_Pier_F" createVehicle [_NewX,_NewY,_CurrentZ];
		_basePart2 setPosASL [_NewX,_NewY,_CurrentZ];
		_basePart2 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
		
		pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_basePart2];
	};

};


private ["_flag1","_flag2","_flag3","_flag4","_flag5","_flag6"];
_flag1 = "Flag_UK_F" createVehicle [7115,984,1];
_flag1 setPosASL [7115,984,1];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_flag1];

_flag2 = "Flag_UK_F" createVehicle [6959,984,1];
_flag2 setPosASL [6959,984,1];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_flag2];

_flag3 = "Flag_UK_F" createVehicle [6925,1152,1];
_flag3 setPosASL [6925,1152,1];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_flag3];

_flag4 = "Flag_UK_F" createVehicle [7178,1149,1];
_flag4 setPosASL [7178,1149,1];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_flag4];

_flag5 = "Flag_UK_F" createVehicle [7110,1304,1];
_flag5 setPosASL [7110,1304,1];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_flag5];

_flag6 = "Flag_UK_F" createVehicle [6976,1304,1];
_flag6 setPosASL [6976,1304,1];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_flag6];


private ["_Dome","_Hospital1","_Hospital2","_Hospital3","_cargoTower1","_cargoTower2","_cargoTower3","_AirportTower","_Hangar1","_Hangar2"];
_Hospital1 = "Land_Hospital_main_F" createVehicle [7028,1146,1.3];
_Hospital1 setPosASL [7028,1146,1.3];
_Hospital1 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_Hospital1];


_Hospital2 = "Land_Hospital_side2_F" createVehicle [7038.25,1118.2,1.27];
_Hospital2 setPosASL [7038.25,1118.2,1.27];
_Hospital2 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_Hospital2];

_Hospital3 = "Land_Hospital_side1_F" createVehicle [6995.2,1150.86,1.33];
_Hospital3 setPosASL [6995.2,1150.86,1.33];
_Hospital3 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_Hospital3];

_AirportTower = "Land_Airport_Tower_F" createVehicle [7015,1199,1];
_AirportTower setPosASL [7015,1199,1];
_AirportTower setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_AirportTower];

_cargoTower1 = "Land_Cargo_Tower_V1_No7_F" createVehicle [7037,1063,1.3];
_cargoTower1 setPosASL [7037,1063,1.3];
_cargoTower1 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_cargoTower1];

_cargoTower2 = "Land_Cargo_Tower_V1_No7_F" createVehicle [7099,1220,1.3];
_cargoTower2 setPosASL [7099,1220,1.3];
_cargoTower2 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_cargoTower2];

_cargoTower3 = "Land_Cargo_Tower_V1_No7_F" createVehicle [6964,1210,1.3];
_cargoTower3 setPosASL [6964,1210,1.3];
_cargoTower3 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_cargoTower3];

_Hangar1 = "Land_Hangar_F" createVehicle [7056,1014,1];
_Hangar1 setPosASL [7056,1014,1];
_Hangar1 setDir 180;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_Hangar1];

private ["_HBarrier1","_HBarrier2","_HBarrier3","_HBarrier4","_HBarrier5"];

_HBarrier1 = "Land_HBarrier_5_F" createVehicle [7004,1134,1.3];
_HBarrier1 setPosASL [7004,1134,1.3];
_HBarrier1 setVectorDirAndUp  [[-1,0.000295654,-1.36551e-005],[-1.36551e-005,1.29641e-008,1]];
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_HBarrier1];

private ["_Lamp1","_Lamp2","_Lamp3","_Lamp4"];
_Lamp1 = "Land_LampStadium_F" createVehicle [7181,985,1];
_Lamp1 setPosASL [7181,985,1];
_Lamp1 setDir 45;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_Lamp1];

_Lamp2 = "Land_LampStadium_F" createVehicle [7180,1305,1];
_Lamp2 setPosASL [7180,1305,1];
_Lamp2 setDir -45;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_Lamp2];

private ["_vehicle1","_vehicle2","_vehicle3","_vehicle4","_vehicle5","_vehicle6"];
_vehicle1 = "I_G_Offroad_01_armed_F" createVehicle [7056,1014,1];
_vehicle1 setPosASL [7059,1018,1];
_vehicle1 setDir 180;

_vehicle2 = "I_MRAP_03_F" createVehicle [7203-70,919+70,1];
_vehicle2 setPosASL [7203-70,919+70,1];
_vehicle2 setDir 180;

private ["_BaseCastle1","_BaseCastle2","_BaseCastle3","_BaseCastle4","_BaseCastle5","_BaseCastle6"];
_BaseCastle1 = "Land_Castle_01_wall_01_F" createVehicle [6967,1290,12];
_BaseCastle1 setPosASL [6967,1290,12];
_BaseCastle1 setDir 270;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_BaseCastle1];

_BaseCastle2 = "Land_Castle_01_wall_01_F" createVehicle [7100,1290,12];
_BaseCastle2 setPosASL [7100,1290,12];
_BaseCastle2 setDir 270;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_BaseCastle2];

_BaseCastle3 = "Land_Castle_01_wall_01_F" createVehicle [7163,1160,12];  
_BaseCastle3 setPosASL [7163,1160,12];  
_BaseCastle3 setDir 0;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_BaseCastle3];

_BaseCastle4 = "Land_Castle_01_wall_01_F" createVehicle [7126,999,12];  
_BaseCastle4 setPosASL [7126,999,12];  
_BaseCastle4 setDir 90;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_BaseCastle4];

_BaseCastle5 = "Land_Castle_01_wall_01_F" createVehicle [6970,999,12];  
_BaseCastle5 setPosASL [6970,999,12];  
_BaseCastle5 setDir 90;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_BaseCastle5];

_BaseCastle6 = "Land_Castle_01_wall_01_F" createVehicle [6940,1142,12];  
_BaseCastle6 setPosASL [6940,1142,12];  
_BaseCastle6 setDir 180;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_BaseCastle6];

private ["_CastleWall1"];
_CastleWall1 = "Land_Castle_01_wall_10_F" createVehicle [6954,1029,3];  
_CastleWall1 setPosASL [6954,1029,3];  
_CastleWall1 setDir 0;
pvar_EventArenaBaseParts = pvar_EventArenaBaseParts + [_CastleWall1];




			      