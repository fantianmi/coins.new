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
@Table(name = "btc_duihuan")
public class Btc_duihuan implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Integer id;
	@Column(name = "uid")
	private Integer uid;
	@Column(name = "time")
	private String time;
	@Column(name = "subtoolc")
	private BigDecimal subtoolc;
	@Column(name = "addzzc")
	private BigDecimal addzzc;



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



	public String getTime() {
		return time;
	}



	public void setTime(String time) {
		this.time = time;
	}



	public BigDecimal getSubtoolc() {
		return subtoolc;
	}



	public void setSubtoolc(BigDecimal subtoolc) {
		this.subtoolc = subtoolc;
	}



	public BigDecimal getAddzzc() {
		return addzzc;
	}



	public void setAddzzc(BigDecimal addzzc) {
		this.addzzc = addzzc;
	}



	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
