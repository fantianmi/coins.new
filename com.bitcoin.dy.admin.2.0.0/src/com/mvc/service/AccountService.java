package com.mvc.service;


import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_account_book;
/**
 * 处理用户账户帐本的增删改查
 * @author jack
 *
 */
@Service
public class AccountService {
	@Autowired
	private EntityDao entityDao;
	
	/**
	 * 根据用户id查询对应账本信息
	 * @param uid
	 * @return
	 */
	public Btc_account_book getByUidForAcount(int uid){
		Btc_account_book bab = new Btc_account_book();
		List<Object> list = entityDao.createQuery("select bab from Btc_account_book bab where bab.uid='" + uid + "'");
		if (list.size() != 0) {
			bab = (Btc_account_book)list.get(0);
			return bab;
		}else{
			return bab = null;
		}	
	}
	
	public List<Object> getAll(int start,int count){
		List<Object> list=entityDao.createQuery("select bab from Btc_account_book bab order by bab.ab_cny desc",start,count);
		if(list.size()!=0)return list;
		return null;
	}
	public List<Object> getAll(){
		List<Object> list=entityDao.createQuery("select bab from Btc_account_book bab order by bab.ab_cny desc");
		if(list.size()!=0)return list;
		return null;
	}
	
	public BigDecimal total(int uid){
		String sql="select sum(account.ab_cny) from Btc_account_book account where 1=1";
		if(uid!=0) sql=sql+" and account.uid="+uid+"";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0)
			if(list.get(0)!=null)
				return new BigDecimal(list.get(0).toString());
		return new BigDecimal(0);
	}
	
	public Map<Integer,Object> getAllUserByMap(){
		Map<Integer,Object> useraccountmap = new HashMap<Integer,Object>();
		Btc_account_book bab = new Btc_account_book();
		List<Object> list = entityDao.createQuery("select bab from Btc_account_book bab");
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				bab = (Btc_account_book)list.get(i);
				useraccountmap.put(bab.getUid(), bab);
			}
			return useraccountmap;
		}else{
			return null;
		}	
	}
	public Map<Integer,BigDecimal> getMapByUIDandAMOUNT(){
		Map<Integer,BigDecimal> useraccountmap = new HashMap<Integer,BigDecimal>();
		Btc_account_book bab = new Btc_account_book();
		List<Object> list = entityDao.createQuery("select bab from Btc_account_book bab");
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				bab = (Btc_account_book)list.get(i);
				useraccountmap.put(bab.getUid(), bab.getAb_cny());
			}
			return useraccountmap;
		}else{
			return null;
		}	
	}
	
	/**
	 * 更新用户账户本
	 * @param bab 传入账户本对象
	 */
	public void updateAccount_Book(Btc_account_book bab) {
		entityDao.update(bab);
	}
	
	/**
	 * 更新用户账户本
	 * @param bab 传入账户本对象
	 */
	public void saveAccount_Book(Btc_account_book bab) {
		entityDao.save(bab);
	}
}
