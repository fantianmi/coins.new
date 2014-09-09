package com.mvc.service;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_votehistory;
/**
 * 处理用户账户帐本的增删改查
 * @author jack
 *
 */
@Service
public class VoteHistoryService {
	@Autowired
	private EntityDao entityDao;
	
	/**
	 * 根据用户id查询对应账本信息
	 * @param uid
	 * @return
	 */
	@Transactional
	public List<Object> getHistroyByUidAndVid(int uid,int vid){
		List<Object> list = entityDao.createQuery("select bv from Btc_votehistory bv where bv.vh_uid='"+uid+"' and bv.vh_vid='" + vid + "'");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	/**
	 * 更新用户账户本
	 * @param bab 传入账户本对象
	 */
	public void updateBtc_votehistory(Btc_votehistory bv) {
		entityDao.update(bv);
	}
	public void deleteBtc_votehistory(Btc_votehistory bv) {
		entityDao.delete(bv);
	}
	public void saveBtc_votehistory(Btc_votehistory bv) {
		entityDao.save(bv);
	}
}
