package com.mvc.service.farm;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_farmer;
@Service
public class FarmerService {
	@Autowired
	private EntityDao entityDao;
	
	public List<Object> get(int uid){
		String sql="select farmer from Btc_farmer farmer where 1=1";
		if(uid!=0) sql=sql+" and farmer.uid="+uid+"";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0)return list;
		return null;
	}
	
	public void save(Btc_farmer entity) {
		entityDao.save(entity);
	}
	public void update(Btc_farmer entity) {
		entityDao.update(entity);
	}
	public void delete(Btc_farmer entity) {
		entityDao.delete(entity);
	}
}
