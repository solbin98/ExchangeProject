package com.project.Dto;

public class AssetSearchDto {
	int coin_number;
	String user_id;
	
	public AssetSearchDto(int coin_number, String user_id) {
		this.coin_number = coin_number;
		this.user_id = user_id;
	}

	public int getCoin_number() {
		return coin_number;
	}

	public void setCoin_number(int coin_number) {
		this.coin_number = coin_number;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	

}
