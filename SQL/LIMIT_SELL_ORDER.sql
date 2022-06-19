drop procedure LimitSellOrder;

DELIMITER $$ 
CREATE PROCEDURE LimitSellOrder(
IN oprice float, 
IN ovolume float, 
IN otype varchar(10),
IN odate varchar(45),
IN ouser_id varchar(45),
IN ocoin_number int
) 
BEGIN
	# 보유 코인 수량과 동결 코인 갯수
    DECLARE mvolume float;
	DECLARE mfvolume float;

	# 주문 매칭 후보가 되는 주문들을 fetch 할때 임시로 데이터를 저장하는 변수들 
    DECLARE firstVolume float default ovolume;
	DECLARE cnt Int;
	DECLARE targetOrderNumber Int;
    DECLARE targetPrice float;
    DECLARE targetVolume float;
	DECLARE targetRemainVolume Float default ovolume;
    DECLARE targetType VARCHAR(10);
    DECLARE targetDate VARCHAR(45);
    DECLARE targetUserId VARCHAR(45);
    DECLARE targetCoinNumber int;
    DECLARE oProfit Float;
    DECLARE targetProfit Float;
    DECLARE endOfRow BOOLEAN default fALSE;
	DECLARE TargetOrders CURSOR FOR 
		select * FROM order_table where type = "LB" and price >= oprice order by price desc;
        
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET endOfRow = TRUE;
    OPEN TargetOrders;
    
    #보유 코인 수량 조회해서 주문 가능 여부 판단
	select volume, volume_frozen into mvolume, mfvolume from asset where user_id = ouser_id and coin_number = ocoin_number;
    if (mvolume - mfvolume >= ovolume) and (mvolume != 0)  then
			cloop: WHILE TRUE DO
				FETCH TargetOrders INTO targetOrderNumber, targetPrice, targetVolume, targetRemainVolume, targetType, targetDate, targetUserId, targetCoinNumber;
				IF endOfRow THEN LEAVE cloop; END IF;
				IF ovolume < targetRemainVolume then
					SET targetRemainVolume = targetRemainVolume - ovolume;
					SET oProfit = ovolume * targetPrice;
                    
					#매수자 코인 보유량 더하기
					call addAsset(targetPrice, ovolume, otype, odate, targetUserId, ocoin_number);
					#매수자 코인 매수 잔량 업데이트
					update order_table set remain_volume = targetRemainVolume where order_number = targetOrderNumber;
					#매수자 현금 보유량 빼기
					update asset set volume = volume - oProfit where user_id = targetUserId and coin_number = 1;
					#매수자 동결 현금량 빼기
					update asset set volume_frozen = volume_frozen - oProfit where user_id = targetUserId and coin_number = 1;
					#주문 완료 테이블에 매수 내역 삽입
					insert into order_complete(order_number, price, volume, type, date, date_complete, user_id, coin_number) 
						   VALUES (0, targetPrice, ovolume, "LB", odate, now(), targetUserId, ocoin_number);
						   
					#매도자 코인 빼기
					update asset set volume = volume - ovolume where user_id = ouser_id and coin_number = ocoin_number;
					#매도자 현금 보유량 더하기
					update asset set volume = volume + oProfit where user_id = ouser_id and coin_number = 1;
					#주문 완료 테이블에 매도 내역 삽입
					insert into order_complete(order_number, price, volume, type, date, date_complete, user_id, coin_number) 
						   VALUES (0, targetPrice, ovolume, "LS", targetDate, now(), ouser_id, ocoin_number);
					
					#코인 종가 업데이트
					update coin_ohlc set close = targetPrice where coin_number = ocoin_number;
					#호가창 업데이트
					call UpdateOrderBook(ocoin_number, targetPrice, ovolume, 'LS');
                    
					SET ovolume = 0;
					leave cloop;
				END if;
				
				IF ovolume >= targetRemainVolume then
					SET ovolume = ovolume - targetRemainVolume;
					SET targetProfit = targetRemainVolume * targetPrice;
					

					#매수자 코인 보유량 더하기
					call addAsset(targetPrice, targetRemainVolume, otype, odate, targetUserId, ocoin_number);
					#매수자 매수 주문 제거
					delete from order_table where order_number = targetOrderNumber;
					#매수자 현금 보유량 빼기
					update asset set volume = volume - targetProfit where user_id = targetUserId and coin_number = 1;
					#매수자 동결 현금량 빼기
					update asset set volume_frozen = volume_frozen - targetProfit where user_id = targetUserId and coin_number = 1;
					#주문 완료 테이블에 매수 내역 삽입
					insert into order_complete(order_number, price, volume, type, date, date_complete, user_id, coin_number) 
						   VALUES (0, targetPrice, targetRemainVolume, "LB", odate, now(), targetUserId, ocoin_number);
						   
					#매도자 코인 빼기
					update asset set volume = volume - targetRemainVolume where user_id = ouser_id and coin_number = ocoin_number;
					#매도자 현금 보유량 더하기
					update asset set volume = volume + targetProfit where user_id = ouser_id and coin_number = 1;
					#주문 완료 테이블에 매도 내역 삽입
					insert into order_complete(order_number, price, volume, type, date, date_complete, user_id, coin_number) 
						   VALUES (0, targetPrice, targetRemainVolume, "LS", targetDate, now(), ouser_id, ocoin_number);
					
					#코인 종가 업데이트
					update coin_ohlc set close = targetPrice where coin_number = ocoin_number;
					#호가창 업데이트
					call UpdateOrderBook(ocoin_number, targetPrice, targetRemainVolume, 'LS');
					if(ovolume <= 0) then leave cloop; end if;
				END if;
			END WHILE;    
			CLOSE TargetOrders;
			
			if ovolume > 0 then
				#주문 목록 테이블에 매도 주문 삽입
				insert into order_table(order_number, price, volume, remain_volume, type, date, user_id, coin_number) 
						VALUES (0, oprice, firstVolume, ovolume, "LS", now(), ouser_id, ocoin_number);
				#매도자 코인 잔여 수량 대입
				update asset set volume_frozen = volume_frozen + ovolume where user_id = ouser_id and coin_number = ocoin_number;
				#호가창 업데이트
				call UpdateOrderBook(ocoin_number, oprice, ovolume, 'LS');
			end if;
	end if;
END$$
DELIMITER ; 


call LimitSellOrder(1, 20, "LS", "2022-06-04", 'solbin98', 2);