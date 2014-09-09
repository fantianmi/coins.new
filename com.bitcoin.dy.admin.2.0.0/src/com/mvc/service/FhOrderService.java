package com.mvc.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_fh_order;
import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_order;
import com.mvc.entity.Btc_user;
import com.mvc.entity.Btc_fhDDC;

@Service
public class FhOrderService {
	@Autowired
	private EntityDao entityDao;

	@Transactional
	public List<Object> getByDeliverstatus(String status,int start,int count) {
		List<Object> list = entityDao.createQuery("select bfo from Btc_fh_order bfo where bfo.isdeliver='" + status + "'",start,500);
		if (list.size() != 0) {
			return list;
		}
		return null;
	}
	public int countRow(String status) {
		List<Object> list = entityDao.createQuery("select count(bfo.fh_order_id) from Btc_fh_order bfo where bfo.isdeliver='" + status + "'");
		if (list.size() != 0) {
			if(list.get(0)!=null){
				return Integer.parseInt(list.get(0).toString());
			}
		}
		return 0;
	}
	
	public Btc_fh_order getById(int id) {
		Btc_fh_order bfo = new Btc_fh_order();
		List<Object> list = entityDao.createQuery("select bfo from Btc_fh_order bfo where bfo.fh_order_id=" + id + "");
		if (list.size() != 0) {
			bfo = (Btc_fh_order)list.get(0);
			return bfo;
		}
		return null;
	}
	
	public List<Object> getByGetstatus(String status) {
		List<Object> list = entityDao.createQuery("select bfo from Btc_fh_order bfo where bfo.isget=" + status + "");
		if (list.size() != 0) {
			return list;
		}
		return null;
	}
	
	public void saveFhOrder(Btc_fh_order bfo) {
		entityDao.save(bfo);
	}
	
	public void updateFhOrder(Btc_fh_order bfo) {
		entityDao.update(bfo);
	}
	public void deleteFhOrder(Btc_fh_order bfo) {
		entityDao.delete(bfo);
	}
	
}
