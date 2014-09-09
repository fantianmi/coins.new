package com.mvc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_user;

@Service
public class UserService {
	@Autowired
	private EntityDao entityDao;

	@Transactional
	public boolean vertify(String uusername, String upassword) {
		List<Object> list = entityDao.createQuery("select u from Btc_user u where u.uusername='" + uusername + "'");
		Btc_user user = new Btc_user();
		if (list.size() != 0) {
			user = (Btc_user) list.get(0);
		}
		return upassword.equals(user.getUpassword());
	}
	
	public Btc_user getByUsername(String uusername){
		Btc_user user = new Btc_user();
		List<Object> list = entityDao.createQuery("select u from Btc_user u where u.uusername='" + uusername + "'");
		if (list.size() != 0) {
			user = (Btc_user) list.get(0);
			return user;
		}else{
			return user=null;
		}	
	}
	
	public Btc_user getByUserId(int uid){
		Btc_user user = new Btc_user();
		List<Object> list = entityDao.createQuery("select u from Btc_user u where u.uid='" + uid + "'");
		if (list.size() != 0) {
			user = (Btc_user) list.get(0);
			return user;
		}else{
			return user=null;
		}	
	}
	
	public List<Object> searchUserByid(int uid){
		List<Object> list = entityDao.createQuery("select u from Btc_user u where u.uid like '%"+uid+"%'");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public List<Object> searchUserByUname(String uname){
		List<Object> list = entityDao.createQuery("select u from Btc_user u where u.uname like '%"+uname+"%'");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public List<Object> searchUserByUusername(String uusername){
		List<Object> list = entityDao.createQuery("select u from Btc_user u where u.uusername like '%"+uusername+"%'");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public List<Object> getRechargeUser(){
		List<Object> list = entityDao.createQuery("select btc_user from Btc_user btc_user where btc_user.ustatus='1' order by btc_user.usdtime DESC");
		if (list.size() != 0) {
			return list;
		}else{
			return list=null;
		}	
	}
	
	public Map<Integer,Object> getUserMap(){
		Map<Integer,Object> usermap = new HashMap<Integer,Object>();
		Btc_user user = new Btc_user();
		List<Object> list = entityDao.createQuery("select btc_user from Btc_user btc_user");
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				user = (Btc_user)list.get(i);
				usermap.put(user.getUid(), user);
			}
			return usermap;
		}else{
			return null;
		}	
	}
	
	public Map<String,Object> getUserMap2(){
		Map<String,Object> usermap = new HashMap<String,Object>();
		Btc_user user = new Btc_user();
		List<Object> list = entityDao.createQuery("select btc_user from Btc_user btc_user");
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				user = (Btc_user)list.get(i);
				usermap.put(user.getUusername(), user);
			}
			return usermap;
		}else{
			return null;
		}	
	}
	
	public int countRechargeUser(){
		int num = 0;
		List<Object> list = entityDao.createQuery("select count(btc_user) from Btc_user btc_user where btc_user.ustatus='1'");
		if (list.size() != 0) {
			num = Integer.parseInt(list.get(0).toString());
			return num;
		}else{
			return num;
		}	
	}
	
	public List<Object> getUnRechargeUser(){
		List<Object> list = entityDao.createQuery("select btc_user from Btc_user btc_user where btc_user.ustatus='0' order by btc_user.usdtime DESC");
		if (list.size() != 0) {
			return list;
		}else{
			return list=null;
		}	
	}
	
	public List<Object> getManagerList(){
		List<Object> list = entityDao.createQuery("select btc_user from Btc_user btc_user where btc_user.urole='admin' order by btc_user.usdtime DESC");
		if (list.size() != 0) {
			return list;
		}else{
			return list=null;
		}	
	}
	
	public Btc_user getByUid(int uid){
		Btc_user user = new Btc_user();
		List<Object> list = entityDao.createQuery("select u from Btc_user u where u.uid='" + uid + "'");
		if (list.size() != 0) {
			user = (Btc_user) list.get(0);
			return user;
		}else{
			return user=null;
		}	
	}
	
	public List<Object> getAllUser(){
		List<Object> list = entityDao.createQuery("select btc_user from Btc_user btc_user order by btc_user.usdtime DESC");
		if (list.size() != 0) {
			return list;
		}else{
			return list=null;
		}	
	}
	
	public List<Object> getAllUser(int start,int count){
		List<Object> list = entityDao.createQuery("select btc_user from Btc_user btc_user order by btc_user.usdtime DESC",start,count);
		if (list.size() != 0) {
			return list;
		}else{
			return list=null;
		}	
	}
	
	public int countUnRechargeUser(){
		int num=0;
		List<Object> list = entityDao.createQuery("select count(btc_user) from Btc_user btc_user where btc_user.ustatus='0'");
		if (list.size() != 0) {
			num = Integer.parseInt(list.get(0).toString());
			return num;
		}else{
			return num;
		}	
	}
	
	public int countAllUser(){
		int num=0;
		List<Object> list = entityDao.createQuery("select count(btc_user) from Btc_user btc_user");
		if (list.size() != 0) {
			num = Integer.parseInt(list.get(0).toString());
			return num;
		}else{
			return num;
		}	
	}

	public void register_step1(Btc_user user) {
		entityDao.save(user);
	}
	
	public void register_step2(Btc_user user) {
		entityDao.update(user);
	}
	
	public void updateUser(Btc_user user) {
		entityDao.update(user);
	}
	
	public void deleteUser(Btc_user user) {
		entityDao.delete(user);
	}
}
