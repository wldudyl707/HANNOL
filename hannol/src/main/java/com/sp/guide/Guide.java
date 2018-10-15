package com.sp.guide;

public class Guide {
	private int usersCode;
	private String name;//가이드인 직원 조회해올때 사용
	
	private int schCode;
	private int timezone;

	private String workDate;
	private String role;
	private String memo;
	
	//예약관련
	private int bookCode;
	private String bookDate;
	private String tel;
	
	//예약자정보
	private String nameM;
	private int usersCodeM;
	private String memberId;
	
	//티켓검사
	private long ticketCode;
	private String startDate;
	private String endDate;
	private int gubun;
	
	public int getUsersCode() {
		return usersCode;
	}
	public void setUsersCode(int usersCode) {
		this.usersCode = usersCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSchCode() {
		return schCode;
	}
	public void setSchCode(int schCode) {
		this.schCode = schCode;
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
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getNameM() {
		return nameM;
	}
	public void setNameM(String nameM) {
		this.nameM = nameM;
	}
	public int getUsersCodeM() {
		return usersCodeM;
	}
	public void setUsersCodeM(int usersCodeM) {
		this.usersCodeM = usersCodeM;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public long getTicketCode() {
		return ticketCode;
	}
	public void setTicketCode(long ticketCode) {
		this.ticketCode = ticketCode;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public int getGubun() {
		return gubun;
	}
	public void setGubun(int gubun) {
		this.gubun = gubun;
	}
	
}
