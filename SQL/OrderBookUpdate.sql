Drop procedure UpdateOrderBook;

DELIMITER $$ 
CREATE PROCEDURE UpdateOrderBook(
IN onumber int,
IN oprice float, 
IN ovolume float, 
IN oside varchar(10)
) 
BEGIN
	DECLARE cnt Int;
    DECLARE prevSide varchar(4);
    DECLARE prevVolume float;
    set cnt = (select count(*) from orderbook where price = oprice and coin_number = onumber);
    
	if(cnt = 0) then
		insert into orderbook(coin_number, price, volume, side) 
				  VALUES (onumber, oprice, ovolume, oside);
	end if;

	if(cnt != 0) then
		set prevSide = (select side from orderbook where price = oprice and coin_number = onumber);
		
		if(oside = prevSide) then
			update orderbook set volume = volume + ovolume where price = oprice and coin_number = onumber ;
		end if;
		
		if(oside != prevSide) then
			update orderbook set volume = volume - ovolume where price = oprice and coin_number = onumber;
		end if;
		
        
		delete from orderbook where volume <= 0;
	end if;

END$$
DELIMITER ; 

call UpdateOrderBook(2, 100, 300, 'LB');