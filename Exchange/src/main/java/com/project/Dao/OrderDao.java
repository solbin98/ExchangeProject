package com.project.Dao;

import org.apache.ibatis.annotations.Param;
import com.project.Dto.OrderInfoDto;


public interface OrderDao {
	public void LimitBuyOrder(@Param("LBdto")OrderInfoDto LBdto);
	public void LimitSellOrder(@Param("LSdto")OrderInfoDto LSdto);
	public void MarketBuyOrder(@Param("MBdto")OrderInfoDto dto1);
	public void MarketSellOrder(@Param("MSdto")OrderInfoDto dto2);
}
