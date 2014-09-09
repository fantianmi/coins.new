package com.mvc.service.shop;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_shop;

@Service
public class ShopService {
	@Autowired
	private EntityDao entityDao;
	
	@Transactional
	public Btc_shop getCardById(){
		String sql="select shop from Btc_shop	shop";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0) return (Btc_shop)list.get(0);
		return null;
	}
	public void update(Btc_shop card){
		entityDao.update(card);
	}
}
