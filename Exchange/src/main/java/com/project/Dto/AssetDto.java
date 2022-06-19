package com.project.Dto;

public class AssetDto {
	float average_price;
	float volume;
	float volume_frozen;
	int coin_number;
	String user_id;
	

	public float getAverage_price() {
		return average_price;
	}


	public void setAverage_price(float average_price) {
		this.average_price = average_price;
	}


	public float getVolume() {
		return volume;
	}


	public void setVolume(float volume) {
		this.volume = volume;
	}


	public float getVolume_frozen() {
		return volume_frozen;
	}


	public void setVolume_frozen(float volume_frozen) {
		this.volume_frozen = volume_frozen;
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


	public AssetDto(float average_price, float volume, float volume_frozen, int coin_number,
			String user_id) {
		this.average_price = average_price;
		this.volume = volume;
		this.volume_frozen = volume_frozen;
		this.coin_number = coin_number;
		this.user_id = user_id;
	}

}
