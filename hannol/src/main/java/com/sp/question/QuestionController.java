package com.sp.question;

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

import com.sp.common.MyUtilGeneral;
import com.sp.member.SessionInfo;

@Controller("question.questionController")
public class QuestionController {

	@Autowired
	QuestionService service;

	@Autowired
	MyUtilGeneral util;

	@RequestMapping(value = "/question/question")
	public String question(Model model) throws Exception {


		return ".four.menu2.question.question";
	}

	@RequestMapping(value = "/question/insertQuestion")
	public String insertQueston(Question dto, HttpSession session) throws Exception {

		if (dto == null)
			return "question/question";

		dto.setParentCode(0);

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		dto.setUsersCode((int) info.getUsersCode());

		service.insertQuestion(dto);

		return "redirect:/question/result";
	}

	@RequestMapping(value = "/question/result")
	public String result() throws Exception {

		return ".four.menu2.question.result";
	}

	@RequestMapping(value = "/mypage/question")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page, 
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		int dataCount = service.dataCount((int) info.getUsersCode());
		int rows = 10;
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		int total_page = util.pageCount(rows, dataCount);
		if (current_page > total_page)
			current_page = total_page;
		
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("usersCode", (int)info.getUsersCode());

		List<Question> list = service.list(map);
		
		int listNum, n = 0;
		Iterator<Question> it = list.iterator();
		while (it.hasNext()) {
			Question data = it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			n++;
		}

		String cp = req.getContextPath();
		String list_url = cp+"/mypage/question";
		String articleUrl = cp + "/mypage/article?page=" + current_page;
		String paging = util.paging(current_page, total_page, list_url);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("subMenu", "5");

		return ".four.menu3.mypage.question";
	}
	
	@RequestMapping(value = "/mypage/article")
	public String article(int num, int page, HttpSession session, Model model) throws Exception{
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Question dto = service.readQuestion(num);
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		Question adminAnswer = service.readAnswer(num);
		if(adminAnswer != null) {
			adminAnswer.setContent(adminAnswer.getContent().replaceAll("\n", "<br>"));
			model.addAttribute("adminAnswer", adminAnswer);
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("usersCode", (int)info.getUsersCode());
		
		return ".four.menu3.mypage.questionArticle";
	}
	
	@RequestMapping(value = "/mypage/questionModify")
	public String modify(int num, int page, Model model) throws Exception{
		
		Question dto = service.readQuestion(num);
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		
		return ".four.menu3.mypage.questionModify";
	}
	
	@RequestMapping(value = "/mypage/updateQuestion")
	public String update(Question dto, int page, @RequestParam int num) throws Exception{
		dto.setQnaCode(num);
		service.updateQuestion(dto);
		
		return "redirect:/mypage/article?num="+num+"&page="+page;
	}
	
	@RequestMapping(value = "/mypage/questionDelete")
	public String delete(int page, @RequestParam int num) throws Exception{

		service.deleteQuestion(num);
		
		return "redirect:/mypage/question?page="+page;
	}
}
