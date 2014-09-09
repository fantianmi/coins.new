package com.mvc.vo;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;

@Entity
@SuppressWarnings("serial")
public class GBConfigModel implements Serializable {
	private BigDecimal arengouamount;
	private BigDecimal abuildamount;
	private BigDecimal amount;
	private BigDecimal rengouamount;
	private BigDecimal buildamount;
	public BigDecimal getArengouamount() {
		return arengouamount;
	}
	public void setArengouamount(BigDecimal arengouamount) {
		this.arengouamount = arengouamount;
	}
	public BigDecimal getAbuildamount() {
		return abuildamount;
	}
	public void setAbuildamount(BigDecimal abuildamount) {
		this.abuildamount = abuildamount;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public BigDecimal getRengouamount() {
		return rengouamount;
	}
	public void setRengouamount(BigDecimal rengouamount) {
		this.rengouamount = rengouamount;
	}
	public BigDecimal getBuildamount() {
		return buildamount;
	}
	public void setBuildamount(BigDecimal buildamount) {
		this.buildamount = buildamount;
	}
	
}
