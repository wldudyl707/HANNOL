package com.sp.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("review.ReviewController")
public class ReviewController {

	@Autowired
	ReviewService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "/review/list", method = RequestMethod.GET)
	public String list(HttpSession session, Model model) {
		model.addAttribute("subMenu", "5");
		return ".four.menu2.review.list";
	}

 	@RequestMapping(value="/review/createForm", method=RequestMethod.GET)
 	public String createReviewForm(
 			Model model) throws Exception {
 		model.addAttribute("mode", "created");
 		return "/menu2/review/create";
 	}
	
 	@RequestMapping(value="/review/created", method=RequestMethod.POST)
 	@ResponseBody
 	public Map<String, Object> createReviewSubmit(Review dto,
 			HttpSession session) throws Exception {
 		
 		Map<String, Object> model=new HashMap<>();
 		SessionInfo info = (SessionInfo) session.getAttribute("member"); 	
 		if(info == null) {
 			model.put("state", "false");
 			model.put("msg", "후기를 남기기 전에 로그인을 먼저 해야합니다.");
 			return model;
 		}
 		
 		dto.setUsersCode((int) info.getUsersCode());
 		service.insertReview(dto);
 		model.put("state", "true");
 		return model;
 	}
 	
 	@RequestMapping(value="/review/delete", method=RequestMethod.GET)
 	@ResponseBody
 	public Map<String, Object> deleteReview(
 			@RequestParam(value="reviewCode") int reviewCode,
 			HttpSession session
 			) throws Exception {
 		Map<String, Object> model=new HashMap<>();
 		SessionInfo info = (SessionInfo) session.getAttribute("member"); 	
 		if(info == null) {
 			model.put("state", "false");
 			model.put("msg", "후기를 삭제하기 전에 로그인을 먼저 해야합니다.");
 			return model;
 		}
 		
 		service.deleteReview(reviewCode);
 		model.put("state", "true");
 		
 		return model;
 	}
 	
 	@RequestMapping(value="/review/update", method=RequestMethod.GET)
 	public String updateReviewForm(
 			@RequestParam(value="reviewCode") int reviewCode,
 			HttpServletResponse response,
 			Model model) throws Exception {
 		Review dto = service.readReview(reviewCode);

 		model.addAttribute("mode", "update");
 		model.addAttribute("dto", dto);
 		
 		return "/menu2/review/create";
 	}
 	
 	@RequestMapping(value="/review/update", method=RequestMethod.POST)
 	@ResponseBody
 	public Map<String, Object> updateReviewSubmit(Review dto,
 			HttpSession session) throws Exception {
 		Map<String, Object> model=new HashMap<>();
 		SessionInfo info = (SessionInfo) session.getAttribute("member"); 	
 		if(info == null) {
 			model.put("state", "false");
 			model.put("msg", "수정을 하기 전에 로그인을 먼저 해야합니다.");
 			return model;
 		}
 		
 		service.updateReview(dto);
 		model.put("state", "true");
 		return model;
 	}
 	
 	@RequestMapping(value = "/review/listReview", method = RequestMethod.GET)
	public String listReview(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			HttpSession session,
			Model model) throws Exception {
 		int rows = 5;
 		int total_page = 0;
 		int dataCount = 0; 

 		dataCount = service.dataCount();
 		total_page = myUtil.pageCount(rows, dataCount);
 		if(current_page>total_page)
 			current_page=total_page;
 		
 		int start = (current_page-1)*rows+1;
 		int end = current_page*rows;
 		
 		SessionInfo info = (SessionInfo) session.getAttribute("member");
 		
 		Map<String, Object> map = new HashMap<>();
 		map.put("start", start);
 		map.put("end", end);
 		
 		if(info == null) {
 			map.put("usersCode", null); 			
 		} else {
 			map.put("usersCode", info.getUsersCode()); 			
 		}
 		
 		List<Review> list = service.listReview(map);
 		
 		for(Review dto : list) {
 			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
 		}
 		
 		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
 		
 		model.addAttribute("list", list);
 		model.addAttribute("pageNo", current_page);
 		model.addAttribute("dataCount", dataCount);
 		model.addAttribute("total_page", total_page);
 		model.addAttribute("paging", paging);
 		
		return "menu2/review/reviewList";
	}
 	
 	// 좋아요
 	@RequestMapping(value="/review/like", method=RequestMethod.GET)
 	@ResponseBody
 	public Map<String, Object> reviewLike(
 			@RequestParam(value="reviewCode") int reviewCode,
 			HttpSession session
 			) throws Exception {
 		Map<String, Object> model=new HashMap<>();
 		SessionInfo info = (SessionInfo) session.getAttribute("member"); 	
 		if(info == null) {
 			model.put("state", "false");
 			model.put("msg", "좋아요 하기 전에 로그인을 먼저 해야합니다.");
 			return model;
 		}
 		
 		Map<String, Object> map = new HashMap<>();
 		map.put("reviewCode", reviewCode);
 		map.put("usersCode", info.getUsersCode());
 		service.insertReviewLike(map);
 		
 		int likeCount = service.likeCount(reviewCode);

 		model.put("state", "true");
 		model.put("likeCount", likeCount);
 		return model;
 	}
 	
 	// 좋아요
 	@RequestMapping(value="/review/likeCancel", method=RequestMethod.GET)
 	@ResponseBody
 	public Map<String, Object> reviewLikeCancel(
 			@RequestParam(value="reviewCode") int reviewCode,
 			HttpSession session
 			) throws Exception {
 		Map<String, Object> model=new HashMap<>();
 		SessionInfo info = (SessionInfo) session.getAttribute("member"); 	
 		if(info == null) {
 			model.put("state", "false");
 			model.put("msg", "좋아요를 취소하기 전에 로그인을 먼저 해야합니다.");
 			return model;
 		}
 		
 		Map<String, Object> tmp=new HashMap<>();
 		tmp.put("usersCode", info.getUsersCode());
 		tmp.put("reviewCode", reviewCode);
 		service.deleteReviewLike(tmp);
 		
 		int likeCount = service.likeCount(reviewCode);
 		
 		model.put("state", "true");
 		model.put("likeCount", likeCount);
 		return model;
 	}
 	
}
