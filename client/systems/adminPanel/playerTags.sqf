// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: playerTags.sqf
//	@file Author: Battleguns, AgentRev
//	@file Created: 20/11/2012 05:19
//	@file Args:

_uid = getPlayerUID player;
if (_uid call isAdmin) then
{
	if (isNil "adminPlayerMarkers") then { adminPlayerMarkers = false };

	if (!adminPlayerMarkers) then
	{
		adminPlayerMarkers = true;
		hint "Player Markers ON";
	}
	else
	{
		adminPlayerMarkers = false;
		hint "Player Markers OFF";
	};

	setGroupIconsVisible [true, true];
	while {adminPlayerMarkers} do
	{
		{
			_pid = getPlayerUID _x;
			if (isPlayer _x) then
			{
				private ["_groupIcon", "_iconColor"];

				switch (side _x) do
				{
					case BLUFOR:      { _groupIcon = "b_inf"; _iconColor = [0, 0, 1, 1] };
					case OPFOR:       { _groupIcon = "o_inf"; _iconColor = [1, 0, 0, 1] };
					case INDEPENDENT: { _groupIcon = "n_inf"; _iconColor = [1, 1, 0, 1] };
					default           { _groupIcon = "c_unknown"; _iconColor = [1, 1, 1, 1] };
				};
				_color_orange = [1,0.35,0.15,1];
				//clearGroupIcons group _x;
				//group _x addGroupIcon [_groupIcon];
				//group _x setGroupIconParams [_iconColor, format ["%1 (%2m)", name _x, round (_x distance player)], 1, true];
				
				//////////////////////
				
					_plist = units group _x;
					_unitCount = count _plist;
					if(_unitCount == 1) then {
						_name = name _x;
						_veh = vehicle _x;
						_type = typeOf _veh;
						
						if(_name == "") then {_name = _type;};
						_pos = (positionCameraToWorld [0,0,0]);
						_posU = getPos _veh;
						_dist = round(_pos distance _posU);
						
						if(_x == _veh) then
						{
							_show = format["%1 (%2m)",_name,_dist];
							_clr = _iconColor;
						}
						else
						{
							_crewnames = [];
							{
								_crewnames = _crewnames + [name _x];
							} forEach crew _veh;
							
							_show = format["%1 (%2m) - %3",_crewnames,_dist,_type];
							_clr = _color_orange;
						};
						
						_puid = getPlayerUID player;
						if(_uid call isAdmin) then {_clr = _color_list};
						if(!(_uid call isAdmin) || ((_uid call isAdmin) && (_uid call isAdmin)) || (_pid == _uid)) then
						{
							_grp = group _x;
							clearGroupIcons _grp;
							_grp addGroupIcon ["x_art"];
							_grp setGroupIconParams [_clr, _show, 1, true];
						};
					} else {
						_grp = group _x;
						_leader = leader _grp;
						_name = name _leader;
						_veh = vehicle _leader;
						_type = typeOf _veh;
						
						if(_name == "") then {_name = _type;};
						_pos = (positionCameraToWorld [0,0,0]);
						_posU = getPos _veh;
						_dist = round(_pos distance _posU);
						
						_memberNames = [];
						{_memberNames set [count _memberNames,(name _x)];} count _plist;
						_memberNames = _memberNames - [_name];
						
						if(_leader == _veh) then
						{
							_show = format ["%1 (%2m) Leader of group: %3",_name,_dist,_memberNames];
							_clr = _iconColor;
						}
						else
						{							
							_show = format ["%1 (%2m) Leader of group: %3 - %4",_name,_dist,_memberNames,_type];
							_clr = _color_orange;
						};			
									   
						clearGroupIcons _grp;
						_grp addGroupIcon ["x_art"];
						_grp setGroupIconParams [_clr, _show, 1, true];
					};
				};
			};
		} forEach playableUnits;

		sleep 0.5;
	};

	{ clearGroupIcons group _x } forEach playableUnits;
};
