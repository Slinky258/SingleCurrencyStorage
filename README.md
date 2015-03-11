SingleCurrencyStorage
=====================

Single currency storage is a mod that changes the currency for dayz epoch or overpoch from metals to coins. This mod also allows for these coins to be stored in objects like cars, and storage buildings as an alternative to global banking.

![SC Storage](https://i.imgur.com/rBVpE6C.jpg)

#Features:

* Store Money in storage objects and vehicles ( max money in 1 storage depends on the size).
* No global access to your money.
* Anyone can take the money out ( for vault/lockbox it must be open of course).
* Trade with this currency for cars/items.
* Give money to other players.
* NO inventory issues with gold!


#Whats the difference with your other single currency scripts?

* You can use the default hive!
* No global bank! Back to normal epoch danger to lose cash!
* Cleaned up code
* Very low changes to default saving system. (DB friendly)
* NO database changes needed.
* NO ATMs, Safezones, atms in trader whatsoever...
* Store money in vehicles.


#Technical data:

* Storage money is saved in the gear section of the object in the Database
* Player Money is added to gear section of the player in the Database ( Again thanks to maca for pointing this out for me).


#Extra:

* This build will have all of the fixes on errors out there ( Build on peterbeers all in on packages with the bugfixes).
* Reworked the  transfering money between players to be sure trade goes to the right object/player.
* Store money in vehicles


#Credits:

* Zupa - Creator of SC Storage
* Maca - Original private single currency.
* Peterbeer -  for putting all fixes together in 1 pack.
* Soul - Hives modifications and code changes for it. ( not applied on this script, jsut credited for hard work).
* Rocu - Great help on forums and fixes.
* DraftKid - Testing and screenshots
* bbatton - Mod Documentation


#Configuring SC+Storage

1. All the configurations can be found in file listed below which is downloaded in this mod.
```
	ZSC/gold/ZSCconfig.sqf
```


#Installation Instructions

1. If you are installing this into a non-customized server you only need to copy the downloaded files into their proper directories.

1. If you are installing this into a custom server you should follow each step listed below or you will have problems

#Mission PBO

##In your init.sqf:
	
1. You must have the line below in the top section ( for example right above "EpochEvents"); Place if you do not have it yet. ZSC requires Config traders, It will also help your server reduce lag!
	```
	DZE_ConfigTrader = true;
	```


1. Place the following
	```
	call compile preprocessFileLineNumbers "ZSC\gold\ZSCinit.sqf";
	```
	*Above
	```	
	progressLoadingScreen 0.5;
	```


1. Place the following
	```
	execVM "ZSC\compiles\playerHud.sqf";
	```
	* Right under player monitor
	```	
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	```


1. Change 
	```
	call compile preprocessFileLineNumbers "server_traders.sqf";
	```
	* To this
	```	
	call compile preprocessFileLineNumbers "server_traders_cherno_11.sqf";
	```


1. Make sure the following line is custom and doesnt have dayz_code in it. It should point at dayz_server or if u use another script to where ever that places it.
	```
	_serverMonitor = 	[] execVM "\z\addons\dayz_server\system\server_monitor.sqf";
	```

	
##In your description.ext
	
1. Place the following code at the top
```
#include "ZSC\config\cfgServerTrader.hpp"
```


2. Add the following if you do not have a RSCTitles yet at the bottom
```
class RscTitles
{
	#include "ZSC\config\ZSChud.hpp"
};
```


*If you already have a RSCTitles just add the following behind whatever is in there
```	
#include "ZSC\config\ZSChud.hpp"
```


3. Add the following at very bottom.  If you come from another currency, u can remove the shit that was extra added in that one.
```
#include "ZSC\config\ZSCdefines.hpp"
#include "ZSC\config\ZSCdialogs.hpp"
```


##Copy Files
	
1. Place the ZSC folder in your mission pbo ( take it out of the github's missions pbo).

1. Place server_traders_cherno_11.sqf in your missions pbo. ( If other map/instance check bottom of the topic.).


##fn_selfactions

1. If you don't have a custom fn_selfactions use the one downloaded with this mod and skip this section otherwise continue through this section

1. Place the following in your fn_selfactions file
```
if(_typeOfCursorTarget in ZSC_MoneyStorage && (player distance _cursorTarget < 5)) then {
	if (s_bank_dialog < 0) then {
		s_bank_dialog = player addAction ["Money Storage", "ZSC\actions\bank_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
	};
} else {
	player removeAction s_bank_dialog;
	s_bank_dialog = -1;
};

// cars 
if( _isVehicle && !_isMan &&_isAlive && !_isMan && !locked _cursorTarget && !(_cursorTarget isKindOf "Bicycle") && (player distance _cursorTarget < 5)) then {	
	if (s_bank_dialog2 < 0) then {
		s_bank_dialog2 = player addAction ["Money Storage", "ZSC\actions\bank_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
	};
} else {
	player removeAction s_bank_dialog2;
	s_bank_dialog2 = -1;
 };
```
* After
```
 } else {
	{player removeAction _x} count s_player_combi;s_player_combi = [];
	s_player_unlockvault = -1;
 };
```


3. Place the following
```
if (_isMan and _isAlive and !_isZombie and !_isAnimal and !(_traderType in serverTraders)) then {
	if (s_givemoney_dialog < 0) then {
		s_givemoney_dialog = player addAction [format["Give Money to %1", (name _cursorTarget)], "ZSC\actions\give_player_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
	};
 } else {
	player removeAction s_givemoney_dialog;
	s_givemoney_dialog = -1;
};
```
* Above this
```
if(_typeOfCursorTarget in dayz_fuelpumparray) then {
```


4. Change the following
```
if (_player_studybody) then {
	if (s_player_studybody < 0) then {
		s_player_studybody = player addAction [localize "str_action_studybody", "\z\addons\dayz_code\actions\study_body.sqf",_cursorTarget, 0, false, true, "",""];
	};
} else {
	player removeAction s_player_studybody;
	s_player_studybody = -1;
};
```
* Into the following
```
if (_player_studybody) then {
	if (s_player_studybody < 0) then {
		s_player_studybody = player addAction [("<t color=""#FF0000"">"+("Check Wallet") + "</t>"), "ZSC\actions\check_wallet.sqf",_cursorTarget, 0, false, true, "",""];
};
} else {
	player removeAction s_player_studybody;
	s_player_studybody = -1;
};
```


5. Add the following
```
player removeAction s_givemoney_dialog;
s_givemoney_dialog = -1;
player removeAction s_bank_dialog;
s_bank_dialog = -1;
player removeAction s_bank_dialog2;
s_bank_dialog2 = -1;
```
* Behind the following
```
player removeAction s_player_towing;
s_player_towing = -1;
player removeAction s_player_fuelauto;
s_player_fuelauto = -1;
player removeAction s_player_fuelauto2;
s_player_fuelauto2 = -1;
```


6. To remove the client side errors you get add the following in your Variables.sqf
```
s_givemoney_dialog = -1;
s_bank_dialog = -1;
s_bank_dialog2 = -1;
```
* To this
```
dayz_resetSelfActions = {
```
	
##player_switchModel.sqf
	
1. If you don't have a custom player_switchModel then use the one provide in this mod then you can skip this step. Otherwise continue

1. Add the following
```
_cashMoney = player getVariable["cashMoney",0];
```
* Behind
```	
_weapons = weapons player;
_countMags = call player_countMagazines; 
_magazines = _countMags select 0;
```


3. Add the following at the bottom
```
player setVariable ["cashMoney",_cashMoney,true];
```


4. Change the following
```
//Create New Character
_group = createGroup west;
_newUnit = _group createUnit [_class,dayz_spawnPos,[],0,"NONE"];
	
_newUnit 	setPosATL _position;
_newUnit 	setDir _dir;
```
* Into the following
```
_newUnit 	setDir _dir;
_newUnit = _group createUnit [_class,dayz_spawnPos,[],0,"NONE"];
[_newUnit] joinSilent createGroup WEST;
_newUnit setPosATL _position;
_newUnit setDir _dir;
_newUnit setVariable ["cashMoney",_cashMoney,true];
```

	
##UnlockVault
	
1. If you don't have a custom unlockVault use the one provided in this mod and skip this step. Otherwise continue through this section

1. Place the following
```
_objMoney	= _obj getVariable["bankMoney",0];
```
* Behind the following
```
_dir = direction _obj;
_pos	= _obj getVariable["OEMPos",(getposATL _obj)];
_objectID 	= _obj getVariable["ObjectID","0"];
_objectUID	= _obj getVariable["ObjectUID","0"];
```


3. Place the following
```
_holder setVariable ["bankMoney", _objMoney, true];
```
* Behind the following
```
_holder setVariable["CharacterID",_ownerID,true];
_holder setVariable["ObjectID",_objectID,true];
_holder setVariable["ObjectUID",_objectUID,true];
_holder setVariable ["OEMPos", _pos, true];
```

	
##LockVault
	
1. If you don't have a custom lockVault then use the one included in the mod and skip this step. Otherwise continue these steps

1. Place the following
```
_objMoney	= _obj getVariable["bankMoney",0];
```
* Behind the following
```
_ownerID = _obj getVariable["CharacterID","0"];
_objectID 	= _obj getVariable["ObjectID","0"];
_objectUID	= _obj getVariable["ObjectUID","0"];
```


3. Place the following
```
_holder setVariable ["bankMoney", _objMoney, true];
```
* Behind the following
```
_holder setVariable["CharacterID",_ownerID,true];
_holder setVariable["ObjectID",_objectID,true];
_holder setVariable["ObjectUID",_objectUID,true];
_holder setVariable ["OEMPos", _pos, true];
```

	
##Server PBO

1. REPLACE your "compiles/server_tradeObject.sqf"  With my one ( not other script uses that anyways).

1.  IN compiles/server_updateObject.sqf

1. Change the following
```
_inventory = [
	getWeaponCargo _object,
	getMagazineCargo _object,
	getBackpackCargo _object
];
```	
* Into the following
```
_inventory = [
	getWeaponCargo _object,
	getMagazineCargo _object,
	getBackpackCargo _object,
	/*ZSC*/
	_object getVariable["bankMoney",0]
	/*ZSC*/
];
```

	
##Server_Monitor.sqf
	
1. In your server_monitor.sqf ( NOTE: the " _intentory' variable can be called "_inventory" at your files, so change my code to that, if it's the case).
	
1. Add the following
```
/*ZSC*/
if( count (_intentory) > 3)then{
	_object setVariable ["bankMoney", _intentory select 3, true];
}else{
	_object setVariable ["bankMoney", 0, true];
};
/*ZSC*/
```	
* Above the following
```
if (_type in DZE_LockedStorage) then {
	// Fill variables with loot
	_object setVariable ["WeaponCargo", (_intentory select 0),true];
	_object setVariable ["MagazineCargo", (_intentory select 1),true];
	_object setVariable ["BackpackCargo", (_intentory select 2),true];
} else {
```

	
##Server_playerSync.sqf
	
1.  In compiles/server_playerSync.sqf change the following
```
_playerGear = [weapons _character,_magazines];
```
* Into the following
```
_playerGear = [weapons _character,_magazines, _character getVariable["cashMoney",0]];
```

	
##Note:

in the gold init i use a custom gearSet.sqf
If u would have a custom one, it's defined in the ZSCinit.sqf. Only differnecy will be the top where it checks for the money in your gear sections.

##FAQ

* I use a different instance/map to play one! What do i do?
	* The only things that difference between maps where u need to worrie about is the server_traders.sqf. I included them for 4 maps, if your map is NOT in there u will have to change your original one.FAIR SIMPLE:
	
1. Take your original server_traders
	
1. Open one of mine
	
1. Copy my categories with the correct numbes to your traders. You can choose also which traders sells what then ^^.
	
1. Share your file to me so i can put it in the list
	
* Does it work with Overpoch(ins).

	* Simple: Yes, Everything with epoch as base.
	
	* Overwatch items or included in traders, remove the categories if you do not use them.
	
* Can I convert from the older system?
	* You will have to revert your database to the default structure and maybe transfer money. Banks added to the players 	cash is the best solution.

* How do i see my money and bank?

1. Bank will not be visible cus their is none. You store money in storages like other items ( but in a different dialog). So the money can be accessed by anyone that has access to that storage.

1. Money is visisble with a money icon on the right side of the screen. Feel free to add it to other places aswell.
	
	* This will return your money:
	```
	 player getVariable["cashMoney",0];
	```
	
* Can I use it with database traders?
	* No, this build is made for config traders. No support (Yet).
	
##Images

![SC Trader](https://i.imgur.com/yPqjeR5.jpg)

![SC CarStorage](https://i.imgur.com/zdSqCOq.jpg)
