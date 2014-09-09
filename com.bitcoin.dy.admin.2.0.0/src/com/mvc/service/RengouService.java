package com.mvc.service;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mvc.dao.EntityDao;
@Service
public class RengouService {
	@Autowired
	private EntityDao entityDao;
	
	//用户兑换部分rengou_log
	@Transactional
	public List<Object> getUserRengouLogList(){
		List<Object> list = entityDao.createQuery("select bfrl from Btc_frc_rengou_log bfrl order by bfrl.date desc");
		if(list.size()>=0){
			return list;
		}
		return null;
	}
	public List<Object> getUserRengouLogList(int start,int count){
		List<Object> list = entityDao.createQuery("select bfrl from Btc_frc_rengou_log bfrl order by bfrl.date desc",start,count);
		if(list.size()>=0){
			return list;
		}
		return null;
	}
	
	public int countRow(){
		List<Object> list = entityDao.createQuery("select count(bfrl.id) from Btc_frc_rengou_log bfrl");
		if(list.size()>=0){
			if(list.get(0)!=null){
			return Integer.parseInt(list.get(0).toString());
		}}
		return 0;
	}
}
