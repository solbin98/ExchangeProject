package com.project.Dto;

public class CoinOhlcDto {
	int coin_number;
	float open;
	float close;
	float low;
	float high;
	float volume;
	String date;
	
	public int getCoin_number() {
		return coin_number;
	}
	public void setCoin_number(int coin_number) {
		this.coin_number = coin_number;
	}
	public float getOpen() {
		return open;
	}
	public void setOpen(float open) {
		this.open = open;
	}
	public float getClose() {
		return close;
	}
	public void setClose(float close) {
		this.close = close;
	}
	public float getLow() {
		return low;
	}
	public void setLow(float low) {
		this.low = low;
	}
	public float getHigh() {
		return high;
	}
	public void setHigh(float high) {
		this.high = high;
	}
	public float getVolume() {
		return volume;
	}
	public void setVolume(float volume) {
		this.volume = volume;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
