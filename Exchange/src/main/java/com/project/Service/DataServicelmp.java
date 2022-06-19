package com.project.Service;


import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Dao.AssetDao;
import com.project.Dao.DataDao;
import com.project.Dto.AssetDto;
import com.project.Dto.AssetSearchDto;
import com.project.Dto.CoinDto;
import com.project.Dto.CoinOhlcDto;
import com.project.Dto.ContractDto;
import com.project.Dto.OrderBookDto;

@Service
public class DataServicelmp implements DataService {
	@Autowired
	DataDao dataDao;
	
	@Autowired
	AssetDao assetDao;

	@Override
	public AssetDto getAsset(AssetSearchDto dto) {
		return assetDao.getAsset(dto);
	}

	@Override
	public List<CoinDto> getAllCoinList() {
		return dataDao.getAllCoinList();
	}
	
	@Override
	public List<ContractDto> getContractList(int coin_number){
		List<ContractDto> ret = dataDao.getContractList(coin_number);
		int size = 15 - ret.size();
		for(int i=0;i<size;i++) {
			ContractDto tmp = new ContractDto(0,0,"-");
			ret.add(tmp);
		}
		return ret;
	}
	
	@Override
	public float getPrice(int num){
		return dataDao.getPrice(num);
	}
	
	@Override
	public List<OrderBookDto> getBuySideOrderBookInfo(int num){
		List<OrderBookDto> ret = dataDao.getBuySideOrderBookInfo(num);
		int size = 15 - ret.size();
		for(int i=0;i<size;i++) {
			OrderBookDto tmp = new OrderBookDto(1,0,0,"LS");
			ret.add(tmp);
		}
		return ret;
	}
	
	@Override
	public List<OrderBookDto> getSellSideOrderBookInfo(int num){
		List<OrderBookDto> ret = dataDao.getSellSideOrderBookInfo(num);
		Collections.reverse(ret);
		int size = 15 - ret.size();
		for(int i=0;i<size;i++) {
			OrderBookDto tmp = new OrderBookDto(1,0,0,"LB");
			ret.add(0, tmp);
		}
		return ret;
	}
	
	@Override
	public List<CoinOhlcDto> getCoinOhlcList(int num){
		List<CoinOhlcDto> ret = dataDao.getCoinOhlcList(num);
		Collections.reverse(ret);
		return ret;
	}
}
