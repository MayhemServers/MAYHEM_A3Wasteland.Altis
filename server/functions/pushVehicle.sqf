//	@file Name: pushVehicle.sqf
//	@file Author: AgentRev

private ["_veh", "_caller", "_actionID", "_params", "_vel", "_fwdVel", "_vectorDir", "_vectorVel", "_finalVel", "_finalMag"];

_veh = _this select 0;
_caller = _this select 1;
_actionID = _this select 2;
_params = [_this, 3, [], [[]]] call BIS_fnc_param;

_vel = [_params, 0, 0, [0]] call BIS_fnc_param;
_onFoot = [_params, 1, false, [false]] call BIS_fnc_param;

if (_vel != 0) then
{
	if (typeName _veh == "STRING") then
	{
		_veh = objectFromNetId _veh;
	};

	if (_veh == _caller) then
	{
		if (_onFoot) then
		{
			_veh = cursorTarget;
		}
		else
		{
			_veh = vehicle _caller;
		};
	};

	if (!isNull _veh && !(_veh isKindOf "Man")) then
	{
		if (local _veh) then
		{
			if (!_onFoot || count crew _veh == 0) then
			{
				_fwdVel = _veh call getFwdVelocity;

				if ((_onFoot && {(velocity _veh) distance [0,0,0] < abs _vel}) ||
				   (!_onFoot && {(_vel < 0 && _fwdVel > _vel) || (_vel > 0 && _fwdVel < _vel)})) then
				{
					_vectorDir = if (_onFoot) then { [getPosASL _caller, getPosASL _veh] call BIS_fnc_vectorFromXToY } else { vectorDir _veh };
					_vectorVel = [_vectorDir, _vel / 2] call BIS_fnc_vectorMultiply;
					_finalVel = [velocity _veh, _vectorVel] call BIS_fnc_vectorAdd;
					_finalMag = _finalVel distance [0,0,0];

					if (_finalMag > abs _vel) then
					{
						_finalVel = [_finalVel, abs _vel / _finalMag] call BIS_fnc_vectorMultiply;
					};

					_veh setVelocity _finalVel;
				};
			};
		}
		else
		{
			[[netId _veh, _caller, _actionID, _params], "pushVehicle", _veh, false] call TPG_fnc_MP;
		};
	};
};