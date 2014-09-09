package com.mvc.service;


import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_order;
/**
 * 订单管理service
 * @author jack
 *
 */
@Service
public class OrderService {
	@Autowired
	private EntityDao entityDao;
	
	/**
	 * 根据币种id获取当前的卖单队列
	 * @param btc_stock_id
	 * @return
	 */
	public List<Object> getSellingOrders(int btc_stock_id){
		List<Object> list = entityDao.createQuery("select bo from Btc_order bo where bo.btc_stock_id="+btc_stock_id+" and bo.btc_order_status=0 and bo.btc_order_type='sell' ORDER BY bo.btc_order_price ASC , bo.btc_order_time ASC");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public Map<Integer,Object> getUserSellingOrdersToMapByUid(int uid){
		Map<Integer,Object> map = new HashMap<Integer,Object>();
		Btc_order order = new Btc_order();
		List<Object> list = entityDao.createQuery("select bo from Btc_order bo where bo.uid="+uid+" and bo.btc_order_status=0 and bo.btc_order_type='sell'");
		if (list.size() != 0) {
			for(int i=0;i<list.size();i++){
				order = (Btc_order)list.get(i);
				map.put(order.getBtc_stock_id(), order);
			}
		}
		return map;
	}
	
	/**
	 * 根据币种id获取当前的买单队列
	 * @param btc_stock_id
	 * @return
	 */
	public List<Object> getBuyingOrders(int btc_stock_id){
		List<Object> list = entityDao.createQuery("select bo from Btc_order bo where bo.btc_stock_id="+btc_stock_id+" and bo.btc_order_status=0 and bo.btc_order_type='bid' ORDER BY bo.btc_order_price DESC , bo.btc_order_time DESC");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	/**
	 * 
	 * @param btc_stock_id
	 * @return
	 */
	public List<Object> getAllOrders(){
		List<Object> list = entityDao.createQuery("select bo from Btc_order bo where bo.btc_order_status=0 ORDER BY bo.btc_order_price DESC , bo.btc_order_time DESC");
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	public int countRow() {
        List<Object> list = entityDao.createQuery("select count(bo.btc_order_id) from Btc_order bo where bo.btc_order_status=0");
        if (list.size() != 0) {
             if(list.get(0)!=null){
                  return Integer.parseInt(list.get(0).toString());
             }
        }
        return 0;
   }

	
	public List<Object> getAllOrders(int start,int end){
		List<Object> list = entityDao.createQuery("select bo from Btc_order bo where bo.btc_order_status=0 ORDER BY bo.btc_order_price DESC , bo.btc_order_time DESC",start,end);
		if (list.size() != 0) {
			return list;
		}else{
			return null;
		}	
	}
	
	/**
	 * 根据单号查询订单
	 * @param btc_order_id
	 * @return
	 */
	public Btc_order getByIdForBTCOrders(int btc_order_id){
		Btc_order btc_order = new Btc_order();
		List<Object> list = entityDao.createQuery("SELECT btc_order FROM Btc_order btc_order WHERE btc_order.btc_order_id='" + btc_order_id + "'");
		if (list.size() != 0) {
			btc_order = (Btc_order)list.get(0);
			return btc_order;
		}else{
			return btc_order=null;
		}	
	}
	
	public BigDecimal getCountOrderByStockIdandType(int stockid,String type){
		BigDecimal amount = new BigDecimal(0);
		List<Object> list = entityDao.createQuery("SELECT sum(btc_order.btc_order_amount) FROM Btc_order btc_order WHERE btc_order.btc_stock_id='"+stockid+"' and btc_order.btc_order_type='" + type + "' and btc_order.btc_order_status=0");
		if (list.size() != 0) {
			if(list.get(0)!=null){
				amount = new BigDecimal(list.get(0).toString());
			}
		}	
		return amount;
	}
	
	public BigDecimal totalOrder(int uid,String ordertype){
		String sql="SELECT sum(btc_order.totalorder) FROM Btc_order btc_order where btc_order.btc_order_status=0";
		if(uid!=0)sql=sql+" and btc_order.uid="+uid+"";
		if(ordertype.equals("bid"))sql=sql+" and btc_order.btc_order_type='"+ordertype+"'";
		else if(ordertype.equals("sell"))sql=sql+" and btc_order.btc_order_type='"+ordertype+"'";
		List<Object> list = entityDao.createQuery(sql);
		if(list.size()!=0)
			if(list.get(0)!=null)
				return new BigDecimal(list.get(0).toString());
		return new BigDecimal(0);
	}
	
  /**
   * 保存订单信息
   * @param btc_order
   */
	public void saveOrder(Btc_order btc_order) {
		entityDao.save(btc_order);
	}
	
	/**
	 * 更新订单信息
	 * @param btc_order
	 */
	public void updateOrder(Btc_order btc_order) {
		entityDao.update(btc_order);
	}
	
	/**
	 * 删除订单信息
	 * @param btc_order
	 */
	public void deleteOrder(Btc_order btc_order) {
		entityDao.delete(btc_order);
	}
}
