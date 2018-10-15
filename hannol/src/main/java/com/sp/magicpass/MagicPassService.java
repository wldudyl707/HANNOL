package com.sp.magicpass;

import java.util.List;
import java.util.Map;

public interface MagicPassService {
	public int checkTicket(long usersCode) throws Exception;
	public List<MagicPass> listRides(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<MagicPass> listReservation(long facilityCode) throws Exception;
	public List<MagicPass> getTicket(Map<String, Object> map) throws Exception;
	public int insertReservation(MagicPass dto) throws Exception;
}
