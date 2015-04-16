//Server Function for Airdrop Assistance 
//Vehicle Spawn
//Author: Apoc
//

private ["_player", "_playerPos", "_vehicleChoice", "_choiceCost"];

_player = _this select 0;
//_vehicleChoice = _this select 1;

_playerPos = getPos _player;
_spawnPos = [_playerPos select 0, _playerPos select 1 + 5, _playerPos select 2 + 10];
_veh = "Quadbike_01_base_F" createVehicle _spawnPos;