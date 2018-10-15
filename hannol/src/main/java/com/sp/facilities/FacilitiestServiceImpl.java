package com.sp.facilities;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("facilities.facilitiestService")
public class FacilitiestServiceImpl implements FacilitiestService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("facilities.dataCount", map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public List<Facilitiest> facilitiestList(Map<String, Object> map) throws Exception {
		List<Facilitiest> list = null;
		try {
			list = dao.selectList("facilities.facilitiesList", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Facilitiest readFacilitiest(int facilityCode) throws Exception {
		Facilitiest dto = null;
		try {
			dto = dao.selectOne("facilities.readFacilities", facilityCode);
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

}
