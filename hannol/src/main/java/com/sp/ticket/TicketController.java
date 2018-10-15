package com.sp.ticket;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.member.SessionInfo;

@Controller("ticket.ticketController")
public class TicketController {
	
	@Autowired
	private TicketService service;
	
	@RequestMapping(value="/ticket/list")
	public String ticketList(Model model) throws Exception{
		List<Ticket> list = service.listTicket();
		
		List<Ticket> oneDay = new ArrayList<>();
		List<Ticket> after = new ArrayList<>();
		List<Ticket> big = new ArrayList<>();
		List<Ticket> years = new ArrayList<>();
		
		for(Ticket dto : list) {
			if(dto.getGubunCode()==3) {
				oneDay.add(dto);
			}else if(dto.getGubunCode()==5) {
				after.add(dto);
			}else if(dto.getGubunCode()==7) {
				big.add(dto);
			}else if(dto.getGubunCode()==8) {
				years.add(dto);
			}
		}
		
		model.addAttribute("oneDay", oneDay);
		model.addAttribute("after", after);
		model.addAttribute("big", big);
		model.addAttribute("years", years);
		
		model.addAttribute("subMenu", "4");
		return ".four.menu1.ticket.ticket";
	}
	
	@RequestMapping(value="/reservation/ticket")
	public String ticketSelect(@RequestParam(value="msg", defaultValue="") String msg, Model model) throws Exception{
		model.addAttribute("msg", msg);
		return ".four.menu8.ticket.ticket";
	}
	
	@RequestMapping(value="/reservation/dayCalendar")
	public String dayCalendar(Model model) throws Exception{
		
		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate startDay = LocalDate.now();
		LocalDate endDay = LocalDate.now().plusMonths(1);
		
		model.addAttribute("startDay", dateFormat.format(startDay));
		model.addAttribute("endDay", dateFormat.format(endDay));
		
		return ".four.menu8.ticket.calendar";
	}
	
	@RequestMapping(value="/reservation/yearTicket")
	public String ticketYear(HttpSession session, Model model, RedirectAttributes redirectAttributes) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		long usersCode = info.getUsersCode();
		String birth = service.checkUserBirth(usersCode);
		
		if(birth != null) {
			int year = Integer.parseInt(birth.split("-")[0]);
			int month = Integer.parseInt(birth.split("-")[1]);
			int day = Integer.parseInt(birth.split("-")[2]);
			
			Calendar current = Calendar.getInstance();
	        int currentYear  = current.get(Calendar.YEAR);
	        int currentMonth = current.get(Calendar.MONTH) + 1;
	        int currentDay   = current.get(Calendar.DAY_OF_MONTH);

	        List<Ticket> ticket = service.listYearTicket();
	        
	        int age = currentYear - year;
	        if (month * 100 + day > currentMonth * 100 + currentDay)  
	            age--;
	        
	        if(ticket==null) {
	        	redirectAttributes.addFlashAttribute("msg", "판매중인 연간 이용권이 없어서 구매가 불가능 합니다. 죄송합니다.");
	        	return "redirect:/reservation/ticket";
	        }
	        
	        if(age>=20) {
	        	model.addAttribute("ticket", ticket.get(0));
	        }else {
	        	
	        	if(ticket.size()<2) {
	        		redirectAttributes.addAttribute("msg", "판매중인 소인 연간 이용권이 없어서 구매가 불가능 합니다. 죄송합니다.");
		        	return "redirect:/reservation/ticket";
	        	}
	        	
	        	model.addAttribute("ticket", ticket.get(1));
	        }
	        
	        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        LocalDate startDate = LocalDate.now();
			LocalDate endDate = LocalDate.now().plusYears(1);
			
			model.addAttribute("startDate", dateFormat.format(startDate));
			model.addAttribute("endDate", dateFormat.format(endDate));
			
		}
		
		return ".four.menu8.ticket.yearTicket";
	}
	
	
	@RequestMapping(value="/reservation/checkYearTicket")
	@ResponseBody
	public Map<String, Object> checkYearTicket(HttpSession session) throws Exception{
		Map<String, Object> map = new HashMap<>();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info == null) {
			map.put("state", "fail");
			return  map;
		}
		
		long usersCode = info.getUsersCode();
		map.put("usersCode", usersCode);
		
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		map.put("today", today);
		
		int result = service.checkYearTicket(map);
		
		Map<String, Object> model = new HashMap<>();
		if(result!=0) {
			model.put("state", "already");
			return model;
		}
		
		model.put("state", "true");
		return model;
	}
	
	@RequestMapping(value="/reservation/dayTicket")
	public String ticketDay(String day, int limit, Model model) throws Exception{
		List<Ticket> list = service.listTicket();
		
		List<Ticket> oneDay = new ArrayList<>();
		List<Ticket> oneDayMasic = new ArrayList<>();
		List<Ticket> after = new ArrayList<>();
		List<Ticket> afterMasic = new ArrayList<>();
		List<Ticket> big = new ArrayList<>();
				
		for(Ticket dto : list) {
			if(dto.getGubunCode()==3) {
				oneDay.add(dto);
			}else if(dto.getGubunCode()==4) {
				oneDayMasic.add(dto);
			}else if(dto.getGubunCode()==5) {
				after.add(dto);
			}else if(dto.getGubunCode()==6) {
				afterMasic.add(dto);
			}else if(dto.getGubunCode()==7) {
				big.add(dto);
			}
		}
		
		model.addAttribute("oneDay", oneDay);
		model.addAttribute("oneDayMasic", oneDayMasic);
		model.addAttribute("after", after);
		model.addAttribute("afterMasic", afterMasic);
		model.addAttribute("big", big);
		model.addAttribute("day", day);
		model.addAttribute("limit", limit);
		
		return ".four.menu8.ticket.dayTicket";
	}
	
	@RequestMapping(value="/reservation/checkUser")
	@ResponseBody
	public Map<String, Object> ticketCheckUser(Map<String, Object> map, String day, HttpSession session) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> model = new HashMap<>();
		if(info==null) {
			model.put("state", "fail");
			return model;
		}
		
		String timeStamp = new SimpleDateFormat("HH").format(new Date());
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		
		Date selectDay = dateFormat.parse(day);
		Date now = dateFormat.parse(today);
		
		int compare = now.compareTo(selectDay);
		
		if(Integer.parseInt(timeStamp)>20 && compare>=0) {
			model.put("state", "close");
			return model;
		}
		
		long userCode = info.getUsersCode();
		map.put("usersCode", userCode);
		map.put("day", day);
		
		int result = service.checkReservation(map);
		model.put("limit", result);
		
		return model;
	}
}
