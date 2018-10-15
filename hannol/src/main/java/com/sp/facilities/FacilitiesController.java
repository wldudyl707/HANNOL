package com.sp.facilities;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

@Controller("facilities.facilitiesController")
public class FacilitiesController {
	
	@Autowired
	private FacilitiestService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/facilities/{pageName}")
	public String info(@PathVariable String pageName, @RequestParam(value = "page", defaultValue="1") int current_page, HttpSession session,
			HttpServletRequest req, Model model) throws Exception {
		
		Map<String, Object> paramMap = new HashMap<>();
		if(pageName.equals("baby")) {
			paramMap.put("gubunCode", 6);
			model.addAttribute("subMenu", "2");
			model.addAttribute("title", "유모차대여소");
		}else if(pageName.equals("locker")) {
			paramMap.put("gubunCode", 8);
			model.addAttribute("subMenu", "4");
			model.addAttribute("title", "물품보관함");
		}else if(pageName.equals("bathchair")) {
			paramMap.put("gubunCode", 9);
			model.addAttribute("subMenu", "3");
			model.addAttribute("title", "휠체어대여소");
		}else {
			paramMap.put("gubunCode", 10);
			model.addAttribute("subMenu", "1");
			model.addAttribute("title", "안내소");
		}
		
		String cp = req.getContextPath();

		int rows = 6;
		int total_page = 0;

		int dataCount = service.dataCount(paramMap);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;

		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<Facilitiest> list = service.facilitiestList(paramMap);
		String list_url = cp+"/facilities/"+pageName;
		String articleUrl = cp+"/facilities/"+pageName+"/article?page="+current_page;
	
		String paging = myUtil.paging(current_page, total_page, list_url);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		return ".four.menu7.list";
	}
	
	@RequestMapping(value = "/facilities/{pageName}/article")
	public String giftArticle(@PathVariable String pageName, @RequestParam(value = "page", defaultValue="1") String current_page, 
			int facilityCode, Model model) throws Exception{
		
		Facilitiest dto = service.readFacilitiest(facilityCode);
		if(dto == null) {
			return "redirect:/facilities/"+pageName+"?page="+current_page;
		}
		
		if(pageName.equals("baby")) {
			model.addAttribute("subMenu", "2");
		}else if(pageName.equals("locker")) {
			model.addAttribute("subMenu", "4");
		}else if(pageName.equals("bathchair")) {
			model.addAttribute("subMenu", "3");
		}else {
			model.addAttribute("subMenu", "1");
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", current_page);
		model.addAttribute("pageName", pageName);
		
		return ".four.menu7.article";
	}
}
