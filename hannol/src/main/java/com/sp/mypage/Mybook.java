package com.sp.mypage;

public class Mybook {
	private int usresCode;
	private int listNum;

	// 가이드 조회시 사용
	private int schCode;
	private int timezone;
	private String workDate;
	private String bookDate;
	private String role;
	private String memo;
	
	//가이드 상세
	private int bookCode;
	private String name;
	private String tel;
	
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getUsresCode() {
		return usresCode;
	}
	public void setUsresCode(int usresCode) {
		this.usresCode = usresCode;
	}
	public int getSchCode() {
		return schCode;
	}
	public void setSchCode(int schCode) {
		this.schCode = schCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getTimezone() {
		return timezone;
	}
	public void setTimezone(int timezone) {
		this.timezone = timezone;
	}
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getBookCode() {
		return bookCode;
	}
	public void setBookCode(int bookCode) {
		this.bookCode = bookCode;
	}

}
