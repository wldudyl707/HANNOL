package com.sp.facilities;

import java.util.List;
import java.util.Map;

public interface FacilitiestService {
	public int dataCount (Map<String, Object> map) throws Exception;
	public List<Facilitiest> facilitiestList(Map<String, Object> map) throws Exception;
	public Facilitiest readFacilitiest(int facilityCode) throws Exception;
}
