package com.project.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Dao.DataDao;
import com.project.Dao.OrderDao;
import com.project.Dto.OrderInfoDto;

@Service
public class OrderServiceImp implements OrderService{
	@Autowired
	OrderDao orderDao;
	
	@Autowired
	DataDao dataDao;
	
	@Override
	public float OrderMapper(OrderInfoDto dto) {
		String type = dto.getType();
		int coin_number = dto.getCoin_number();
		
		if(type.equals("LB")) orderDao.LimitBuyOrder(dto);
		else if(type.equals("LS")) orderDao.LimitSellOrder(dto);
		else if(type.equals("MB")) orderDao.MarketBuyOrder(dto);
		else if(type.equals("MS")) orderDao.MarketSellOrder(dto);
		
		float ret = dataDao.getPrice(coin_number);
		return ret;
	}
}
