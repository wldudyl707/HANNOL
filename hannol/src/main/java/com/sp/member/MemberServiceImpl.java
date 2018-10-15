package com.sp.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO  dao;

	@Override
	public Member loginMember(String userId) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("member.loginMember", userId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public long userSeq() throws Exception {
		long result = 0;
		try {
			result = dao.selectOne("member.usersSeq");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertMember(Member dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("member.insertUsers", dto.getUsersCode());
			result += dao.insertData("member.insertMember1", dto);
			result += dao.insertData("member.insertMember2", dto);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	   public Member readMember(String userId) {
	      Member dto = null;
	      try {
	         dto = dao.selectOne("member.readMember", userId);
	      } catch (Exception e) {
	         System.out.println(e);
	      }
	      return dto;
	   }

	   @Override
	   public int updateLastLogin(long usersCode) throws Exception {
	      int result = 0;
	      try {
	         result = dao.updateData("member.updateLastLogin", usersCode);
	      } catch (Exception e) {
	         throw e;
	      }
	      return result;
	   }

	@Override
	public int updatePwd(Member dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("member.updatePwd", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Member readMemberByEmail(String email) {
		Member dto = null;
		try {
			dto = dao.selectOne("member.readMemberByEmail", email);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateMember(Member dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("member.updateMember1", dto);
			result += dao.updateData("member.updateMember2", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteMember(String userId) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("member.deleteMember", userId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
