package com.mvc.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_join_build;

@Service
public class FactoryService {
	@Autowired
	private EntityDao entityDao;
	
	
	@Transactional
	public Btc_join_build getBtc_join_buildByTime(int uid) {
		Btc_join_build bjb = new Btc_join_build();
		List<Object> list = entityDao.createQuery("SELECT bjb from Btc_join_build bjb" +
				" where bjb.uid='"+uid+"' and DATE(bjb.date)=CURDATE()");
		if (list.size() != 0) {
			bjb = (Btc_join_build)list.get(0);
			return bjb;
		}
		return null;
	}
	
	public List<Object> getAllBtc_join_buildByTime(String type,String status) {
		List<Object> list = entityDao.createQuery("SELECT bjb from Btc_join_build bjb" +
				" where bjb.status='"+status+"' and bjb.type='"+type+"' order by bjb.id desc");
		if (list.size() != 0) {
			return list;
		}
		return null;
	}
	
	public List<Object> getBtc_join_buildByUid(int uid) {
		List<Object> list = entityDao.createQuery("SELECT bjb from Btc_join_build bjb" +
				" where bjb.uid='"+uid+"' order by bjb.date desc");
		if (list.size() != 0) {
			return list;
		}
		return null;
	}
	
	public Btc_join_build getBtc_join_buildByJbid(int jbid) {
		Btc_join_build bjb = new Btc_join_build();
		List<Object> list = entityDao.createQuery("SELECT bjb from Btc_join_build bjb" +
				" where bjb.id='"+jbid+"'");
		if (list.size() != 0) {
			bjb = (Btc_join_build)list.get(0);
			return bjb;
		}
		return null;
	}
	
	public List<Object> getBtc_join_buildByStatus(String status) {
		List<Object> list = entityDao.createQuery("SELECT bjb from Btc_join_build bjb" +
				" where bjb.status='"+status+"' order by bjb.date desc");
		if (list.size() != 0) {
			return list;
		}
		return null;
	}
	public List<Object> getBtc_join_buildByStatus(String status,int start,int count) {
		List<Object> list = entityDao.createQuery("SELECT bjb from Btc_join_build bjb" +
				" where bjb.status='"+status+"' order by bjb.date desc",start,count);
		if (list.size() != 0) {
			return list;
		}
		return null;
	}
	public int countRow(String status) {
		List<Object> list = entityDao.createQuery("SELECT count(bjb.id) from Btc_join_build bjb" +
				" where bjb.status='"+status+"'");
		if (list.size() != 0) {
			if(list.get(0)!=null){
				return Integer.parseInt(list.get(0).toString());
			}
		}
		return 0;
	}
	
	public void saveBtc_join_build(Btc_join_build bjb) {
		entityDao.save(bjb);
	}
	public void updateBtc_join_build(Btc_join_build bjb) {
		entityDao.update(bjb);
	}
}
