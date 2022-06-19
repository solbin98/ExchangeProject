package com.project.Service;


import java.util.List;
import com.project.Dto.AssetDto;
import com.project.Dto.AssetSearchDto;
import com.project.Dto.CoinDto;
import com.project.Dto.CoinOhlcDto;
import com.project.Dto.ContractDto;
import com.project.Dto.OrderBookDto;

public interface DataService {
	public AssetDto getAsset(AssetSearchDto dto);
	public List<CoinDto> getAllCoinList();
	public List<ContractDto> getContractList(int coin_number);
	public float getPrice(int pnumber);
	List<OrderBookDto> getBuySideOrderBookInfo(int number);
	List<OrderBookDto> getSellSideOrderBookInfo(int number);
	List<CoinOhlcDto> getCoinOhlcList(int number);
	
}
