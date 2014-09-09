package com.mvc.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "btc_award")
public class Btc_award implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Integer id;
	@Column(name = "uid")
	private Integer uid;
	@Column(name = "coinid")
	private Integer coinid;
	@Column(name="coinamount")
	private BigDecimal coinamount;
	@Column(name="reason")
	private String reason;
	@Column(name="time")
	private String time;
	
	
	
	



	public String getTime() {
		return time;
	}







	public void setTime(String time) {
		this.time = time;
	}







	public Integer getId() {
		return id;
	}







	public void setId(Integer id) {
		this.id = id;
	}







	public Integer getUid() {
		return uid;
	}







	public void setUid(Integer uid) {
		this.uid = uid;
	}







	public Integer getCoinid() {
		return coinid;
	}







	public void setCoinid(Integer coinid) {
		this.coinid = coinid;
	}







	public BigDecimal getCoinamount() {
		return coinamount;
	}







	public void setCoinamount(BigDecimal coinamount) {
		this.coinamount = coinamount;
	}







	public String getReason() {
		return reason;
	}







	public void setReason(String reason) {
		this.reason = reason;
	}







	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
