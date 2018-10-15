package com.sp.pay;

import java.util.List;
import java.util.Map;

public interface PayService {
	public List<MCoupon> couponCount(Map<String, Object> map) throws Exception;
	public int insertPay(Pay dto) throws Exception;
	public Pay readResult(int payCode) throws Exception;
	public int isCard(String cardCo) throws Exception;
	
	//paylist
	public List<Paylist> paylist(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Integer> useDate(Map<String, Object> map) throws Exception;
	public int deleteRefund(int payCode) throws Exception; 
	
}
