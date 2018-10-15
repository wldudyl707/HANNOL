package com.sp.notice;

import java.util.List;
import java.util.Map;

import com.sp.member.Member;

public interface NoticeService {
	public Member readStaff();
	public int insertNotice(Notice dto);
	public int dataCount(Map<String,Object> map);
	public List<Notice> listNotice(Map<String, Object> map);
	public List<Notice> listOnlyNotice(Map<String, Object> map);
	public Notice readNotice(int noticeCode);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
}
