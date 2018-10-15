package com.sp.coupon;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtilGeneral;
import com.sp.member.SessionInfo;

@Controller("coupon.couponcontroller")
public class CouponController {
	@Autowired
	CouponService service;

	@Autowired
	MyUtilGeneral util;

	@RequestMapping(value = "/mypage/couponList")
	public String couponList(@RequestParam(value = "page", defaultValue = "1") String page,
			@RequestParam(value = "thema", defaultValue = "0") String thema, Model model) throws Exception {


		model.addAttribute("page", page);
		model.addAttribute("thema", thema);
		model.addAttribute("subMenu", "1");
		

		return ".four.menu3.mypage.couponList";
	}

	@RequestMapping(value = "/mypage/ajaxCouponList")
	public String aJaxListForm(@RequestParam(value = "page", defaultValue = "1") int current_page, int couponType,
			HttpSession session, HttpServletRequest req, Model model) throws Exception {
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		Map<String, Object> map = new HashMap<>();
		map.put("usersCode", info.getUsersCode());

		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		Date currentTime = new Date();
		String now = fm.format(currentTime);

		if (couponType == 0) {
			map.put("thema", "gift");
			map.put("date", "useDate");
			map.put("code", "giftCode");
		} else {
			map.put("thema", "ticket");
			map.put("date", "startDate");
			map.put("code", "ticketCode");
		}

		dataCount = service.dataCount(map);

		if (dataCount != 0) {
			total_page = util.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<Coupon> list = null;
		list = service.ajaxGiftCouponList(map);

		if (list.size() > 0) {
			int listNum, n = 0;
			Iterator<Coupon> it = list.iterator();
			while (it.hasNext()) {
				Coupon data = it.next();
				listNum = dataCount - (start + n - 1);
				data.setListNum(listNum);

				if (list.get(n).getEndDate() != null) {
					int compare = fm.parse(now).compareTo(fm.parse(list.get(n).getEndDate()));
					if (compare > 0)
						list.get(n).setStartDate("0001-01-01");
				}
				n++;
			}
		}

		String paging = util.paging(current_page, total_page);

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("couponType", couponType);
		model.addAttribute("now", now);

		return "/menu3/mypage/couponList-body";

	}

	@RequestMapping(value = "/mypage/ajaxCouponUse", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> price(@RequestParam(value = "couponCode") int couponCode,
			@RequestParam(value = "gubunCode") int gubunCode,
			@RequestParam(value = "page", defaultValue = "1") String page,
			@RequestParam(value = "thema", defaultValue = "0") int thema) throws Exception {

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		Date date = new Date();
		String curDate = format.format(date);

		Coupon dto = null;
		int result = 0;
		if (thema == 0) {
			dto = service.readGiftCoupon(couponCode);

			dto.setUseDate(curDate);

			result = service.updateGiftCoupon(dto);
		} else {
			if (gubunCode == 8) {
				Map<String, Object> map = new HashMap<>();
				map.put("ticketCode", couponCode);
				map.put("curDate", curDate);
				service.insertTicketHistory(map);
			} else {
				dto = service.readTicketCoupon(couponCode);
				result = service.updateTicketCoupon(dto);
			}
		}

		Map<String, Object> model = new HashMap<>();
		if (result != 1) {
			return model;
		}

		if (thema == 0) {
			service.updateGoodsCount(dto.getGoodsCode());
			service.goodsCount(dto.getGoodsCode());
		}

		model.put("page", page);
		model.put("thema", thema);

		return model;
	}

	@RequestMapping(value = "/mypage/rankCouponList")
	public String rankCouponList(Model model) throws Exception {

		List<Grade> glist = service.gradelist();
		model.addAttribute("glist", glist);
		model.addAttribute("subMenu", "4");
		
		return ".four.menu3.mypage.rankCouponList";
	}

	@RequestMapping(value = "/mypage/rankCouponListBody")
	public String rankCouponListBody(
			@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam(value = "order", defaultValue = "recent") String order,
			HttpSession session,
			Model model) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		long usersCode = info.getUsersCode();
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("usersCode", usersCode);
		paramMap.put("order", order);
		
		int rows = 10;
		int total_page = 0;
		int dataCount = service.dataCountRank(paramMap);
		
		if (dataCount != 0) {
			total_page = util.pageCount(rows, dataCount);
		}
		
		if (total_page < currentPage) {
			currentPage = total_page;
		}
		
		int start = (currentPage - 1) * rows + 1;
		int end = currentPage * rows;
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<LankCoupon> list = service.lankCouponList(paramMap);
		String paging = util.paging(currentPage, total_page);
		
		SimpleDateFormat format  = new SimpleDateFormat("yyyy-MM-dd");
		Date today = format.parse(format.format(new Date()));
		
		for(LankCoupon dto : list) {
			Date endDate = format.parse(dto.getEndDate());
			int compare = today.compareTo(endDate);
			if(compare>0) {
				dto.setState(2);
			}
		}
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "/menu3/mypage/rankCouponList-body";
	}
}
