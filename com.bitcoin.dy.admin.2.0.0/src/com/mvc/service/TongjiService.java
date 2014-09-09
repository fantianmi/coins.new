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
import com.mvc.entity.Btc_tongji;
/**
 * 币种操作service
 * @author jack
 *
 */
@Service
public class TongjiService {
	@Autowired
	private EntityDao entityDao;
	
	/**
	 * 获取现有所有币种
	 * @return
	 */
	@Transactional
	public boolean getByTypeAndDate(String type, String date){
		List<Object> list = entityDao.createQuery("select tongji from Btc_tongji tongji where tongji.tongji_type='"+type+"' and DATE(tongji.tongji_time)='"+date+"'");
		if (list.size() != 0) {
			return true;
		}else{
			return false;
		}	
	}
	
	public void saveTongji(Btc_tongji tongji){
		entityDao.save(tongji);
	}
	
	public void updateTongji(Btc_tongji tongji){
		entityDao.update(tongji);
	}
	
	public void deleteTongji(Btc_tongji tongji){
		entityDao.delete(tongji);
	}
	
}
