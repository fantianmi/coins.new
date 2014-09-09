package com.mvc.vo;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;

@Entity
@SuppressWarnings("serial")
public class UserWcnyModel implements Serializable {
	private int id;
	private BigDecimal wmaount;
	private String rtime;
	private String rstatus;
	private String bank;
	private String rname;
	private String kaihubank;
	private String card;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public BigDecimal getWmaount() {
		return wmaount;
	}
	public void setWmaount(BigDecimal wmaount) {
		this.wmaount = wmaount;
	}
	public String getRtime() {
		return rtime;
	}
	public void setRtime(String rtime) {
		this.rtime = rtime;
	}
	public String getRstatus() {
		return rstatus;
	}
	public void setRstatus(String rstatus) {
		this.rstatus = rstatus;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getKaihubank() {
		return kaihubank;
	}
	public void setKaihubank(String kaihubank) {
		this.kaihubank = kaihubank;
	}
	public String getCard() {
		return card;
	}
	public void setCard(String card) {
		this.card = card;
	}
	
}
