//Client Function for Airdrop Assistance (not really a function, as it is called via ExecVM from command menu)
//This takes values from command menu, and some passed variables, and interacts with client and sends commands to server
//Author: Apoc
//Credits: Some methods taken from Cre4mpie's airdrop scripts, props for the idea!

private ["_type","_selection","_player"]; //Variables coming from command menu
_type 				= _this select 0;
_selectionNumber 	= _this select 1;
_player 			= _this select 2;

diag_log format ["Player %1, Drop Type %2, Selection # %3",_player,_type,_selectionNumber];
hint format ["Well we've made it this far! %1, %2, %3,",_player,_type,_selectionNumber];
_selectionArray = [];
switch (_type) do {
	case "vehicle": {_selectionArray = APOC_AA_VehOptions};
	case "supply": 	{_selectionArray = APOC_AA_SupOptions};
	default 		{_selectionArray = APOC_AA_VehOptions; diag_log "AAA - Default Array Selected - Something broke";};
};
_selectionName 	= (_selectionArray select _selectionNumber) select 0;
_price 			= (_selectionArray select _selectionNumber) select 2;

_playerMoney = player getVariable ["bmoney", 0];
if (_price > _playerMoney) exitWith
			{
				hint format["You don't have enough money in the bank to request this airdrop!"];
				playSound "FD_CP_Not_Clear_F";
			};
			
_confirmMsg = format ["This airdrop will deduct $%1 from your bank account<br/>",_price];
_confirmMsg = _confirmMsg + format ["<br/><t font='EtelkaMonospaceProBold'>1</t> x %1",_selectionName];
		
	// Display confirm message
	if ([parseText _confirmMsg, "Confirm", "DROP!", true] call BIS_fnc_guiMessage) then
	{
	[[_type,_selectionNumber,_player],"APOC_srv_startAirdrop",false,false,false] call BIS_fnc_MP;
	};
	
