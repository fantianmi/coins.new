package com.mvc.util;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.entity.Btc_inAll;
import com.mvc.service.FinanceService;
/**
 * 平台币种情况统计账本
 * @author fanti_000
 *
 */
@Service
public class AccountBookUtil {
	@Autowired
	private FinanceService financeService;
	public boolean addStockAccount(String stockName,BigDecimal addAmount){
		Btc_inAll btc_inAll=new Btc_inAll();
		if(financeService.getInAll_ByName(stockName)==null){
			btc_inAll.setBtc_inAll_amount(addAmount);
			btc_inAll.setBtc_inAll_name(stockName);
			financeService.saveInAll(btc_inAll);
		}else{
			btc_inAll = financeService.getInAll_ByName(stockName);
			btc_inAll.setBtc_inAll_amount(btc_inAll.getBtc_inAll_amount().add(addAmount));
			financeService.updateInAll(btc_inAll);
		}
		return true;
	}
	public boolean subStockAccount(String stockName,BigDecimal subAmount){
		Btc_inAll btc_inAll=new Btc_inAll();
		if(financeService.getInAll_ByName(stockName)==null){
			return false;
		}
		btc_inAll = financeService.getInAll_ByName(stockName);
		btc_inAll.setBtc_inAll_amount(btc_inAll.getBtc_inAll_amount().subtract(subAmount));
		financeService.updateInAll(btc_inAll);
		return true;
	}
}
