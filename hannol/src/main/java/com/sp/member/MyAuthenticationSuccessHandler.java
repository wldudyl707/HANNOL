package com.sp.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

// 로그인 성공 후 세션 및 쿠키 등의 처리(인증 성공 후 정보 저장) => spring security에서 인증해줬으므로 security에서 정보를 가져오면 됨
// 스마트폰의 경우 로그인 정보를 쿠키에 저장한다.
public class MyAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	@Autowired
	private MemberService service;

	// authentication : 로그인한 정보를 가지고 있는 객체
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		// System.out.println(authentication.getName()); // 로그인 아이디 
		String userId = authentication.getName();

		

		// 세션에 로그인 정보 저장
		HttpSession session = request.getSession();
		Member dto = service.readMember(userId);
		SessionInfo info = new SessionInfo();
		info.setMemberId(userId);
		info.setMemberName(dto.getMemberName());
		info.setUsersCode(dto.getUsersCode());
		info.setAuthority(dto.getAuthority());
		
		// 로그인 날짜 변경
		try {
			service.updateLastLogin(dto.getUsersCode());
		} catch (Exception e) {
			e.printStackTrace();
		}

		// session에 member라는 이름으로 사용자 정보 저장
		session.setAttribute("member", info);

		super.onAuthenticationSuccess(request, response, authentication);
	}

}
