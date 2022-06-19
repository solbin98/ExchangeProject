package com.project.Dto;

public class ContractDto {
	float price;
	float volume;
	String date_complete;

	public ContractDto(float price, float volume, String date_complete) {
		this.price = price;
		this.volume = volume;
		this.date_complete = date_complete;
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
	public String getDate_complete() {
		return date_complete;
	}
	public void setDate_complete(String date) {
		this.date_complete = date;
	}
}
