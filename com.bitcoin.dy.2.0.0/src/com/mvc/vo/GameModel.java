package com.mvc.vo;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;

@Entity
@SuppressWarnings("serial")
public class GameModel implements Serializable {
	private Integer gameYue;
	private BigDecimal accountyue;
	public Integer getGameYue() {
		return gameYue;
	}
	public void setGameYue(Integer gameYue) {
		this.gameYue = gameYue;
	}
	public BigDecimal getAccountyue() {
		return accountyue;
	}
	public void setAccountyue(BigDecimal accountyue) {
		this.accountyue = accountyue;
	}
	
}
