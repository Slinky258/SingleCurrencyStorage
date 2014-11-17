/* Single Currency 3.0 uses storages to store money which can be accessed by anyone if open of course (safe,lockbox). Each storage has his own money, so no global access. */

// Name of your currency
CurrencyName = "Coins"; 

// Objects that can hold money.
ZSC_MoneyStorage = ["VaultStorage","LockboxStorage","StorageShed_DZ","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","GunRack_DZ","WoodCrate_DZ","TentStorage","TentStorageDomed","TentStorageDomed2"];

// Objects capacity. It must be in sync with ZSC_MoneyStorage !
ZSC_MoneyCapacity = [10000000,5000000,10000000,50000,500000,250000,10000,25000,25000,25000,25000];

// Multiplier how much money can hold. This number X ammount of magazines it can hold. ( so URAL -> 500 items * 1000 = 5 MIL cash).
ZSC_MaxMoneyInVechileMultiplier = 1000;

// (True = No Animation / False = Animation)
InstantTrading = false; 

// If TRUE: overwrite yours player_switchmodel with mine. | IF False: Change content yourself @ step D
ZSC_Overwrite_SwitchModel = false; 

 // if TRUE: Overwrites yours fn_selfactions with default 1 + edits. | IF False: Change content yourself @ step D
ZSC_Overwrite_SelfActions = false;



