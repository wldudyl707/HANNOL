package com.sp.mypage;

import java.util.List;
import java.util.Map;

import com.sp.assets.Assets;
import com.sp.magicpass.MagicPass;

public interface MybookService {
	public int dataCount(Map<String, Object> map) throws Exception;

	public List<Mybook> listMybook(Map<String, Object> map) throws Exception;
	public int deleteGuideBook(int bookCode) throws Exception;
	
	//매직패스부분
	public int dataCountMagic(Map<String, Object> map) throws Exception;
	public List<MagicPass> listMymagic(Map<String, Object> map) throws Exception;
	public int deleteMagicPass(Map<String, Object> map) throws Exception;
	
	
	//편의시설
	public int assetsBookData(Map<String, Object> map) throws Exception;
	public List<Assets> assetsBookList(Map<String, Object> map) throws Exception;
	public int deleteAssetsBook(Assets dto) throws Exception;
	public int expireAssetsBook(int num) throws Exception;
}
