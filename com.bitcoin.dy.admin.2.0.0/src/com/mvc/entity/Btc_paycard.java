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
@Table(name = "btc_paycard")
public class Btc_paycard implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "paycard_id", nullable = false)
	private Integer paycard_id;
	@Column(name = "paycard_num")
	private String paycard_num;
	@Column(name = "paycard_password")
	private String paycard_password;
	@Column(name="paycard_mianzhi")
	private BigDecimal paycard_mianzhi;
	@Column(name="paycard_usetime")
	private String paycard_usetime;
	@Column(name="paycard_usestatus")
	private String paycard_usestatus;
	@Column(name="paycard_user")
	private String paycard_user;
	@Column(name="paycard_gtime")
	private String paycard_gtime;

	public Integer getPaycard_id() {
		return paycard_id;
	}


	public void setPaycard_id(Integer paycard_id) {
		this.paycard_id = paycard_id;
	}



	public String getPaycard_password() {
		return paycard_password;
	}


	public void setPaycard_password(String paycard_password) {
		this.paycard_password = paycard_password;
	}


	public String getPaycard_num() {
		return paycard_num;
	}


	public void setPaycard_num(String paycard_num) {
		this.paycard_num = paycard_num;
	}


	public BigDecimal getPaycard_mianzhi() {
		return paycard_mianzhi;
	}


	public void setPaycard_mianzhi(BigDecimal paycard_mianzhi) {
		this.paycard_mianzhi = paycard_mianzhi;
	}


	public String getPaycard_usetime() {
		return paycard_usetime;
	}


	public void setPaycard_usetime(String paycard_usetime) {
		this.paycard_usetime = paycard_usetime;
	}


	public String getPaycard_usestatus() {
		return paycard_usestatus;
	}


	public void setPaycard_usestatus(String paycard_usestatus) {
		this.paycard_usestatus = paycard_usestatus;
	}


	public String getPaycard_user() {
		return paycard_user;
	}


	public void setPaycard_user(String paycard_user) {
		this.paycard_user = paycard_user;
	}


	public String getPaycard_gtime() {
		return paycard_gtime;
	}


	public void setPaycard_gtime(String paycard_gtime) {
		this.paycard_gtime = paycard_gtime;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
