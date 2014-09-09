package com.mvc.entity;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "btc_birth")
public class Btc_birth implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "birth_id", nullable = false)
	private Integer birth_id;
	@Column(name = "birth_time")
	private String birth_time;

	public Integer getBirth_id() {
		return birth_id;
	}

	public void setBirth_id(Integer birth_id) {
		this.birth_id = birth_id;
	}
	public String getBirth_time() {
		return birth_time;
	}


	public void setBirth_time(String birth_time) {
		this.birth_time = birth_time;
	}



	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
