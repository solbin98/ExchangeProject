Drop procedure subAsset;

DELIMITER $$ 
CREATE PROCEDURE subAsset(
IN oprice float, 
IN ovolume float, 
IN otype varchar(10),
IN odate varchar(45),
IN ouser_id varchar(45),
IN ocoin_number int
) 
BEGIN
	DECLARE cnt Int;
    DECLARE prevVolume float;
    
	set prevVolume = (select volume from asset where user_id = ouser_id and coin_number = ocoin_number);
        
	update asset set volume = volume + ovolume where user_id = ouser_id and coin_number = ocoin_number;
	update asset set average_price = ((average_price * prevVolume) + ovolume * oprice)/(prevVolume + ovolume) 
														where user_id = ouser_id and coin_number = ocoin_number;

    
END$$
DELIMITER ; 


call addAsset(42, 3.5, "LB", "2022-06-04", 'exode4', 2);