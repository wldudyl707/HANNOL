package com.sp.card; 

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("card.cardService")
public class CardServiceImpl implements CardService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("card.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Card> listCard(Map<String, Object> map) throws Exception {
		List<Card> list = null;
		try {
			list = dao.selectList("card.listCard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
