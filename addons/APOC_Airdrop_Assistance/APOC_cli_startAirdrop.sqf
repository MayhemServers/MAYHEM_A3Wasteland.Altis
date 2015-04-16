//Client Function for Airdrop Assistance (not really a function, as it is called via ExecVM from command menu)
//This takes values from command menu, and some passed variables, and interacts with client and sends commands to server
//Author: Apoc
//Credits: Some methods taken from Cre4mpie's airdrop scripts, props for the idea!

private ["_type","_selection","_player"]; //Variables coming from command menu
_type 		= _this select 0;
_selection 	= _this select 1;
_player 	= _this select 2;

diag_log format ["Player %1, Drop Type %2, Selection # %3",_player,_type,_selection];
hint format ["Well we've made it this far! %1, %2, %3,",_player,_type,_selection];