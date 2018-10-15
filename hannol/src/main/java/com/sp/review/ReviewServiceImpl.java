package com.sp.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("review.reviewService")
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	CommonDAO dao;

	@Override
	public int insertReview(Review dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("review.insertReview", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount() throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("review.dataCount");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Review> listReview(Map<String, Object> map) throws Exception {
		List<Review> list = null;
		try {
			list = dao.selectList("review.listReview", map);
			
			Map<String, Object> tmp = new HashMap<>();
			
			for(Review r : list) {
				String memberIdWithStar = r.getMemberId().substring(0, 4).concat("****");
				r.setMemberIdWithStar(memberIdWithStar);
				
				//
				tmp.put("usersCode", map.get("usersCode"));
				tmp.put("reviewCode", r.getReviewCode());
				int myLike = isMyLike(tmp);
				r.setMyLike(myLike);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public int isMyLike(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("review.isMyLike", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Review readReview(int reviewCode) throws Exception {
		Review dto = null;
		try {
			dto = dao.selectOne("review.readReview", reviewCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateReview(Review dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("review.updateReview", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteReview(int reviewCode) throws Exception {
		int result = 0;
		try {
			deleteReviewLike(reviewCode);
			result = dao.deleteData("review.deleteReview", reviewCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	
	@Override
	public int deleteReviewLike(int reviewCode) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("review.deleteReviewLike", reviewCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int likeCount(int reviewCode) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("review.likeCount", reviewCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertReviewLike(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("review.insertReviewLike", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteReviewLike(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("review.deleteReviewLike2", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
