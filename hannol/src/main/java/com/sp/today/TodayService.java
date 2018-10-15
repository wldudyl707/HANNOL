package com.sp.today;

import java.util.List;
import java.util.Map;

public interface TodayService {
	public int dataCount(Map<String, Object> map);
	public List<Today> listToday();
	public List<Today> listToday2(Map<String, Object> map);

}
