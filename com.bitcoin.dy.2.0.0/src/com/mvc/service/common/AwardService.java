package com.mvc.service.common;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_award;
/**
 * 处理用户账户帐本的增删改查
 * @author jack
 *
 */
@Service
public class AwardService {
	@Autowired
	private EntityDao entityDao;
	
	public List<Object> get(int uid,String reason){
		String sql="select award from Btc_award award where 1=1";
		if(uid!=0)sql=sql+" and award.uid="+uid+"";
		if(reason!=null)sql=sql+" and award.reason='"+reason+"'";
		sql=sql+" order by award.time desc";
		
		List<Object> list=entityDao.createQuery(sql);
		if(list.size()!=0)return list;
		return null;
	}
	
	
	public void save(Btc_award entity) {
		entityDao.save(entity);
	}
	public void update(Btc_award entity) {
		entityDao.update(entity);
	}
	public void delete(Btc_award entity) {
		entityDao.delete(entity);
	}
}
