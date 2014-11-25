DECLARE done INT DEFAULT 0;
DECLARE @player_id VARCHAR DEFAULT "-1";
DECLARE @instance INT DEFAULT 11;
/* Cherno = 11 or 17 , Tavi = 13 and so on. just check your Database to see instance number.  */
DECLARE player_cursor CURSOR FOR SELECT PlayerUID FROM player_data;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN player_cursor;

read_loop: LOOP  
	FETCH player_cursor INTO @player_id;
	IF done <> 0 THEN
      LEAVE read_loop;
    END IF;

	DECLARE @charid INT DEFAULT -1;
	DECLARE @player_money BIGINT DEFAULT 0;
	DECLARE @player_bank BIGINT DEFAULT 0;
	DECLARE @thesum BIGINT DEFAULT 0;
	DECLARE @player_gear LONGTEXT DEFAULT '[]';
	
	select @charid = CharacterID, @player_money = CashMoney, @player_gear = SUBSTRING(Inventory , 1, CHAR_LENGTH(Inventory ) - 1) from character_data where PlayerUID = @player_id and Alive = 1;
	select @player_bank = BankSaldo from banking_data where PlayerUID = @player_id;
	
	/* 999 hive , comment the previous 2 lines out and use the 2 following.
	select @charid = CharacterID, @player_money = HeadshotsZ, @player_gear = SUBSTRING(Inventory , 1, CHAR_LENGTH(Inventory ) - 1) from character_data where PlayerUID = @player_id and Alive = 1;	
	select @player_bank = PlayerMorality from player_data where PlayerUID = @player_id;
	*/
	
	IF @charid <> -1 THEN	
		@thesum = @player_money + @player_bank;
        set @player_gear = CONCAT(@player_gear, @thesum, ']');
		UPDATE character_data SET Inventory = @player_gear WHERE CharacterID = @charid;
	ELSE
		set @player_gear = CONCAT('[["ItemFlashlight","ItemMap","ItemCompass","ItemHatchet","ItemKnife","ItemMatchbox","ItemWatch"],["FoodSteakCooked","ItemSodaCoke","ItemBloodbag","ItemPainkiller","ItemAntibiotic","ItemMorphine","ItemEpinephrine","ItemBandage","ItemBandage","ItemBandage"],', @player_bank, ']');
		INSERT INTO `character_data` (`CharacterID`, `PlayerUID`, `InstanceID`, `Datestamp`, `LastLogin`, `Inventory`, `Backpack`, `Worldspace`, `Medical`, `Alive`, `Generation`, `LastAte`, `LastDrank`, `KillsZ`, `HeadshotsZ`, `DistanceFoot`, `Duration`, `CurrentState`, `KillsH`, `Model`, `KillsB`, `Humanity`, `Infected`) VALUES (NULL, @player_id, @instance, '2014-11-22 15:02:02', '2014-11-24 22:05:43', @player_gear, '["DZ_Backpack_EP1",[[],[]],[[],[]]]', '[158,[6320.97,7795.51,0.278]]', '[false,false,false,false,false,false,false,12000,[],[0,0],0,[64.82,61.753]]', 1, 99, '2014-11-22 15:02:02', '2014-11-22 15:02:02', 0, 0, 0, 46, '["","aidlpercmstpsraswrfldnon_idlesteady03",42,[]]', 0, 'Survivor2_DZ', 0, 2500, 0);
		/* If the guys didn't had an alive character this creates a char for him with his bankmoney as cash on him in stary sobor. */
	END IF;

END LOOP; 
CLOSE player_cursor;
DEALLOCATE player_cursor;

ALTER TABLE character_data DROP COLUMN CashMoney;

