package com.sp.event;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
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

@Controller("event.eventController")
public class EventController {

	@Autowired
	private EventService service;

	@Autowired
	private MyUtil myUtil;

	public String filePath(HttpSession session) {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "eventFile";

		return pathname;
	}

	@RequestMapping(value = "/event/list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page, HttpServletRequest req,
			Model model) throws Exception {
		String cp = req.getContextPath();

		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		dataCount = service.dataCount();
		if (dataCount != 0)
			total_page = myUtil.pageCount(rows, dataCount);
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page)
			current_page = total_page;

		// 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		List<Event> list = service.listEvent(map);

		// 리스트의 번호
		int listNum, n = 0;
		Iterator<Event> it = list.iterator();
		while (it.hasNext()) {
			Event data = it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			n++;
		}
		
		String listUrl = cp + "/event/list";
		String articleUrl = cp + "/event/article?page=" + current_page;

		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("subMenu", "2");
		
		return ".four.menu2.event.list";
	}

	
	@RequestMapping(value = "/event/article")
	public String article(@RequestParam(value = "num") int num, @RequestParam(value = "page") String page,Model model) throws Exception {

		String query = "page=" + page;
		
		Event dto = service.readEvent(num);
		if (dto == null) {
			return "redirect:/event/list?" + query;
		}

		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		model.addAttribute("subMenu", "2");
		
		return ".four.menu2.event.article";
	}
	
}
