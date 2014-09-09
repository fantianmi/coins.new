package com.mvc.vo;

import java.math.BigDecimal;

public class StockModel {
	private BigDecimal amount;
	private BigDecimal price;
	private String engName;
	private String name;
	private int id;
	public BigDecimal getAomount() {
		return amount;
	}
	public void setAomount(BigDecimal amount) {
		this.amount = amount;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getEngName() {
		return engName;
	}
	public void setEngName(String engName) {
		this.engName = engName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
