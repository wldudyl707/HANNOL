package com.sp.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;
import com.sp.member.Member;

@Service("notice.noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private CommonDAO dao;

	@Override
	public Member readStaff() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertNotice(Notice dto) {
		int result = 0;
		try {
			dao.insertData("notice.insertNotice", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("notice.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list = null;
		try {
			list = dao.selectList("notice.listNotice", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Notice> listOnlyNotice(Map<String, Object> map) {
		List<Notice> list =null;
		try {
			list = dao.selectList("notice.listOnlyNotice", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Notice readNotice(int noticeCode) {
		Notice dto =null;
		try {
			dto =dao.selectOne("notice.readNotice", noticeCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Notice preReadNotice(Map<String, Object> map) {
		Notice dto = null;
		try {
			dto =dao.selectOne("notice.preReadNotice", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Notice nextReadNotice(Map<String, Object> map) {
		Notice dto = null;
		try {
			dto =dao.selectOne("notice.nextReadNotice", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

}
