package com.mvc.vo;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;

@Entity
@SuppressWarnings("serial")
public class FactoryGBConfigModel implements Serializable {
	private BigDecimal abuildamount;
	private String buildtime;
	private BigDecimal buildamount;
	private BigDecimal eachbuildamount;
	private BigDecimal userhaslimit;
	private String type;
	
	public BigDecimal getUserhaslimit() {
		return userhaslimit;
	}
	public void setUserhaslimit(BigDecimal userhaslimit) {
		this.userhaslimit = userhaslimit;
	}
	public BigDecimal getAbuildamount() {
		return abuildamount;
	}
	public void setAbuildamount(BigDecimal abuildamount) {
		this.abuildamount = abuildamount;
	}
	public String getBuildtime() {
		return buildtime;
	}
	public void setBuildtime(String buildtime) {
		this.buildtime = buildtime;
	}
	public BigDecimal getBuildamount() {
		return buildamount;
	}
	public void setBuildamount(BigDecimal buildamount) {
		this.buildamount = buildamount;
	}
	public BigDecimal getEachbuildamount() {
		return eachbuildamount;
	}
	public void setEachbuildamount(BigDecimal eachbuildamount) {
		this.eachbuildamount = eachbuildamount;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
