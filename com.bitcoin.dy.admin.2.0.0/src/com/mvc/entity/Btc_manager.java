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
@Table(name = "btc_manager")
public class Btc_manager implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "btc_manager_id", nullable = false)
	private Integer btc_manager_id;
	@Column(name = "btc_manager_username")
	private String btc_manager_username;
	@Column(name = "btc_manager_password")
	private String btc_manager_password;
	
	
	public Integer getBtc_manager_id() {
		return btc_manager_id;
	}


	public void setBtc_manager_id(Integer btc_manager_id) {
		this.btc_manager_id = btc_manager_id;
	}


	public String getBtc_manager_username() {
		return btc_manager_username;
	}


	public void setBtc_manager_username(String btc_manager_username) {
		this.btc_manager_username = btc_manager_username;
	}


	public String getBtc_manager_password() {
		return btc_manager_password;
	}


	public void setBtc_manager_password(String btc_manager_password) {
		this.btc_manager_password = btc_manager_password;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
