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
public class FinanceService {
	@Autowired
	private EntityDao entityDao;
	
	@Transactional
	public Btc_inAll getInAll_ByName(String stockName){
		List<Object> list = entityDao.createQuery("select btc_inAll from Btc_inAll btc_inAll where btc_inAll.btc_inAll_name='"+stockName+"'");
		Btc_inAll btc_inAll = new Btc_inAll();
		if (list.size() != 0) {
			btc_inAll = (Btc_inAll)list.get(0);
			return btc_inAll;
		}else{
			return btc_inAll = null;
		}	
	}
	
	public List<Object> getInAll_List(){
		List<Object> list = entityDao.createQuery("select btc_inAll from Btc_inAll btc_inAll");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public BigDecimal getIncomeCNY_amount(){
		BigDecimal income = new BigDecimal(0);
		List<Object> list = entityDao.createQuery("select SUM(income.btc_incomeCNY_amount) from Btc_incomeCNY income");
		if (list.size() != 0) {
			income = new BigDecimal(list.get(0).toString());
			return income;
		}else{
			return income;
		}	
	}
	
	public BigDecimal getOutcomeCNY_amount(){
		BigDecimal outcome = new BigDecimal(0);
		List<Object> list = entityDao.createQuery("select SUM(outcome.btc_outcomeCNY_amount) from Btc_outcomeCNY outcome");
		if (list.size() != 0) {
			outcome = new BigDecimal(list.get(0).toString());
			return outcome;
		}else{
			return outcome;
		}	
	}
	
	public List<Object> getBtc_incomeCNY_List(){
		List<Object> list = entityDao.createQuery("select income from Btc_incomeCNY income order by income.btc_incomeCNY_time desc");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public List<Object> getBtc_incomeStock_List(){
		List<Object> list = entityDao.createQuery("select income from Btc_incomeStock income order by income.btc_incomeStock_time desc");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public List<Object> getBtc_outcomeCNY_List(){
		List<Object> list = entityDao.createQuery("select outcome from Btc_outcomeCNY outcome order by outcome.btc_outcomeCNY_time desc");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public List<Object> getBtc_outcomeStock_List(){
		List<Object> list = entityDao.createQuery("select outcome from Btc_outcomeStock outcome order by outcome.btc_outcomeStock_time desc");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public void saveInAll(Btc_inAll btc_inAll){
		entityDao.save(btc_inAll);
	}
	
	public void updateInAll(Btc_inAll btc_inAll){
		entityDao.update(btc_inAll);
	}
	
	public void saveIncomeCNY(Btc_incomeCNY btc_incomeCNY){
		entityDao.save(btc_incomeCNY);
	}
	
	public void saveIncomeStock(Btc_incomeStock stock){
		entityDao.save(stock);
	}
	
	public void saveOutcomeCNY(Btc_outcomeCNY btc_outcomeCNY){
		entityDao.save(btc_outcomeCNY);
	}
	
	public void updateStock(Btc_stock btc_stock){
		entityDao.update(btc_stock);
	}
	
	public void deleteStock(Btc_stock btc_stock){
		entityDao.delete(btc_stock);
	}
}
