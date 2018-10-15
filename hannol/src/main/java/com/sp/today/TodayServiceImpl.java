package com.sp.today;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("today.todayServiceImpl")
public class TodayServiceImpl implements TodayService{

	@Autowired
	private CommonDAO  dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("today.dataCount", map);
		} catch (Exception e) {
		}
		
		return result;
	}
	
	@Override
	public List<Today> listToday2(Map<String, Object> map) {
		List<Today> list = null;
		
		try {
			list = dao.selectList("today.listTodayCal", map);
			
			for(Today e : list) {
				e.setWaiting(-1);
				int facilityCode = e.getFacilityCode();
				map.put("facilityCode", facilityCode);
				Integer waiting = dao.selectOne("today.calcul", map);
				if(waiting!= null) {
					e.setWaiting(waiting);
				}
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public List<Today> listToday() {
		List<Today> list = null;
		
		try {
			list = dao.selectList("today.listToday2");
			System.out.println("테스트를 어떻게 해보지...................");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
