package com.mvc.service.shop;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_phonecard;

@Service
public class PhonecardService {
	@Autowired
	private EntityDao entityDao;
	
	@Transactional
	public List<Object> getCard(int uid,boolean isSell){
		String sql="select card from Btc_phonecard card where 1=1";
		if(uid!=0)sql=sql+" and card.uid="+uid+"";
		if(isSell==true)sql=sql+" and card.usetime is not null";
		else sql=sql+" and card.usetime is null and card.sdtime is not null";
		sql=sql+" order by card.id desc";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0) return list;
		return null;
	}
	public List<Object> getCard(int uid,boolean isSell,String season){
		String sql="select card from Btc_phonecard card where 1=1";
		if(uid!=0)sql=sql+" and card.uid="+uid+"";
		if(isSell==true)sql=sql+" and card.usetime is not null";
		if(season!=null)sql=sql+" and card.season='"+season+"'";
		sql=sql+" order by card.id desc";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0) return list;
		return null;
	}
	
	public List<Object> getCard(int uid,boolean isSell,int start,int count){
		String sql="select card from Btc_phonecard card where 1=1";
		if(uid!=0)sql=sql+" and card.uid="+uid+"";
		if(isSell==true)sql=sql+" and card.usetime is not null";
		else sql=sql+" and card.usetime is null and card.sdtime is not null";
		sql=sql+" order by card.id desc";
		List<Object> list = entityDao.createQuery(sql,start,count);
		if(list.size()!=0) return list;
		return null;
	}
	public String getLatestSeason(){
		List<Object> list=entityDao.createQuery("select card from Btc_phonecard card order by card.id desc");
		if(list.size()!=0){
			Btc_phonecard card=(Btc_phonecard)list.get(0);
			return card.getSeason();
		}
		return "nodata";
	}
	
	public Btc_phonecard getCardById(int id){
		String sql="select card from Btc_phonecard card where card.id="+id+"";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0) return (Btc_phonecard)list.get(0);
		return null;
	}
	public void save(Btc_phonecard card){
		entityDao.save(card);
	}
	public void update(Btc_phonecard card){
		entityDao.update(card);
	}
	public void delete(Btc_phonecard card){
		entityDao.delete(card);
	}
}
