package com.mvc.service;


import java.math.BigDecimal;
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
	public List<Object> getCard(int uid,boolean isSell,String season){
		String sql="select card from Btc_phonecard card where 1=1";
		if(uid!=0)sql=sql+" and card.uid="+uid+"";
		if(isSell==true){sql=sql+" and card.usetime is not null";}
		else if(isSell==false){sql=sql+" and card.usetime is null";}
		if(season!=null)sql=sql+" and card.season='"+season+"'";
		sql=sql+" order by card.id desc";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0) return list;
		return null;
	}
	@Transactional
	public List<Object> getCard(int uid,String season){
		String sql="select card from Btc_phonecard card where 1=1";
		if(uid!=0)sql=sql+" and card.uid="+uid+"";
		if(season!=null)sql=sql+" and card.season='"+season+"'";
		sql=sql+" order by card.id desc";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0) return list;
		return null;
	}
	
	public BigDecimal getAmount(String type){
		String sql="select count(card.id) from Btc_phonecard card where card.usetime is not null";
		if(type.equals("day"))sql=sql+" and DATE(card.usetime)=CURDATE()";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0)
			if(list.get(0)!=null)return new BigDecimal(list.get(0).toString());
		return new BigDecimal(0);
	}
	
	public BigDecimal getKucun(){
		String sql="select count(card.id) from Btc_phonecard card where card.usetime is null";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0)
			if(list.get(0)!=null)return new BigDecimal(list.get(0).toString());
		return new BigDecimal(0);
	}
	
	public String getLatestSeason(){
		List<Object> list=entityDao.createQuery("select card from Btc_phonecard card order by card.id desc");
		if(list.size()!=0){
			Btc_phonecard card=(Btc_phonecard)list.get(0);
			return card.getSeason();
		}
		return "nodata";
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
