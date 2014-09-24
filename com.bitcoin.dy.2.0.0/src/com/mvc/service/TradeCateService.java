package com.mvc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_trade_category;
import com.mvc.vo.NaviStockModel;

/**
 * 处理用户账户帐本的增删改查
 * 
 * @author jack
 * 
 */
@Service
public class TradeCateService {
	@Autowired
	private EntityDao entityDao;
	@Autowired
	private StockService stocks;
	@Autowired
	private DealService deals;

	/**
	 * 根据用户id查询对应账本信息
	 * 
	 * @param uid
	 * @return
	 */
	public List<Object> getTradeCateByExstock(String exstock) {
		List<Object> list = entityDao.createQuery("select tdc from Btc_trade_category tdc where tdc.tradec_exstock='"
								+ exstock + "'");
		if (list.size() != 0) {
			return list;
		} else {
			return null;
		}
	}
	/**
	 * 根据用户id查询对应账本信息
	 * @param uid
	 * @return
	 */
	public List<NaviStockModel> getTradeCateByExstockNavi(String exstock){
		List<NaviStockModel> nlist = new ArrayList<NaviStockModel>();
		Btc_trade_category cstock = new Btc_trade_category();
		
		Btc_stock stock = new Btc_stock();
		Map<Integer,Object> stockmap = stocks.getBtc_stockMapbyId();
		List<Object> list = entityDao.createQuery("select btc from Btc_trade_category btc where btc.tradec_exstock='" + exstock + "'");
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				cstock = (Btc_trade_category)list.get(i);
				stock = (Btc_stock)stockmap.get(cstock.getTradec_stockid());
				NaviStockModel nsm = new NaviStockModel();
				nsm.setEngName(stock.getBtc_stock_Eng_name()	);
				nsm.setExstock(exstock);
				nsm.setId(stock.getBtc_stock_id());
				nsm.setLastprice(deals.getLtPrice(nsm.getId(), exstock));
				nsm.setName(stock.getBtc_stock_name());
				nsm.setNewsprice(cstock.getTradec_price());
				nsm.setZdf(nsm.getNewsprice(), nsm.getLastprice());
				nsm.setImgsrc(stock.getLogoadr());
				nlist.add(nsm);
			}
			return nlist;
		}else{
			return null;
		}	
	}

	public Map<String, List<Object>> getNav() {
		Btc_trade_category stock = new Btc_trade_category();
		Map<String, List<Object>> map = new HashMap<String, List<Object>>();
		List<Object> list = entityDao
				.createQuery("select stock from Btc_trade_category stock group by stock.tradec_exstock");
		if (list.size() != 0) {
			for (int i = 0; i < list.size(); i++) {
				stock = (Btc_trade_category) list.get(i);
				String stockName = stock.getTradec_exstock();
				List<Object> list2 = entityDao
						.createQuery("select tdc from Btc_trade_category tdc where tdc.tradec_exstock='"
								+ stockName + "'");
				if (list.size() != 0) {
					map.put(stockName, list2);
				}
			}
			return map;
		}
		return null;
	}

	public Map<Integer, Btc_trade_category> getTradeCateByExstockMap(
			String exstock) {
		Map<Integer, Btc_trade_category> map = new HashMap<Integer, Btc_trade_category>();
		Btc_trade_category btc = new Btc_trade_category();
		List<Object> list = entityDao
				.createQuery("select btc from Btc_trade_category btc where btc.tradec_exstock='"
						+ exstock + "'");
		if (list.size() != 0) {
			for (int i = 0; i < list.size(); i++) {
				btc = (Btc_trade_category) list.get(i);
				map.put(btc.getTradec_stockid(), btc);
			}
			return map;
		} else {
			return null;
		}
	}

	public Btc_trade_category getTradeCateByBtcid(int tradecid) {
		Btc_trade_category btc = new Btc_trade_category();
		List<Object> list = entityDao
				.createQuery("select btc from Btc_trade_category btc where btc.tradecid='"
						+ tradecid + "'");
		if (list.size() != 0) {
			btc = (Btc_trade_category) list.get(0);
			return btc;
		} else {
			return null;
		}
	}

	public Btc_trade_category getTradeCateByBtcid(int tradec_stockid,
			String tradec_exstock) {
		Btc_trade_category btc = new Btc_trade_category();
		List<Object> list = entityDao
				.createQuery("select btc from Btc_trade_category btc where btc.tradec_stockid='"
						+ tradec_stockid
						+ "'"
						+ "and btc.tradec_exstock='"
						+ tradec_exstock + "'");
		if (list.size() != 0) {
			btc = (Btc_trade_category) list.get(0);
			return btc;
		} else {
			return null;
		}
	}

	public void updateBtc_trade_category(Btc_trade_category btc) {
		entityDao.update(btc);
	}

	public void saveBtc_trade_category(Btc_trade_category btc) {
		entityDao.save(btc);
	}

	public void deleteBtc_trade_category(Btc_trade_category btc) {
		entityDao.delete(btc);
	}
}
