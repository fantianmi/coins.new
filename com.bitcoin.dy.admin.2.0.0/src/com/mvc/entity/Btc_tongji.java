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
@Table(name = "btc_tongji")
public class Btc_tongji implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "tongji_id", nullable = false)
	private Integer tongji_id;
	@Column(name = "tongji_type")
	private String tongji_type;
	@Column(name = "tongji_time")
	private String tongji_time;


	public Integer getTongji_id() {
		return tongji_id;
	}


	public void setTongji_id(Integer tongji_id) {
		this.tongji_id = tongji_id;
	}


	public String getTongji_type() {
		return tongji_type;
	}


	public void setTongji_type(String tongji_type) {
		this.tongji_type = tongji_type;
	}


	public String getTongji_time() {
		return tongji_time;
	}


	public void setTongji_time(String tongji_time) {
		this.tongji_time = tongji_time;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
