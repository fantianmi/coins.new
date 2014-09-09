package com.mvc.service;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_paycard;

@Service
public class PaycardService {
	@Autowired
	private EntityDao entityDao;
	
	
	@Transactional
	public List<Object> getPaycard(String cardNum) {
		List<Object> list = entityDao.createQuery("SELECT card from Btc_paycard card where bank.uid='"+cardNum+"'");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public Btc_paycard getPaycardById(int id) {
		List<Object> list = entityDao.createQuery("SELECT card from Btc_paycard card where card.paycard_id='"+id+"'");
		if (list.size() != 0) {
			Btc_paycard card = (Btc_paycard)list.get(0);
			return card;
		}else{
			return null;
		}	
	}
	
	public List<Object> getPaycardByStatus(String status) {
		List<Object> list = entityDao.createQuery("SELECT card from Btc_paycard card where card.paycard_usestatus='"+status+"' " +
				"and card.paycard_user is null");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public void savePaycard(Btc_paycard paycard) {
		entityDao.save(paycard);
	}
	
	public void updatepaycard(Btc_paycard paycard) {
		entityDao.update(paycard);
	}
	
	public void deletepaycard(Btc_paycard paycard) {
		entityDao.delete(paycard);
	}
}
