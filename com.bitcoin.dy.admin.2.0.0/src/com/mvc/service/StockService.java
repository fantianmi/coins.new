package com.mvc.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_stock;
/**
 * 币种操作service
 * @author jack
 *
 */
@Service
public class StockService {
	@Autowired
	private EntityDao entityDao;
	
	/**
	 * 获取现有所有币种
	 * @return
	 */
	@Transactional
	public Map<Integer, Object> getBtc_stock(){
		List<Object> list = entityDao.createQuery("select btc_stock from Btc_stock btc_stock where btc_stock.is_real_stock='1' group by btc_stock.btc_stock_name");
		Map<Integer, Object> stock_map = new HashMap<Integer, Object>();
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				Btc_stock btc_stock = (Btc_stock)list.get(i);
				stock_map.put(btc_stock.getBtc_stock_id(), btc_stock);
			}
			return stock_map;
		}else{
			return stock_map = null;
		}	
	}
	
	public Map<Integer, Object> getBtc_stockAll(){
		List<Object> list = entityDao.createQuery("select btc_stock from Btc_stock btc_stock group by btc_stock.btc_stock_name");
		Map<Integer, Object> stock_map = new HashMap<Integer, Object>();
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				Btc_stock btc_stock = (Btc_stock)list.get(i);
				stock_map.put(btc_stock.getBtc_stock_id(), btc_stock);
			}
			return stock_map;
		}else{
			return stock_map = null;
		}	
	}
	public Map<Integer, Object> getSelfBtc_stockMap(){
		List<Object> list = entityDao.createQuery("select stock from Btc_stock stock where stock.is_real_stock='0' group by stock.btc_stock_name");
		Map<Integer, Object> stock_map = new HashMap<Integer, Object>();
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				Btc_stock btc_stock = (Btc_stock)list.get(i);
				stock_map.put(btc_stock.getBtc_stock_id(), btc_stock);
			}
			return stock_map;
		}else{
			return stock_map = null;
		}	
	}
	
	public Map<Integer, Object> getAllBtc_stock(){
		List<Object> list = entityDao.createQuery("select btc_stock from Btc_stock btc_stock where btc_stock.is_real_stock='1'");
		Map<Integer, Object> stock_map = new HashMap<Integer, Object>();
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				Btc_stock btc_stock = (Btc_stock)list.get(i);
				stock_map.put(btc_stock.getBtc_stock_id(), btc_stock);
			}
			return stock_map;
		}else{
			return stock_map = null;
		}	
	}
	
	
	public Btc_stock getBtc_stockById(int stock_id){
		List<Object> list = entityDao.createQuery("select stock from Btc_stock stock where stock.btc_stock_id="+stock_id+"");
		Btc_stock btc_stock = new Btc_stock();
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				btc_stock = (Btc_stock)list.get(0);
			}
			return btc_stock;
		}else{
			return btc_stock = null;
		}	
	}
	
	public Btc_stock getSelfBtc_stockById(int Btc_stock_id){
		List<Object> list = entityDao.createQuery("select stock from Btc_stock stock where stock.btc_stock_id="+Btc_stock_id+"");
		Btc_stock btc_stock = new Btc_stock();
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				btc_stock = (Btc_stock)list.get(0);
			}
			return btc_stock;
		}else{
			return btc_stock = null;
		}	
	}
	
	/**
	 * 获取指定币种兑换的币种
	 * @return
	 */
	public Map<String, Object> getBtc_stockByExchangeStockName(String btc_stock_exchange_name){
		List<Object> list = entityDao.createQuery("select bs from Btc_stock bs where bs.btc_stock_exchange_name='"+btc_stock_exchange_name+"'");
		Map<String, Object> stock_map = new HashMap<String, Object>();
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				Btc_stock btc_stock = (Btc_stock)list.get(i);
				stock_map.put(btc_stock.getBtc_stock_Eng_name(), btc_stock);
			}
			return stock_map;
		}else{
			return stock_map = null;
		}	
	}
	
	/**
	 * 获取导航信息
	 * @return
	 */
	public Map<String, Map<String,Object>> getBtc_stock_Navigate(){
		List<Object> list = entityDao.createQuery("select btc_stock from Btc_stock btc_stock group by btc_stock.btc_stock_name");
		Map<String, Map<String,Object>> stock_map = new HashMap<String, Map<String,Object>>();
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				Btc_stock btc_stock = (Btc_stock)list.get(i);
				Map<String, Object> navigate_child_list = this.getBtc_stockByExchangeStockName(btc_stock.getBtc_stock_Eng_name());
				stock_map.put(btc_stock.getBtc_stock_Eng_name(), navigate_child_list);
			}
			return stock_map;
		}else{
			return stock_map = null;
		}	
	}
	
	public void saveStock(Btc_stock btc_stock){
		entityDao.save(btc_stock);
	}
	
	public void saveSelfStock(Btc_stock btc_stock){
		entityDao.save(btc_stock);
	}
	
	public void updateStock(Btc_stock btc_stock){
		entityDao.update(btc_stock);
	}
	
	public void updateSelfStock(Btc_stock btc_stock){
		entityDao.update(btc_stock);
	}
	
	public void deleteStock(Btc_stock btc_stock){
		entityDao.delete(btc_stock);
	}
	
	public void deleteSelfStock(Btc_stock btc_stock){
		entityDao.delete(btc_stock);
	}
}
