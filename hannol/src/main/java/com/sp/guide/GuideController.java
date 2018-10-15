package com.sp.guide;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.member.SessionInfo;

@Controller("guide.guideController")
public class GuideController {

	@Autowired
	private GuideService service;

	// 가이드 스케쥴
	@RequestMapping(value = "/guide/list", method = RequestMethod.GET)
	public String scheduleList(Model model) throws Exception {
		// 가이드인 직원의 직원번호/이름 조회해와야함 : staffList란 이름으로 넘겨주기

		List<Guide> stafflist = service.staffList();
		model.addAttribute("staffList", stafflist);

		List<Guide> guideList = service.guideList();
		model.addAttribute("guideList", guideList);
		model.addAttribute("subMenu", "2");

		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate startDay = LocalDate.now();
		LocalDate endDay = LocalDate.now().plusMonths(1);

		model.addAttribute("startDay", dateFormat.format(startDay));
		model.addAttribute("endDay", dateFormat.format(endDay));

		return ".four.menu8.guide.list";
	}

	@ResponseBody
	@RequestMapping(value = "/guide/insertGuide", method = RequestMethod.POST)
	public Map<String, Object> insertGuide(Guide dto) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();

		int tmp = Integer.parseInt(dto.getUsersCode() + "");
		dto.setName(service.getName(tmp));

		service.insertGuide(dto);

		return map;
	}

	@RequestMapping(value = "/guide/info")
	public String readInfo(@RequestParam Integer schCode, Model model, RedirectAttributes redirectAttributes)
			throws Exception {
		Guide dto = service.readInfo(schCode);

		// 일정이 null이거나 예약이 된상태면 돌아가기
		if (dto == null || dto.getBookCode() != 0) {
			redirectAttributes.addFlashAttribute("msg", "예약할 수 없습니다. 다른 가이드를 선택해주세요");
			return "redirect:/guide/list";
		}

		String role = dto.getRole().substring(0, 2);
		String roleImg = "";

		switch (role) {
		case "미키":
			roleImg = "miki.png";
			break;
		case "미니":
			roleImg = "mini.png";
			break;
		case "구피":
			roleImg = "goofy.png";
			break;
		case "도날":// 도날드
			roleImg = "donald.png";
			break;
		case "데이":// 데이지
			roleImg = "daisy.png";
			break;
		default:
			roleImg = "noimage.png";
			break;
		}

		String query = "schCode=" + schCode;

		model.addAttribute("dto", dto);
		model.addAttribute("query", query);
		model.addAttribute("mode", "info");
		model.addAttribute("roleImg", roleImg);
		model.addAttribute("subMenu", "2");

		return ".four.menu8.guide.info";
	}

	@RequestMapping(value = "/guide/book")
	public String bookForm(Integer schCode, HttpSession session, RedirectAttributes redirectAttributes, Model model)
			throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			// 로그인 안함
			redirectAttributes.addFlashAttribute("msg", "로그인 후에 진행해주세요");
			return "redirect:/guide/list";
		}

		Guide dto = service.readInfo(schCode);
		if (dto == null) {
			redirectAttributes.addFlashAttribute("msg", "일정오류. 다른 일정을 선택해주세요");
			return "redirect:/guide/list";
		}

		// 타임존 오전인지 오후인지 검사
		int timezone = dto.getTimezone();

		// 그 날짜, 시간에 이용권 있는지 검사
		// test
		List<Guide> ticket = null;
		int usersCodeM = (int) info.getUsersCode();

		if (timezone == 1) {
			// 오전
			ticket = service.checkTicket1(usersCodeM);
		} else {
			// 오후
			ticket = service.checkTicket2(usersCodeM);
		}

		String workDate = dto.getWorkDate();

		String startDt = null;
		String endDt = null;

		int okTicket = 0;

		for (Guide g : ticket) {
			startDt = g.getStartDate();
			endDt = g.getEndDate();

			if (startDt.compareTo(workDate) <= 0 && endDt.compareTo(workDate) >= 0) {
				okTicket++;
			}

		}

		if (okTicket == 0) {
			// 유효한 티켓 없음
			redirectAttributes.addFlashAttribute("msg", "선택하신 날에 대한 입장권이 있어야 예약가능합니다");
			return "redirect:/guide/list";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("workDate", workDate);
		map.put("usersCodeM", usersCodeM);
		int checkDoublebook = service.checkDoublebook(map);
		if (checkDoublebook > 0) {
			// 하루에 가이드서비스는 한번만 예약가능
			redirectAttributes.addFlashAttribute("msg", "가이드서비스는 하루에 한번만 예약가능합니다");
			return "redirect:/guide/list";
		}

		dto.setMemberId(info.getMemberId());
		dto.setUsersCodeM((int) info.getUsersCode());

		String role = dto.getRole().substring(0, 2);
		String roleImg = "";

		switch (role) {
		case "미키":
			roleImg = "miki.png";
			break;
		case "미니":
			roleImg = "mini.png";
			break;
		case "구피":
			roleImg = "goofy.png";
			break;
		case "도날":// 도날드
			roleImg = "donald.png";
			break;
		case "데이":// 데이지
			roleImg = "daisy.png";
			break;
		default:
			roleImg = "noimage.png";
			break;
		}

		String query = "schCode=" + schCode;

		model.addAttribute("dto", dto);
		model.addAttribute("query", query);
		model.addAttribute("mode", "created");
		model.addAttribute("roleImg", roleImg);
		model.addAttribute("subMenu", "2");

		return ".four.menu8.guide.info";
	}

	@RequestMapping(value = "/guide/createBook")
	public String bookSubmit(Guide dto, int schCode, RedirectAttributes redirectAttributes) throws Exception {
		
		dto.setSchCode(schCode);
		// 예약하기 연결
		service.insertBook(dto);

		redirectAttributes.addFlashAttribute("msg", "예약 완료되었습니다. 마이페이지에서 예약을 확인하실 수 있습니다");
		return "redirect:/guide/list";
	}

	@RequestMapping(value = "/guide/delete")
	public String delete(@RequestParam(value = "schCode") int schCode,
			@RequestParam(value = "usersCodeM") Integer usersCodeM) throws Exception {
		
		// 예약한 회원이 있는 경우 예약한 일정 코드를 0으로 바꿔주고 일정은 삭제
		boolean isBooked = false;
		if (usersCodeM != null) {
			isBooked = true;
		}
		service.deleteGuide(schCode, isBooked);
		
		return "redirect:/guide/list";
	}

}
