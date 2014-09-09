package com.mvc.service;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_content;
/**
 * 处理用户账户帐本的增删改查
 * @author jack
 *
 */
@Service
public class CotentService {
	@Autowired
	private EntityDao entityDao;
	
	/**
	 * 根据用户id查询对应账本信息
	 * @param uid
	 * @return
	 */
	@Transactional
	public Btc_content getContentByid(int btc_content_id){
		Btc_content bc = new Btc_content();
		List<Object> list = entityDao.createQuery("select bc from Btc_content bc where bc.btc_content_id='" + btc_content_id + "'");
		if (list.size() != 0) {
			bc = (Btc_content)list.get(0);
			return bc;
		}else{
			return bc = null;
		}	
	}
	
	public List<Object> getAllContent(){
		List<Object> list = entityDao.createQuery("select bc from Btc_content bc order by bc.btc_content_time desc and bc.btc_content_type desc");
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
	public void updateContent(Btc_content bc) {
		entityDao.update(bc);
	}
	public void deleteContent(Btc_content bc) {
		entityDao.delete(bc);
	}
	public void saveContent(Btc_content bc) {
		entityDao.save(bc);
	}
}
