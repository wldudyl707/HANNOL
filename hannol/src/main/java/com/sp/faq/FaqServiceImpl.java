package com.sp.faq;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("service.faqService")
public class FaqServiceImpl implements FaqService {

	@Autowired
	private CommonDAO dao;

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("faq.dataCount", map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public List<Faq> faqList(Map<String, Object> map) throws Exception {
		List<Faq> list = null;
		try {
			list = dao.selectList("faq.faqList", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

}
