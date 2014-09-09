package com.mvc.vo;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;

@Entity
@SuppressWarnings("serial")
public class UserDealModel implements Serializable {
	private Integer id;
	private String stockName;
	private BigDecimal price;
	private BigDecimal duihuane;
	private BigDecimal amount;
	private String exstock;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getExstock() {
		return exstock;
	}
	public void setExstock(String exstock) {
		this.exstock = exstock;
	}
	public String getStockName() {
		return stockName;
	}
	public void setStockName(String stockName) {
		this.stockName = stockName;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public BigDecimal getDuihuane() {
		return duihuane;
	}
	public void setDuihuane(BigDecimal duihuane) {
		this.duihuane = duihuane;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	
}
