Drop procedure addAsset;

DELIMITER $$ 
CREATE PROCEDURE addAsset(
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
    set cnt = (select count(*) from asset where user_id = ouser_id and coin_number = ocoin_number);
    
	if(cnt = 0) then
		#자산 추가
		insert into asset(average_price, volume, volume_frozen, coin_number, user_id) 
				  VALUES (oprice, ovolume, 0, ocoin_number, ouser_id);
	end if;
	
	if(cnt != 0) then
		set prevVolume = (select volume from asset where user_id = ouser_id and coin_number = ocoin_number);
        #볼륨 더하기
		update asset set volume = volume + ovolume where user_id = ouser_id and coin_number = ocoin_number;
        #평단가 수정하기
        update asset set average_price = ((average_price * prevVolume) + ovolume * oprice)/(prevVolume + ovolume) 
														where user_id = ouser_id and coin_number = ocoin_number;
	end if;
    
END$$
DELIMITER ; 


call addAsset(42, 3.5, "LB", "2022-06-04", 'exode4', 2);