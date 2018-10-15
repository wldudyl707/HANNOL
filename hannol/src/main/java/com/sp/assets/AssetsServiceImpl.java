package com.sp.assets;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service
public class AssetsServiceImpl implements AssetsService{
	@Autowired
	CommonDAO dao;

	@Override
	public List<Map<String, Object>> listTheme(){
		List<Map<String, Object>> list = null;
		
		try {
			list = dao.selectList("assets.listTheme");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public List<Map<String, Object>> searchPayment(long num){
		List<Map<String, Object>> list = null;
		
		try {
			list = dao.selectList("assets.searchPayment", num);  
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public Map<String, Object> searchPayment2(Map<String, Object> data){
		Map<String, Object> map = null;
		
		try {
			map = dao.selectOne("assets.searchPayment2", data);
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return map;
	}

	@Override
	public Map<String, Object> searchFacility(Map<String, Object> data){
		Map<String, Object> map = null;
		
		try {
			map = dao.selectOne("assets.searchFacility", data);
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return map;
	}

	@Override
	public int insertAssetsBook(Assets dto){
		int result = 0;
		
		try {
			result = dao.insertData("assets.insertAssetsBook", dto);
		} catch (Exception e) {
			
		}
		return result;
	}

	@Override
	public int searchReservation(Map<String, Object> map){
		int result = 0;
		
		try {
			result = dao.selectOne("assets.searchReservation", map);
			
		} catch (Exception e) {
			System.out.println(e.toString()); 
		}
		return result;  
	}

	@Override
	public int checkTicketCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("assets.checkTicketCount", map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public int searchTicket(long num) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("assets.searchTicket", num);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> ticketList(long num) {
		List<Map<String, Object>> list = null;
		
		try {
			list = dao.selectList("assets.ticketList", num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Assets> listCube(Map<String, Object> map) {
		List<Assets> list = null;
		try {
			list = dao.selectList("assets.listCube", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int checkUserDate(Map<String, Object> map) {
		//중복되는 날짜가 없으면
		int result=0;
		
		try {
			result=dao.selectOne("assets.checkUserDate", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int insertCube(Map<String, Object> map) {
		int result=0;
		
		try {
			result= dao.insertData("assets.insertCube",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
/*	
	@Override
	public int insertCube1(Map<String, Object> map) {
		int result=0;
		
		try {
			result= dao.insertData("assets.insertCube1",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}*/

	@Override
	public int insertCube2(Map<String, Object> map) {
		int result=0;
		
		try {
			result= dao.insertData("assets.insertCube2",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int selectCode(Map<String, Object> map) {
		int code=0;
		
		try {
			code = dao.selectOne("assets.checkCode",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return code;
	}

	@Override
	public int checkMulti(Map<String, Object> map) {
		int res =0 ;
		
		try {
			res = dao.selectOne("assets.checkMulti", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return res;
	}
/*
	@Override
	public int checkAll(Map<String, Object> map) {
		int res =0 ;
		
		try {
			res = dao.selectOne("assets.checkAll", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return res;
	}*/

	@Override
	public int checkGoods(Map<String, Object> map) {
		int res =0 ;
		
		try {
			res = dao.selectOne("assets.checkGoods", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
			System.out.println(res+":::::::::::::");
		return res;
	}

	@Override
	public int cancel(Map<String, Object> map) {
		int res =0 ;
		
		try {
			res = dao.deleteData("assets.cancel", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int cancelLocknum(int code) {
		int res =0 ;
		
		try {
			res = dao.deleteData("assets.cancelLocknum", code);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}
	
	@Override
	public int cancelCode(Map<String, Object> map) {
		int code=0;
		
		try {
			code = dao.selectOne("assets.cancelCode",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return code;
	}

	@Override
	public Assets getCubeBookCancelDay(int payCode) {
		Assets dto = new Assets();
		
		try {
			dto=dao.selectOne("assets.getCubeBookCancelDay", payCode);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return dto;
	}
	
	@Override
	public int okTicketIfPayCancledCube(int payCode) {
		int result = 0;
		try {
			result = dao.selectOne("assets.okTicketIfPayCancledCube", payCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int payBookCode(int payCode) {
		int result = 0;
		try {
			result = dao.selectOne("assets.payBookCode", payCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	@Override
	public int paydeleteLocker(int cubepayCode) {
		int res =0 ;
		
		try {
			res = dao.deleteData("assets.paydeleteLocker", cubepayCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}
	
	@Override
	public int paydeleteBook(int cubepayCode) {
		int res =0 ;
		
		try {
			res = dao.deleteData("assets.paydeleteBook", cubepayCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int assetsCode(Map<String, Object> map) {
		int code = 0;
		try {
			code=dao.selectOne("assets.assetsCode", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return code;
	}

}
