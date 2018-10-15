package com.sp.faq;

import java.util.List;
import java.util.Map;

public interface FaqService {
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Faq> faqList(Map<String, Object> map) throws Exception;
}
