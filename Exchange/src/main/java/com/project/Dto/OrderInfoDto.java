package com.project.Dto;

public class OrderInfoDto {
	float price;
	float volume;
	String type;
	String date;
	String user_id;
	int coin_number;
	
	public OrderInfoDto(float price, float volume, String type, String date, String user_id, int coin_number) {
		this.price = price;
		this.volume = volume;
		this.type = type;
		this.date = date;
		this.user_id = user_id;
		this.coin_number = coin_number;
	}
	
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public float getVolume() {
		return this.volume;
	}
	public void setVolume(float volume) {
		this.volume = volume;
	}
	public String getType() {
		return this.type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getUser_id() {
		return this.user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getCoin_number() {
		return coin_number;
	}
	public void setCoin_number(int coin_number) {
		this.coin_number = coin_number;
	}

	@Override
	public String toString() {
		return "OrderInfoDto [price=" + price + ", volume=" + volume + ", type=" + type + ", date=" + date
				+ ", user_id=" + user_id + ", coin_number=" + coin_number + "]";
	}
	
}
