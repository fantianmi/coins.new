package com.mvc.vo;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;

@Entity
@SuppressWarnings("serial")
public class Btc_deal_list_today_vo implements Serializable {
	private BigDecimal btc_deal_today_RateMax;
	private BigDecimal btc_deal_today_RateMin;
	private BigDecimal btc_deal_today_Total;
	private BigDecimal btc_deal_today_Latest;
	
	public BigDecimal getBtc_deal_today_Latest() {
		return btc_deal_today_Latest;
	}
	public void setBtc_deal_today_Latest(BigDecimal btc_deal_today_Latest) {
		this.btc_deal_today_Latest = btc_deal_today_Latest;
	}
	public BigDecimal getBtc_deal_today_RateMax() {
		return btc_deal_today_RateMax;
	}
	public void setBtc_deal_today_RateMax(BigDecimal btc_deal_today_RateMax) {
		this.btc_deal_today_RateMax = btc_deal_today_RateMax;
	}
	public BigDecimal getBtc_deal_today_RateMin() {
		return btc_deal_today_RateMin;
	}
	public void setBtc_deal_today_RateMin(BigDecimal btc_deal_today_RateMin) {
		this.btc_deal_today_RateMin = btc_deal_today_RateMin;
	}
	public BigDecimal getBtc_deal_today_Total() {
		return btc_deal_today_Total;
	}
	public void setBtc_deal_today_Total(BigDecimal btc_deal_today_Total) {
		this.btc_deal_today_Total = btc_deal_today_Total;
	}
}
