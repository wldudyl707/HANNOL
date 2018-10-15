package com.sp.assets;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.set.SynchronizedSortedSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.member.SessionInfo;

@Controller("assets.assetsController")
public class AssetsController {
	@Autowired
	AssetsService service;
	
	//편의시설 리스트
	@RequestMapping(value="/amenities/list", method=RequestMethod.GET)
	public String list(@RequestParam(value="msg", defaultValue="") String msg, Model model) throws Exception{
	
		if(msg.length() != 0) {
			model.addAttribute("msg", msg);
		}
		
		model.addAttribute("subMenu", "4");
		
		return ".four.menu8.amenities.list"; 
	}
	
	//예약
	@RequestMapping(value="/amenities/reservation", method=RequestMethod.GET)
	public String reservation(@RequestParam(value="gubunCode") int gubunCode,
			HttpServletRequest req,    
			HttpSession session,
			Assets dto,
			Model model) throws Exception{
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info==null) {
			model.addAttribute("message", "편의시설은 로그인 후 이용하실 수 있습니다.");
			return ".member.login";
		}
		
		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate startDay = LocalDate.now();
		LocalDate endDay = LocalDate.now().plusMonths(1);
		
		model.addAttribute("startDay", dateFormat.format(startDay));
		model.addAttribute("endDay", dateFormat.format(endDay));
		model.addAttribute("gubunCode", gubunCode);
		model.addAttribute("subMenu", "4");
		return ".four.menu8.amenities.calendar";
	}
	
	//선택한 날짜에 구매티켓이 존재하는지 확인
	@RequestMapping(value="/amenities/checkTicket")
	public String checkTicket(
			@RequestParam(value="gubunCode") int gubunCode, 
			@RequestParam(required=false, value="selectDay") String selectDay, 
			HttpSession session,
			RedirectAttributes redirectAttributes,
			Model model) throws Exception{
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("selectDay", selectDay);

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		long usersCode = info.getUsersCode();
		paramMap.put("usersCode", usersCode);
		
		int result = service.checkTicketCount(paramMap);
		if(result==0) {
			redirectAttributes.addAttribute("msg", "해당 날짜에 이용가능한 티켓이 없습니다. 구매 후 시도해 주세요");
			return "redirect:/amenities/list";
		}
		
		//사용가능 티켓 리스트
		List<Map<String, Object>> ticketList = service.ticketList(usersCode);
		
		List<Map<String, Object>> listTheme = service.listTheme();
		model.addAttribute("listTheme", listTheme);
		model.addAttribute("gubunCode", gubunCode);
		model.addAttribute("selectDay", selectDay);
		model.addAttribute("ticketList", ticketList);
		
		model.addAttribute("subMenu", "4"); 
		
		
		return ".four.menu8.amenities.reservation";
	}
	
	//테마 선택하면 대여소 검색의 자산검색 : AJAX-JSON
	@RequestMapping(value="/amenities/assetsSerach", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> assetsSerach(
			@RequestParam(value="themeCode") int themeCode,
			@RequestParam(value="gubunCode") String gubunCode,
			@RequestParam(value="useDate") String useDate) throws Exception{
		
		//사용가능한 대여소의 자산 검색
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("themeCode", themeCode);
		map.put("gubunCode", gubunCode);
		map.put("useDate", useDate);
		Map<String, Object> searchFacility = service.searchFacility(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("searchFacility", searchFacility); 
		
		return model;
	}
		
	//예약날짜 선택하면 입장권 검색 : AJAX-JSON
	@RequestMapping(value="/amenities/searchPayment", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> searchPayment(@RequestParam(value="useDate") String useDate,
			@RequestParam(value="usersCode") String usersCode) throws Exception{
	
		//입장권 검색
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("endDate", useDate); 
		map.put("usersCode", usersCode); 
		Map<String, Object> searchPayment2 = service.searchPayment2(map); 
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		model.put("searchPayment2", searchPayment2); 
 
		return model;
	}	
	
	//예약 추가
	@RequestMapping(value="/amenities/reservation", method=RequestMethod.POST)
	public String reservation(Assets dto, HttpSession session) throws Exception{
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			long usersCode = info.getUsersCode();
			dto.setUsersCode(usersCode);
			
			String tel1 = dto.getTel1();
			String tel2 = dto.getTel2();
			String tel3 = dto.getTel3(); 
			dto.setTel(tel1+"-"+tel2+"-"+tel3);
			
			service.insertAssetsBook(dto);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return "redirect:/mypage/myBook";   
	}
	
	//날짜 선택 폼 (연간이용권회원만, 한달이내에만 선택가능)
	@RequestMapping(value="/amenities/dayCalendar", method = RequestMethod.GET) 
	public String calendarForm(@RequestParam(value="gubunCode") String gubunCode,
			Model model) throws Exception{
	
		SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
		Calendar start = Calendar.getInstance(); //시작날짜(오늘 날짜)
		Calendar end = Calendar.getInstance(); //끝날짜(한달후까지만)
		end.add(Calendar.MONTH, +1); 
		
		String startDay = sdf.format(start.getTime());
		String endDay = sdf.format(end.getTime());  
		
		model.addAttribute("startDay", startDay);
		model.addAttribute("endDay", endDay);  
		model.addAttribute("gubunCode", gubunCode);  
		
		model.addAttribute("subMenu", "4");
		
		return ".four.menu8.amenities.calendar";  
	}
	
	//예약내역이 있는지 검색 AJAX-JSON
	@RequestMapping(value="/amenities/searchReservation", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchReservation(
			HttpSession session,
			@RequestParam(value="useDate") String useDate,
			@RequestParam(value="gubunCode") int gubunCode) throws Exception{

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		long usersCode = info.getUsersCode(); //유저 번호
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usersCode", usersCode);
		map.put("useDate", useDate);
		map.put("gubunCode", gubunCode); 
		
		String state = "notExistence";
		int result = service.searchReservation(map);
		
		if(result!=0) 
			state = "existence";    
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
	
	//보관함 리스트 
	@RequestMapping(value="/amenities/cubelist")
	public String cubelist(
			Model model,HttpServletRequest req,	HttpSession session) throws Exception{
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		long usersCode = info.getUsersCode();
		SimpleDateFormat formatter2 = new SimpleDateFormat ("yyyyMMdd");
		Date today = new Date();
		String date = formatter2.format(today);
		
		String day="종일";
		
		model.addAttribute("day", day);	
		model.addAttribute("date", date);	
		model.addAttribute("usersCode",usersCode);
		
		return ".four.menu8.amenities.cubelist"; 
	}
	
	//보관함 현황보기 
	@RequestMapping(value="/amenities/cube")
	public String cube(
			@RequestParam(value="day", defaultValue = "종일")String day, 
			@RequestParam(value="pickDate", defaultValue = "0")String pickDate, 
			Model model,HttpServletRequest req,	HttpSession session) throws Exception{
		//SessionInfo info = (SessionInfo) session.getAttribute("member");
		System.out.println(day+":::"+pickDate+":::");
		Map<String, Object> map = new HashMap<String, Object>();
		//long usersCode = info.getUsersCode();
		int daynum=0;

		if(day.equals("종일"))
			daynum=0;
		else if(day.equals("오후"))
			daynum=1;
		else
			daynum=2;
		
		map.put("daynum",daynum);
		map.put("pickDate", pickDate);
		
		System.out.println(daynum+":::::::::::::::::daynum");
		
		Assets dto = new Assets();
		List<Assets> list = service.listCube(map);
		
/*		int check=0;
		
		if(daynum==1) {
			check = service.checkAll(map);
		}
		if(check==1) {
			
		}*/
		
		/*if(list==null)
			return "/menu8/amenities/cube"; */
		
		dto.setLock1_1(0);
		dto.setLock1_2(0);
		dto.setLock1_3(0);
		dto.setLock1_4(0);
		dto.setLock1_5(0);
		dto.setLock1_6(0);
		dto.setLock1_7(0);
		dto.setLock1_8(0);
		dto.setLock1_9(0);
		dto.setLock1_10(0);
		
		dto.setLock2_1(0);
		dto.setLock2_2(0);
		dto.setLock2_3(0);
		dto.setLock2_4(0);
		dto.setLock2_5(0);
		dto.setLock2_6(0);
		dto.setLock2_7(0);
		dto.setLock2_8(0);
		dto.setLock2_9(0);
		dto.setLock2_10(0);
		
		dto.setLock3_1(0);
		dto.setLock3_2(0);
		dto.setLock3_3(0);
		dto.setLock3_4(0);
		dto.setLock3_5(0);
		dto.setLock3_6(0);
		dto.setLock3_7(0);
		dto.setLock3_8(0);
		dto.setLock3_9(0);
		dto.setLock3_10(0);
		
		dto.setLock4_1(0);
		dto.setLock4_2(0);
		dto.setLock4_3(0);
		dto.setLock4_4(0);
		dto.setLock4_5(0);
		dto.setLock4_6(0);
		dto.setLock4_7(0);
		dto.setLock4_8(0);
		dto.setLock4_9(0);
		dto.setLock4_10(0);
		
		dto.setLock5_1(0);
		dto.setLock5_2(0);
		dto.setLock5_3(0);
		dto.setLock5_4(0);
		dto.setLock5_5(0);
		dto.setLock5_6(0);
		dto.setLock5_7(0);
		dto.setLock5_8(0);
		dto.setLock5_9(0);
		dto.setLock5_10(0);
		
		for(Assets e:list) {
			if(e.getLockerNum()==1)
				dto.setLock1_1(1);
			else if(e.getLockerNum()==2)
				dto.setLock1_2(2);
			else if(e.getLockerNum()==3)
				dto.setLock1_3(3);
			else if(e.getLockerNum()==4)
				dto.setLock1_4(4);
			else if(e.getLockerNum()==5)
				dto.setLock1_5(5);
			else if(e.getLockerNum()==6)
				dto.setLock1_6(6);
			else if(e.getLockerNum()==7  )
				dto.setLock1_7(7);
			else if(e.getLockerNum()==8  )
				dto.setLock1_8(8);
			else if(e.getLockerNum()==9  )
				dto.setLock1_9(9);
			else if(e.getLockerNum()==10  )
				dto.setLock1_10(10);
			
			if(e.getLockerNum()==11  )
				dto.setLock2_1(11);
			else if(e.getLockerNum()==12  )
				dto.setLock2_2(12);
			else if(e.getLockerNum()==13  )
				dto.setLock2_3(13);
			else if(e.getLockerNum()==14  )
				dto.setLock2_4(14);
			else if(e.getLockerNum()==15  )
				dto.setLock2_5(15);
			else if(e.getLockerNum()==16  )
				dto.setLock2_6(16);
			else if(e.getLockerNum()==17  )
				dto.setLock2_7(17);
			else if(e.getLockerNum()==18  )
				dto.setLock2_8(18);
			else if(e.getLockerNum()==19  )
				dto.setLock2_9(19);
			else if(e.getLockerNum()==20  )
				dto.setLock2_10(20);
			
			if(e.getLockerNum()==21  )
				dto.setLock3_1(21);
			else if(e.getLockerNum()==22  )
				dto.setLock3_2(22);
			else if(e.getLockerNum()==23  )
				dto.setLock3_3(23);
			else if(e.getLockerNum()==24  )
				dto.setLock3_4(24);
			else if(e.getLockerNum()==25  )
				dto.setLock3_5(25);
			else if(e.getLockerNum()==26  )
				dto.setLock3_6(26);
			else if(e.getLockerNum()==27  )
				dto.setLock3_7(27);
			else if(e.getLockerNum()==28  )
				dto.setLock3_8(28);
			else if(e.getLockerNum()==29  )
				dto.setLock3_9(29);
			else if(e.getLockerNum()==30  )
				dto.setLock3_10(30);
			
			if(e.getLockerNum()==41  )
				dto.setLock4_1(41);
			else if(e.getLockerNum()==42  )
				dto.setLock4_2(42);
			else if(e.getLockerNum()==43  )
				dto.setLock4_3(43);
			else if(e.getLockerNum()==44  )
				dto.setLock4_4(44);
			else if(e.getLockerNum()==45  )
				dto.setLock4_5(45);
			else if(e.getLockerNum()==46  )
				dto.setLock4_6(46);
			else if(e.getLockerNum()==47  )
				dto.setLock4_7(47);
			else if(e.getLockerNum()==48  )
				dto.setLock4_8(48);
			else if(e.getLockerNum()==49  )
				dto.setLock4_9(49);
			else if(e.getLockerNum()==50  )
				dto.setLock4_10(50);
			
			if(e.getLockerNum()==51  )
				dto.setLock5_1(51);
			else if(e.getLockerNum()==52  )
				dto.setLock5_2(52);
			else if(e.getLockerNum()==53  )
				dto.setLock5_3(53);
			else if(e.getLockerNum()==54  )
				dto.setLock5_4(54);
			else if(e.getLockerNum()==55  )
				dto.setLock5_5(55);
			else if(e.getLockerNum()==56  )
				dto.setLock5_6(56);
			else if(e.getLockerNum()==57  )
				dto.setLock5_7(57);
			else if(e.getLockerNum()==58  )
				dto.setLock5_8(58);
			else if(e.getLockerNum()==59  )
				dto.setLock5_9(59);
			else if(e.getLockerNum()==60  )
				dto.setLock5_10(60);
			
			model.addAttribute("dto",dto);
			
		}
		
		return "/menu8/amenities/cube"; 
	}	
	
	//보관함 예약
	@RequestMapping(value="/amenities/reservationCube")
	public String cubeReservation(
			@RequestParam(value="day")String day,
			@RequestParam(value="pickDate")String pickDate,
			@RequestParam(value="tel")String tel,
			@RequestParam(value="idnum")int idnum,
			@RequestParam(value="name")String name,
			HttpServletRequest req,	HttpSession session, Model model) {

		Map<String, Object> map = new HashMap<String, Object>();

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		System.out.println("넘어온 idnum::::::"+idnum+":::::"+day+":::::"+pickDate+":::"+tel);
		
		map.put("pickDate", pickDate);
		
		  
			SimpleDateFormat formatter2 = new SimpleDateFormat ("yyyyMMdd");
			Date today = new Date();
			String date = formatter2.format(today);
			
			int daynum=0;

			if(day.equals("종일"))
				daynum=0;
			else if(day.equals("오후"))
				daynum=1;
			
			long usersCode = info.getUsersCode(); 
			System.out.println(usersCode+"현재 사용자");
			//접속한 사용자
			
			int lockerNum=0;
			
			for(int i=1; i<=50; i++) {
			
				if(idnum==i) {
					//themeCode=1;
					lockerNum=i;
				}
			}
	
			int themeCode=(idnum/10)+1;
			
			map.put("date", date);
			map.put("daynum", daynum);
			map.put("usersCode", usersCode);
			map.put("pickDate", pickDate);
			map.put("day", day);
			map.put("tel", tel);
			map.put("name", name);
			map.put("lockerNum", lockerNum);
			map.put("themeCode", themeCode);
			
			
			int assetsCode=service.assetsCode(map);
			
			map.put("assetsCode",assetsCode);
			
			//이용권 있는 회원만 보관함 예약 가능
			int goods = service.checkGoods(map);
			
			System.out.println(goods+"===============================");
			
			if(goods>15) {
				System.out.println("왓?!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				model.addAttribute("check","해당 날짜의 가능한 이용권이 없습니다.");
				model.addAttribute("day",day);
				model.addAttribute("date",pickDate);
				return "/menu8/amenities/cubelist"; 
			}
			
			//보관함 예약이 되어있는 회원 중복 방지
			int res = service.checkMulti(map);
			System.out.println(res+"))))))))))))))))))))))))))))))))))))");
			if(res!=0) {
				model.addAttribute("check","회원님은 예약된 보관함이 있습니다.");
				model.addAttribute("day",day);
				model.addAttribute("date",pickDate);
				return "/menu8/amenities/cubelist"; 
			}
			
			//예약시 같은 날짜, 같은 보관함 중복 방지
			  int result = service.checkUserDate(map);
			  System.out.println(lockerNum+"::::::::::");
				
				if(result==0) {
					model.addAttribute("day",day);
					model.addAttribute("date",pickDate);
					model.addAttribute("check","예약 완료!");
				}else {
					System.out.println("날짜 중복!!");
					model.addAttribute("check","날짜중복");
					model.addAttribute("day",day);
					model.addAttribute("date",pickDate);
					return "/menu8/amenities/cubelist"; 
				}
			
			System.out.println("insert전@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			//보관함 예약 insert
			service.insertCube(map);
/*			if(daynum==0) {
				service.insertCube1(map);
			}*/
			//코드 체크
			int code = service.selectCode(map);
			System.out.println(code+"::::::::::::::::::::::::");
			//보관함 상세 insert
			map.put("code", code);
			service.insertCube2(map);
			
			model.addAttribute("day",day);
			model.addAttribute("date",pickDate);
			
			
		return "/menu8/amenities/cubelist"; 
	}
	
	@RequestMapping(value="/amenities/cancel")
	public String cubeCancel(
			@RequestParam(value="pickDate")String pickDate,
			@RequestParam(value="day")String day,
			HttpServletRequest req,	HttpSession session, Model model) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		long usersCode = info.getUsersCode(); 
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("usersCode", usersCode);
		
		int code = service.cancelCode(map);
		System.out.println(code+":::::::::::::::::::::::");
		
		int code1 = service.cancelLocknum(code);
		
		System.out.println(code1+"::::::::::");
		
		int res = service.cancel(map);
		System.out.println(res+"!!!!!!!!!!!!!!!!!!!!!!!!!!");
		if(res==0) {
			model.addAttribute("check","취소실패");
			model.addAttribute("day",day);
			model.addAttribute("date",pickDate);
			return ".four.menu8.amenities.cubelist"; 

		}
		System.out.println(day+"::::::::::"+pickDate+":::::::::::");
		String alarm = "취소완료";
		model.addAttribute("check",alarm);
		model.addAttribute("day",day);
		model.addAttribute("date",pickDate);
		
		return ".four.menu8.amenities.cubelist"; 
	}
} 
