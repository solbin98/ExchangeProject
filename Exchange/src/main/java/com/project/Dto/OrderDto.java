package com.project.Dto;

public class OrderDto {
	int order_number;
	float price;
	float volume;
	String type;
	String date;
	String user_id;
	
	public OrderDto(int order_number, float price, float volume, String type, String date, String user_id) {
		this.order_number = order_number;
		this.price = price;
		this.volume = volume;
		this.type = type;
		this.date = date;
		this.user_id = user_id;
	}
	public int getOrder_number() {
		return order_number;
	}
	public void setOrder_number(int order_number) {
		this.order_number = order_number;
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
	public String getType() {
		return type;
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
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	
	
}
