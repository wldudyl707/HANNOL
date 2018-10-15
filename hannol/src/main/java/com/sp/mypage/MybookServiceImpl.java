package com.sp.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.assets.Assets;
import com.sp.common.dao.CommonDAO;
import com.sp.magicpass.MagicPass;

@Service("mypage.mybookService")
public class MybookServiceImpl implements MybookService {
	@Autowired
	CommonDAO dao;

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("book.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Mybook> listMybook(Map<String, Object> map) throws Exception {
		List<Mybook> mybook = null;
		try {
			mybook = dao.selectList("book.listMybook", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return mybook;
	}

	@Override
	public int deleteGuideBook(int bookCode) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("book.deleteGuideBook", bookCode);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCountMagic(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("book.dataCountMagic", map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public List<MagicPass> listMymagic(Map<String, Object> map) throws Exception {
		List<MagicPass> list = null;
		try {
			list = dao.selectList("book.listMymagic", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public int deleteMagicPass(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("book.deleteMagic", map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public List<Assets> assetsBookList(Map<String, Object> map) throws Exception {
		List<Assets> list = null;
		try {
			list = dao.selectList("book.assetsBookList", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public int assetsBookData(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("book.dataCountAssets", map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public int deleteAssetsBook(Assets dto) throws Exception {
		int result = 0;
		try {
			for(int i=0; i<dto.getBookCodes().size(); i++) {
				dao.deleteData("book.deleteAssetsBook", dto.getBookCodes().get(i));
			}
			result = 1;
		} catch (Exception e) {
			throw e;
		}
		return result; 
	}

	@Override
	public int expireAssetsBook(int num) throws Exception {
		int result = 0;
		try {
			dao.updateData("book.expireAssetsBook", num);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	

}
