package com.sp.pay;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("pay.payService")
public class PayServiceImpl implements PayService {
	@Autowired
	CommonDAO dao;

	@Override
	public List<MCoupon> couponCount(Map<String, Object> map) throws Exception {
		List<MCoupon> list = null;
		try {
			list = dao.selectList("pay.couponCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return list;
	}

	@Override
	public int insertPay(Pay dto) throws Exception {
		int result = 0;
		try {
			int seq = dao.selectOne("pay.seq");
			dto.setPayCode(seq);

			result = dao.insertData("pay.insertPay", dto);
			dao.insertData("pay.insertPayInfo", dto);
			dao.insertData("pay.insertCardInfo", dto);
			dao.updateData("pay.insertPaymentInfo", dto);
			if (dto.getParentCode() == 2) {
				dao.updateData("pay.insertGift", dto);
				dao.deleteData("pay.deleteCart", dto);
			} else {
				dao.updateData("pay.insertTicket", dto);
				if (dto.getDclist().size() > 0)
					dao.updateData("pay.insertDiscount", dto);
				if (dto.getCouponCode() != null && dto.getCouponCode().size() > 0)
					dao.updateData("pay.insertCouponHistory", dto);
				if (dto.getCouponCode() != null && dto.getCouponCode().size() > 0) {
					for (int i = 0; i < dto.getCouponCode().size(); i++) {
						Map<String, Object> map = new HashMap<>();
						map.put("couponCode", dto.getCouponCode().get(i));
						map.put("usersCode", dto.getUsersCode());
						dao.updateData("pay.updateCoupon", map);
					}
				}
			}
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	public Pay readResult(int payCode) throws Exception {
		Pay dto = null;
		try {
			dto = dao.selectOne("pay.readResult", payCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int isCard(String cardCo) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("pay.isCard", cardCo);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	// paylist
	@Override
	public List<Paylist> paylist(Map<String, Object> map) throws Exception {
		List<Paylist> list = null;
		try {
			list = dao.selectList("pay.paylist", map);

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("pay.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Integer> useDate(Map<String, Object> map) throws Exception {
		List<Integer> list = null;
		try {
			list = dao.selectList("pay.useDate", map);

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int deleteRefund(int payCode) throws Exception {
		int result = 0;
		try {
			//매직패스 예약 취소
			dao.deleteData("magic.deleteMagicpassAll", payCode);
			
			
			result = dao.deleteData("pay.deleteGift", payCode);
			dao.updateData("pay.updateCardInfo", payCode);

			dao.deleteData("pay.deleteTicket", payCode);
			dao.deleteData("pay.deleteDiscount", payCode);

			List<Map<String, Object>> couponCode = dao.selectList("pay.getCouponCode", payCode);
			if (couponCode != null && couponCode.size() > 0) {
				for (int i = 0; i < couponCode.size(); i++) {
					System.out.println(couponCode.get(i).get("COUPONCODE").toString());
					Map<String, Object> map = new HashMap<>();
					map.put("couponCode", (couponCode.get(i)).get("COUPONCODE"));
					dao.updateData("pay.updateCouponState", map);
				}
			}
			
			dao.deleteData("pay.deleteCouponHistory", payCode);

		} catch (Exception e) {
			throw e;
		}
		return result;
	}

}
