package com.sp.show;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("show.service")
public class ShowServiceimpl implements ShowService {
	
	@Autowired
	CommonDAO dao;

	@Override
	public List<Show> listShow(Map<String, Object> map) throws Exception {
		List<Show> list = null;
		try {
			list = dao.selectList("show.listShow", map);
			Map<String, Object> pMap = new HashMap<>();
			pMap.put("screenDate", map.get("screenDate"));
			for(Show s : list) {
				pMap.put("showInfoCode", s.getShowInfoCode());
				s.setShowTime(listShowTime(pMap));
				int seatCount = readSeatCount(s.getFacilityCode());
				s.setSeatCount(seatCount);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<String> listShowTime(Map<String, Object> map) throws Exception {
		List<String> showTimeList = null;
		try {
			showTimeList = dao.selectList("show.listShowTime", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return showTimeList;
	}
	
	public Show readShowInfo(Map<String, Object> map) throws Exception {
		Show dto = null;
		try {
			dto = dao.selectOne("show.readShowInfo", map);
			List<String> list = dao.selectList("show.listShowTime", map);
			dto.setShowTime(list);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int readSeatCount(int facilityCode) throws Exception {
		int count = 0;
		try {
			count = dao.selectOne("show.readSeatCount", facilityCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return count;
	}

	@Override
	public List<Ticket> listTicket(Map<String, Object> map) throws Exception {
		List<Ticket> list = null;
		try {
			list = dao.selectList("show.listTicket", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Integer> listSeat(Map<String, Object> map) throws Exception {
		List<Integer> list = null;
		try {
			list = dao.selectList("show.listSeat", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int readSstartCode(Map<String, Object> map) throws Exception {
		int sStartCode = 0;
		try {
			sStartCode = dao.selectOne("show.readSstartCode", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return sStartCode;
	}

	// 공연 예약 
	@Override
	public int insertShowBook(Map<String, Object> map) throws ShowInsertException, Exception{
		int result = 0;
		int showBookCode = 0;

		try {
			result = dao.insertData("show.insertShowBook", map);

			showBookCode = readShowBookCode(map);
			map.put("showBookCode", showBookCode);
			
			List<Integer> seatList = (List<Integer>) map.get("seatList");
			for(Integer i : seatList) {
				map.put("seatNum", i);
				insertShowBookInfo(map);
			}
		} catch (Exception e) {
			throw new ShowInsertException();
		}
		return result;
	}

	@Override
	public int readShowBookCode(Map<String, Object> map) throws Exception {
		int showBookCode = 0;
		try {
			showBookCode = dao.selectOne("show.readShowBookCode", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return showBookCode;
	}

	@Override
	public int insertShowBookInfo(Map<String, Object> map) throws Exception {
		int result = 0;

		result = dao.insertData("show.insertShowBookInfo", map);

		return result;
	}

	@Override
	public int readShowBookCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("show.readShowBookCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteShowBookInfo(int showBookCode) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("show.deleteShowBookInfo", showBookCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteShowBook(int showBookCode) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("show.deleteShowBook", showBookCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Show> listMyShow(int usersCode) throws Exception {
		List<Show> list = null;
		try {
			list = dao.selectList("show.listMyShow", usersCode);
			for(Show s : list) {
				List<Integer> seatNum = listMyShowSeat(s.getShowBookCode());
				s.setSeatNum(seatNum);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Integer> listMyShowSeat(int showBookCode) throws Exception {
		List<Integer> list = null;
		try {
			list = dao.selectList("show.listMyShowSeat", showBookCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public void readTicketCodeByPayCode(int payCode) throws Exception {
		List<Integer> ticketCodelist = null;
		try {
			ticketCodelist = dao.selectList("show.readTicketCodeByPayCode", payCode);
			for(Integer i : ticketCodelist) {
				List<Integer> showBookCodeList = readShowBookCodeByTicketCode(i);
				
				// 삭제
				for(Integer j : showBookCodeList) {
					deleteShowBookInfo(j);
					deleteShowBook(j);
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public List<Integer> readShowBookCodeByTicketCode(int ticketCode) throws Exception {
		List<Integer> list = null;
		try {
			list = dao.selectList("show.readShowBookCodeByTicketCode", ticketCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
