package com.mvc.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_birth;
/**
 * 处理用户账户帐本的增删改查
 * @author jack
 *
 */
@Service
public class BirthService {
	@Autowired
	private EntityDao entityDao;
	
	/**
	 * 根据用户id查询对应账本信息
	 * @param uid
	 * @return
	 */
	public Btc_birth getBirth(){
		Btc_birth bb = new Btc_birth();
		List<Object> list = entityDao.createQuery("select bb from Btc_birth bb");
		if (list.size() != 0) {
			bb = (Btc_birth)list.get(0);
			return bb;
		}else{
			return null;
		}	
	}
	
	public void updateBtc_birth(Btc_birth bb) {
		entityDao.update(bb);
	}
}
