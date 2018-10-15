package com.sp.mypage;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.assets.Assets;
import com.sp.common.MyUtil;
import com.sp.magicpass.MagicPass;
import com.sp.member.SessionInfo;
import com.sp.show.Show;
import com.sp.show.ShowService;

@Controller("mypage.mybookController")
public class MybookController {
	@Autowired
	private MybookService service;
	
	@Autowired
	private ShowService sService; 

	@Autowired
	MyUtil myUtil;

	// 공연 리스트
	@RequestMapping(value = "/mypage/myBook", method = RequestMethod.GET)
	public String manageBook(@RequestParam(value = "tab", defaultValue = "magicpass") String tab,
			@RequestParam(value = "pageNo", defaultValue = "1") int page, Model model) {

		// model - tab
		model.addAttribute("tab", tab);
		model.addAttribute("pageNo", page);
		model.addAttribute("subMenu", "3");

		return ".four.menu3.mypage.myBook";
	}

	// 공연 리스트 - tab list
	@RequestMapping(value = "/mybook/{gubunCode}/list", method = RequestMethod.GET)
	public String showList(@PathVariable String gubunCode,
			@RequestParam(value = "tab", defaultValue = "magicpass") String tab,
			@RequestParam(value = "pageNo", defaultValue = "1") int current_page, HttpServletRequest req,
			HttpSession session, Model model) throws Exception {
		// tab : magicpass(1), guide(2), stage(3), facility(4)

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		Map<String, Object> map = new HashMap<>();
		
		int usersCode = (int) info.getUsersCode();
		map.put("usersCode", usersCode);
		
		String cp = req.getContextPath();

		if (gubunCode.equals("2")) { // 가이드 탭

			if (!gubunCode.equals("0")) {
				map.put("gubunCode", gubunCode);
			}			

			dataCount = service.dataCount(map);
			if (dataCount != 0)
				total_page = myUtil.pageCount(rows, dataCount);

			if (current_page > total_page)
				current_page = total_page;

			int start = (current_page - 1) * rows + 1;
			int end = current_page * rows;
			map.put("start", start);
			map.put("end", end);

			List<Mybook> list = service.listMybook(map);

			// 리스트의 번호
			int listNum, n = 0;
			Iterator<Mybook> it = list.iterator();
			while (it.hasNext()) {
				Mybook data = it.next();
				listNum = dataCount - (start + n - 1);
				data.setListNum(listNum);
				n++;
			}

			String paging = myUtil.paging(current_page, total_page);
			String articleUrl = cp + "/show/article";

			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("total_page", total_page);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("tab", tab);

			return "menu3/mypage/bookList";
		} else if (gubunCode.equals("3")) { // 무대공연 탭
			
			List<Show> list = sService.listMyShow(usersCode);
			if(list != null) {
				dataCount = ((List<Show>)sService.listMyShow(usersCode)).size();
			}
			
			if(dataCount != 0)
				total_page = myUtil.pageCount(rows, dataCount);
			
			if(current_page > total_page)
				current_page = total_page;
			
			int start = (current_page - 1) * rows + 1;
			int end = current_page * rows;
			map.put("start", start);
			map.put("end", end);
			
			
			String listUrl = cp + "/mybook/" + gubunCode + "/list";
			String paging = myUtil.pagingMethod(current_page, total_page, listUrl);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("current_page", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("total_page", total_page);
			
			return "menu3/mypage/showBookList";
			
		} else if (gubunCode.equals("4")) { // 편의시설 탭
			
			dataCount = service.assetsBookData(map);
			if(dataCount!=0) 
				total_page = myUtil.pageCount(rows, dataCount);
				
			if (current_page > total_page)
				current_page = total_page;
			
			int start = (current_page - 1) * rows + 1;
			int end = current_page * rows;
			map.put("start", start);
			map.put("end", end);
			
			List<Assets> list = service.assetsBookList(map);
			
			//기간 만료 처리
			//오늘날짜
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			String today = sdf.format(cal.getTime());  
			
			for(Assets dto:list) {
				String useDate = dto.getUseDate(); //사용예정일
				int Compare = useDate.compareTo(today);  
				 
				if((dto.getState()==0 || dto.getState()==2) && Compare<0 ) { //기간이 지나고 아직 예약(0)이거나 대여중(2)이면 기간만료 처리
					service.expireAssetsBook(dto.getBookCode()); //기간만료
				}
			}   
			
			  
			int listNum, n = 0;
			Iterator<Assets> it = list.iterator();
			while(it.hasNext()) {
				Assets data = it.next();
				listNum = dataCount - (start+n-1);
				data.setListNum(listNum);
				n++;
			}
			
			//String listUrl = cp + "/mybook/"+gubunCode+"/list";
			  
			String paging = myUtil.paging(current_page, total_page);  
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("page", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("total_page", total_page);
			
			return "menu3/mypage/assetsBookList"; 
			
		} else { //매직패스 탭
			
			dataCount = service.dataCountMagic(map);
			
			if (dataCount != 0)
				total_page = myUtil.pageCount(rows, dataCount);
			
			if (current_page > total_page)
				current_page = total_page;
			
			int start = (current_page - 1) * rows + 1;
			int end = current_page * rows;
			map.put("start", start);
			map.put("end", end);
			
			List<MagicPass> list = service.listMymagic(map);
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			Date now = dateFormat.parse(today);
			
			int timeStamp = Integer.parseInt(new SimpleDateFormat("HH").format(new Date()));
			
			for(MagicPass dto : list) {
				Date date = dateFormat.parse(dto.getMpDate());
				int compare = now.compareTo(date); 
				
				if(compare> 0) {
					dto.setState(0); //기간만료
				}else if(compare == 0 && timeStamp>dto.getMpTime()) {
					dto.setState(0);
				}else {
					dto.setState(1); //대기중
				}
			}
			
			String paging = myUtil.paging(current_page, total_page);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("page", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("total_page", total_page);
			
			return "menu3/mypage/mpBookList";

		}

	}

	@RequestMapping(value = "/mybook/delete")
	public String deleteBoook(@RequestParam(value = "lists[]") int[] lists) throws Exception {

		if (lists.length == 0) {
			// 예약레코드를 선택하지 않음
			return "redirect:/mypage/list";
		}

		for (int s : lists) {
			service.deleteGuideBook(s);
		}

		return "menu3/mypage/bookList";
	}
	
	
	// 무대공연 예약취소
	@RequestMapping(value = "/mybook/deleteShow")
	@ResponseBody
	public Map<String, Object> deleteShow(@RequestParam(value = "showBookCode[]") int[] showBookCode) throws Exception {
		for(int s : showBookCode) {
			sService.deleteShowBookInfo(s);
			sService.deleteShowBook(s);
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");
		return model;
	}
	
	
	//매직패스 예약취소
	@RequestMapping(value = "/mybook/deleteMagic")
	@ResponseBody
	public Map<String, Object> deleteMagicPass(long facilityCode, int mpTime, String mpDate, HttpSession session) throws Exception{
		String state = "success";
		
		Map<String, Object> paramMap = new HashMap<>();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		long usersCode = info.getUsersCode();
		
		paramMap.put("usersCode", usersCode);
		paramMap.put("facilityCode", facilityCode);
		paramMap.put("mpTime", mpTime);
		paramMap.put("mpDate", mpDate);
		int result = service.deleteMagicPass(paramMap);
		
		if(result==0) {
			state = "fail";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	//편의시설 예약 삭제
	@RequestMapping(value="/mybook/deleteAssets", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteAssets(Assets dto) throws Exception{
		
		String state = "true";
		
		int result = service.deleteAssetsBook(dto);    
		if(result==0)
			state = "false";
		
		Map<String, Object> model = new HashMap<String, Object>();	
		model.put("state", state);
		
		return model;
	}

}
