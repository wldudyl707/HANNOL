package com.sp.today;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

@Controller("todaypark.todayParkController")
public class TodayParkController {
	
	@Autowired
	private TodayService service;
	
	@Autowired
	private MyUtil myUtil;
	
/*	@RequestMapping(value="/todayPark/rides")
	public String info(Model model) throws Exception {
		model.addAttribute("subMenu", "1");
		return ".four.menu4.todayPark.info";
	}*/
	
	@RequestMapping(value="/todayPark/recommand")
	public String recommand(Model model) throws Exception {
		model.addAttribute("subMenu", "2");
		return ".four.menu4.todayPark.recommand";
	}

	// 오늘의 공연
	@RequestMapping(value="/todayPark/show")
	public String todayShow(Model model) throws Exception {
		model.addAttribute("subMenu", "3");
		return ".four.menu4.todayPark.todayShow";
	}
	
	@RequestMapping(value="/todayPark/rides")
	public String list(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model) throws Exception {
	
		List<Today> list = service.listToday();
		
		String tab = "princess";
		String orderby = "waiting";
		
		model.addAttribute("orderby", orderby);
	    model.addAttribute("listToday", list);
		model.addAttribute("page", current_page);
		model.addAttribute("tab", tab);
	    
		System.out.println("**********************list******************************");

		return ".four.menu4.todayPark.list";
	}
	
	@RequestMapping(value="/todayPark/subList")
	public String subList(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="tab", defaultValue="princess") String tab,
			@RequestParam(value="gubunCode", defaultValue="0") int code,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@RequestParam(value="orderby", defaultValue="waiting") String orderby,
			HttpServletRequest req,
			Model model) throws Exception {
		
		System.out.println("**********************SUBlist 입장******************************");
		String cp = req.getContextPath();
		
		System.out.println(code+":::::::::::::::::code:::");
		System.out.println(orderby+":::::::::::::orderby");
		
		//현재시간 구하기
		//SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		
		SimpleDateFormat formatter2 = new SimpleDateFormat ("yyyyMMdd");
		SimpleDateFormat formatter3 = new SimpleDateFormat ("kk");
		
		Date today = new Date();
		String date = formatter2.format(today);
		
		Calendar cal = Calendar.getInstance();
		
		String chh = null;
		chh = formatter3.format(cal.getTime());
		int hh = Integer.parseInt(chh);
		System.out.println("시간::::::::"+hh);
		/////////////////////////////////////////////////////////////////////////////////
		int rows = 9;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		  // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);
        map.put("yyyymmdd", date);
		map.put("hh",hh-1);
		map.put("code",code);
		map.put("orderby",orderby);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;

		map.put("start", start);
		map.put("end", end);
		
		
		List<Today> list2 = service.listToday2(map);	
        
		String query = "";
        String articleUrl = cp+"/today/article?page=" + current_page;
        if(searchValue.length()!=0) {
        	query = "searchKey=" +searchKey + 
        	             "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(query.length()!=0) {
        	articleUrl = cp+"/today/article?page=" + current_page + "&"+ query;
        }
		
        String paging = myUtil.paging(current_page, total_page);
        
        model.addAttribute("list", list2);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		System.out.println("**********************SUBlist 퇴장******************************");
	    
		return "/menu4/todayPark/subList";
	}
	
}
