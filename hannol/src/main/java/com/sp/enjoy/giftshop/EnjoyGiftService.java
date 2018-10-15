package com.sp.enjoy.giftshop;

import java.util.List;
import java.util.Map;

public interface EnjoyGiftService {
	public int dataCount () throws Exception;
	public List<EnjoyGift> enjoyGiftList(Map<String, Object> map) throws Exception;
	public EnjoyGift readGift(int facilityCode) throws Exception;
}
