package com.sp.enjoy;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("rides.ridesServiceImple")
public class EnjoyServiceImpl implements EnjoyService{

	@Autowired
	private CommonDAO  dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("enjoy.dataCount", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public List<Enjoy> listEnjoy2(Map<String, Object> map) {
		List<Enjoy> list = null;
		
		try {
			list = dao.selectList("enjoy.listEnjoyCal", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public List<Enjoy> listEnjoy() {
		List<Enjoy> list = null;
		
		try {
			list = dao.selectList("enjoy.listEnjoy2");
			System.out.println("테스트를 어떻게 해보지...................");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Enjoy dialogEnjoy(int code) {
		Enjoy dto = new Enjoy();
		
		try {
			dto = dao.selectOne("enjoy.dialogEnjoy",code);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

}
