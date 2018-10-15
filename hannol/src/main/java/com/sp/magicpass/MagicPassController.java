package com.sp.magicpass;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("magicpass.MagicPassController")
public class MagicPassController {
	
	@Autowired
	private MagicPassService service;

	@Autowired
	private MyUtil myUtil;
	

	@RequestMapping(value="/magicPass/rides")
	public String info(Model model) throws Exception {
		
		return ".four.menu5.magicPass.info";
	}
	
	@RequestMapping(value="/magicPass/booking")
	public String masicpassBooking(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "searchKey", defaultValue = "name") String searchKey,
			@RequestParam(value = "searchValue", defaultValue = "") String searchValue,
			@RequestParam(value = "thema", defaultValue="0") int thema,
			HttpSession session, 
			HttpServletRequest req,
			RedirectAttributes redirectAttributes, 
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		long usersCode = info.getUsersCode();
		int result = service.checkTicket(usersCode);
		if(result==0) {
			redirectAttributes.addFlashAttribute("msg", "오늘 사용가능한 이용권이 없습니다.");
			return "redirect:/magicPass/rides";
		}
		
		Map<String, Object> map = new HashMap<>();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("themeCode", thema);
		
		dataCount = service.dataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<MagicPass> list = service.listRides(map);
		
		String query = "";
		String listUrl = cp + "/magicPass/booking";
		
		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		if (query.length() != 0) {
			listUrl += "?"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("thema", thema);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("subMenu", "2");
		
		return ".four.menu5.magicPass.booking";
	}
	
	@RequestMapping(value="/magicPass/getReservation", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getReservation(@RequestParam(value="facilityCode") long facilityCode, HttpSession session) throws Exception{
		Map<String, Object> model = new HashMap<>();
		
		List<MagicPass> list = service.listReservation(facilityCode);
		for(MagicPass dto : list) {
			if(dto.getCnt() > 100) {
				dto.setState(1); //예약불가
			}else {
				dto.setState(0); //예약가능
			}
			
		}
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		long usersCode = info.getUsersCode();
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("today", today);
		paramMap.put("usersCode", usersCode);
		
		List<MagicPass> ticketList = service.getTicket(paramMap);
		String timeStamp = new SimpleDateFormat("HH").format(new Date());
		
		model.put("list", list);
		model.put("ticketList", ticketList);
		model.put("timeStamp", timeStamp);
		
		return model; 
	}
	
	@RequestMapping(value="/magicPass/reservation", method=RequestMethod.POST)
	public String submitReservation(MagicPass dto,
			HttpSession session,
			RedirectAttributes redirectAttributes) throws Exception{
		
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		dto.setMpDate(today);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		dto.setUsersCode(info.getUsersCode());
		
		int result = service.insertReservation(dto);
		if(result==0) {
			redirectAttributes.addFlashAttribute("msg", "이용권으로 매직패스 예약은 이용권당, 한 시간당 하나만 예약이 가능합니다.");
			return "redirect:/magicPass/booking";
		}
		
		redirectAttributes.addFlashAttribute("msg", "예약 되었습니다.");
		
		return "redirect:/magicPass/booking";
	}		
}
