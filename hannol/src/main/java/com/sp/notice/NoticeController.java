package com.sp.notice;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;

@Controller("bbs.noticeController")
public class NoticeController {

	@Autowired
	private NoticeService service;

	@Autowired
	private MyUtil myUtil;

	@Autowired
	private FileManager fileManager;

	@RequestMapping(value = "/notice/list")
	public String userList(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "searchKey", defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchValue", defaultValue = "") String searchValue, HttpServletRequest req,
			Model model) throws Exception {

		String cp = req.getContextPath();

		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		dataCount = service.dataCount(map);
		if (dataCount != 0)
			total_page = myUtil.pageCount(rows, dataCount);

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page)
			current_page = total_page;

		// 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		// 공지인 글 리스트
		List<Notice> noticeList = service.listOnlyNotice(map);

		// 글 리스트
		List<Notice> list = service.listNotice(map);

		// 리스트의 번호
		int listNum, n = 0;
		Iterator<Notice> it = list.iterator();
		while (it.hasNext()) {
			Notice data = it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			n++;
		}

		String query = "";
		String listUrl = cp + "/notice/list";
		String articleUrl = cp + "/notice/article?page=" + current_page;
		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}

		if (query.length() != 0) {
			listUrl = cp + "/notice/list?" + query;
			articleUrl = cp + "/notice/article?page=" + current_page + "&" + query;
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return ".four.menu2.notice.list";
	}

	@RequestMapping(value = "/notice/article")
	public String article(@RequestParam(value = "num") int num, @RequestParam(value = "page") String page,
			@RequestParam(value = "searchKey", defaultValue = "all") String searchKey,
			@RequestParam(value = "searchValue", defaultValue = "") String searchValue, Model model) throws Exception {

		searchValue = URLDecoder.decode(searchValue, "utf-8");

		String query = "page=" + page;
		if (searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}

		Notice dto = service.readNotice(num);
		if (dto == null) {
			return "redirect:/notice/list?" + query;
		}

		dto.setContent(myUtil.htmlSymbols(dto.getContent()));

		// 이전글, 다음글 가져오기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("num", num);

		Notice preReadDto = service.preReadNotice(map);
		Notice nextReadDto = service.nextReadNotice(map);

		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		return ".four.menu2.notice.article";
	}

	@RequestMapping(value = "/notice/download")
	public void download(@RequestParam String saveFilename, @RequestParam String originalFilename,
			HttpServletResponse resp, HttpSession session) throws Exception {
		// 관리자 폴더에 저장된 이미지에 접근해야 하기에 경로를 지정해줌. 사용자 페이지와 관리자페이지가 같은 서버에서 돌기에 가능한 접근법
		// String root = session.getServletContext().getRealPath("/");
		// String pathname = root + "uploads" + File.separator + "noticeFile";
		String pathname = "C:\\study\\work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\hannolAdmin\\uploads\\noticeFile";

		boolean b = false;

		b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);

		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
	}

}
