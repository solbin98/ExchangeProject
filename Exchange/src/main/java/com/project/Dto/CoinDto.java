package com.project.Dto;

public class CoinDto {
	int coin_number;
	String name;
	float price;
	
	
	public CoinDto(int coin_number, String name, float price) {
		this.coin_number = coin_number;
		this.name = name;
		this.price = price;
	}


	public int getCoin_number() {
		return coin_number;
	}

	public void setCoin_number(int coin_number) {
		this.coin_number = coin_number;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}
	
}
