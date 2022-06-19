package com.project.Dto;

public class OrderBookDto {
	int coin_number;
	float price;
	float volume;
	String side;
	
	
	public OrderBookDto(int coin_number, float price, float volume, String side) {
		this.coin_number = coin_number;
		this.price = price;
		this.volume = volume;
		this.side = side;
	}
	
	public int getCoin_number() {
		return coin_number;
	}
	public void setCoin_number(int coin_number) {
		this.coin_number = coin_number;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public float getVolume() {
		return volume;
	}
	public void setVolume(float volume) {
		this.volume = volume;
	}
	public String getSide() {
		return side;
	}
	public void setSide(String side) {
		this.side = side;
	}
}
