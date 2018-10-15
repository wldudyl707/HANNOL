package com.sp.enjoy.giftshop;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("giftshop.enjoyGiftService")
public class EnjoyGiftServiceImpl implements EnjoyGiftService {

	@Autowired
	private CommonDAO dao;

	@Override
	public int dataCount() throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("enjoygift.dataCount");
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public List<EnjoyGift> enjoyGiftList(Map<String, Object> map) throws Exception {
		List<EnjoyGift> list = null;
		try {
			list = dao.selectList("enjoygift.giftshopList", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public EnjoyGift readGift(int facilityCode) throws Exception {
		EnjoyGift dto = null;
		try {
			dto = dao.selectOne("enjoygift.readGift", facilityCode);
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

}
