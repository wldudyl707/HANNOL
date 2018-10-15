package com.sp.assets;

import java.util.List;
import java.util.Map;

public interface AssetsService {
	public List<Map<String, Object>> listTheme();
	public List<Map<String, Object>> searchPayment(long num);
	public Map<String, Object> searchPayment2(Map<String, Object> map);
	public Map<String, Object> searchFacility(Map<String, Object> map);
	
	public int insertAssetsBook(Assets dto);
	
	public int searchReservation(Map<String, Object> map);
	
	/*지영*/
	public int checkTicketCount(Map<String, Object> map) throws Exception;
	
	public int searchTicket(long usersCode) throws Exception;
	public List<Map<String, Object>> ticketList(long usersCode) throws Exception;
	
	
	/*보관함*/
	public List<Assets> listCube(Map<String, Object> map);
	public int checkUserDate(Map<String, Object> map);
	public int insertCube(Map<String, Object> map);
	//public int insertCube1(Map<String, Object> map);
	public int insertCube2(Map<String, Object> map);
	public int selectCode(Map<String, Object> map);
	public int cancelCode(Map<String, Object> map);
	public int checkMulti(Map<String, Object> map);
	//public int checkAll(Map<String, Object> map);
	public int checkGoods(Map<String, Object> map);
	public int cancel(Map<String, Object> map);
	public int cancelLocknum(int code);
	public Assets getCubeBookCancelDay(int payCode);
	public int okTicketIfPayCancledCube(int payCode);
	public int payBookCode(int payCode);
	public int paydeleteLocker(int cubepayCode);
	public int paydeleteBook(int cubepayCode);
	public int assetsCode(Map<String, Object> map);
}
