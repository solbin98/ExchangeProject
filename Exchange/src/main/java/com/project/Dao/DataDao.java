package com.project.Dao;


import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.project.Dto.CoinDto;
import com.project.Dto.CoinOhlcDto;
import com.project.Dto.ContractDto;
import com.project.Dto.OrderBookDto;


public interface DataDao {
	public List<CoinDto> getAllCoinList();
	public List<ContractDto> getContractList(@Param("cnumber")int cnumber);
	public float getPrice(@Param("pnumber")int pnumber);
	public List<OrderBookDto> getBuySideOrderBookInfo(@Param("bnumber")int bnumber);
	public List<OrderBookDto> getSellSideOrderBookInfo(@Param("snumber")int snumber);
	public List<CoinOhlcDto> getCoinOhlcList(@Param("cnumber")int cnumber);
}
