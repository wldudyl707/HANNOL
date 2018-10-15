package com.sp.faq;

import java.net.URLDecoder;
import java.net.URLEncoder;
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

@Controller("faq.faqController")
public class FaqController {
	
	@Autowired
	private FaqService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/faq/list")
	public String faq(
			@RequestParam(value="tab", defaultValue="all") String tab,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@RequestParam(value="page", defaultValue="1") String page,
			Model model) throws Exception {

		model.addAttribute("tab", tab);
		model.addAttribute("page", page);
		model.addAttribute("searchValue", searchValue);
		
		model.addAttribute("subMenu", "3");
		return ".four.menu2.faq.faq";
	}
	
	@RequestMapping(value="/faq/ajaxList")
	public String faqAjaxList(
			@RequestParam(value="tab", defaultValue="all") String tab,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model) throws Exception{
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchValue", searchValue);
		map.put("tab", tab);
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		map.put("start", start);
		map.put("end", end);

		List<Faq> list = service.faqList(map);
		
		String query = "";
		if(searchValue.length() != 0) {
			query = "searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		String paging = myUtil.paging(current_page, total_page);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("query", query);
		
		return "/menu2/faq/list-body";
	}
}
