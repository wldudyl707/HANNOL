package com.sp.enjoy.giftshop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

@Controller("giftshop.enjoyGiftController")
public class EnjoyGiftController {

	@Autowired
	private EnjoyGiftService service;

	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "/enjoy/giftshop")
	public String enjoyGiftList(@RequestParam(value = "page", defaultValue="1") int current_page, HttpSession session,
			HttpServletRequest req, Model model) throws Exception {
		String cp = req.getContextPath();

		int rows = 6;
		int total_page = 0;

		int dataCount = service.dataCount();
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<EnjoyGift> list = service.enjoyGiftList(paramMap);
		String list_url = cp+"/enjoy/giftshop";
		String articleUrl = cp+"/enjoy/giftarticle?page="+current_page;
	
		String paging = myUtil.paging(current_page, total_page, list_url);
		model.addAttribute("subMenu", "2");
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		return ".four.menu6.giftshop.list";
	}
	
	@RequestMapping(value = "/enjoy/giftarticle")
	public String giftArticle(@RequestParam(value = "page", defaultValue="1") String current_page, 
			int facilityCode, Model model) throws Exception{
		
		EnjoyGift dto = service.readGift(facilityCode);
		if(dto == null) {
			return "redirect:/enjoy/giftshop?page="+current_page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", current_page);
		model.addAttribute("subMenu", "2");
		return ".four.menu6.giftshop.article";
	}
}

