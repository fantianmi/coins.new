package com.mvc.service.farm;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_duihuan;
/**
 * 处理用户账户帐本的增删改查
 * @author jack
 *
 */
@Service
public class DuihuanService {
	@Autowired
	private EntityDao entityDao;
	
	public List<Object> get(int uid){
		String sql="select duihuan from Btc_duihuan duihuan where 1=1";
		if(uid!=0)sql=sql+" and duihuan.uid="+uid+"";
		sql=sql+" order by duihuan.time desc";
		
		List<Object> list=entityDao.createQuery(sql);
		if(list.size()!=0)return list;
		return null;
	}
	
	
	public void save(Btc_duihuan entity) {
		entityDao.save(entity);
	}
	public void update(Btc_duihuan entity) {
		entityDao.update(entity);
	}
	public void delete(Btc_duihuan entity) {
		entityDao.delete(entity);
	}
}
