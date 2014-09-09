package com.mvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_manager;
import com.mvc.entity.Btc_user;

@Service
public class ManagerService {
	@Autowired
	private EntityDao entityDao;

	@Transactional
	public boolean vertify(String btc_manager_username, String btc_manager_password) {
		List<Object> list = entityDao.createQuery("select user from Btc_user user where user.uusername='" + btc_manager_username + "' and user.urole='admin'");
		Btc_user btc_manager = new Btc_user();
		if (list.size() != 0) {
			btc_manager = (Btc_user) list.get(0);
		}
		return btc_manager_password.equals(btc_manager.getUpassword());
	}
	
	public Btc_manager getByBtc_manager_username(String btc_manager_username){
		Btc_manager btc_manager = new Btc_manager();
		List<Object> list = entityDao.createQuery("select btc_manager from Btc_manager btc_manager where Btc_manager.Btc_manager_username='" + btc_manager_username + "'");
		if (list.size() != 0) {
			btc_manager = (Btc_manager) list.get(0);
			return btc_manager;
		}else{
			return btc_manager=null;
		}	
	}

	public void register_step1(Btc_manager btc_manager) {
		entityDao.save(btc_manager);
	}
}
