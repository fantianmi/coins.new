package com.mvc.service;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_inAll;
import com.mvc.entity.Btc_incomeCNY;
import com.mvc.entity.Btc_incomeStock;
import com.mvc.entity.Btc_outcomeCNY;
import com.mvc.entity.Btc_stock;

@Service
public class PoundageService {
	@Autowired
	private EntityDao entityDao;
	
	@Transactional
	public BigDecimal getInAll_ByTimearea(String start,String end){
		BigDecimal amount = new BigDecimal(0);
		List<Object> list = entityDao.createQuery("select sum(bic.btc_incomeCNY_amount) from Btc_incomeCNY bic " +
				"where date(bic.btc_incomeCNY_time) >= '"+start+"' and date(bic.btc_incomeCNY_time) <= '"+end+"'");
		if (list.size() != 0) {
			if(list.get(0)!=null){
				amount = new BigDecimal(list.get(0).toString());
			}
		}	
		return amount;
	}
	
	
}
