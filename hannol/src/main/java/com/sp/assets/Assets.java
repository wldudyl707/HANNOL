package com.sp.assets;

import java.util.List;

public class Assets {
	private int listNum; // 리스트번호
	private int bookCode; // 예약코드
	private String bookDate; // 예약날짜
	private String useDate; // 사용예정일
	private int bookTime; // 예약시간(오후/종일)
	private int state; // 상태(예약/반납완료/대여중/기간만료)
	private String name; // 이름 (예약자)
	private String tel; // 전화번호(예약자)
	private String tel1;
	private String tel2;
	private String tel3;

	private long usersCode; // 유저코드
	private int assetsCode; // 자산코드
	private int facilityCode; // 시설코드
	private String facName; // 시설이름
	private int gubunCode; //구분 코드

	private int ticketCode; //티켓코드
	
	private List<Integer> bookCodes;

	
	String themeName;
	int themeCode;
	
	int lockerNum;
	int lock1_1;
	int lock1_2;
	int lock1_3;
	int lock1_4;
	int lock1_5;
	int lock1_6;
	int lock1_7;
	int lock1_8;
	int lock1_9;
	int lock1_10;
	
	int lock2_1;
	int lock2_2;
	int lock2_3;
	int lock2_4;
	int lock2_5;
	int lock2_6;
	int lock2_7;
	int lock2_8;
	int lock2_9;
	int lock2_10;
	
	int lock3_1;
	int lock3_2;
	int lock3_3;
	int lock3_4;
	int lock3_5;
	int lock3_6;
	int lock3_7;
	int lock3_8;
	int lock3_9;
	int lock3_10;
	
	int lock4_1;
	int lock4_2;
	int lock4_3;
	int lock4_4;
	int lock4_5;
	int lock4_6;
	int lock4_7;
	int lock4_8;
	int lock4_9;
	int lock4_10;
	
	int lock5_1;
	int lock5_2;
	int lock5_3;
	int lock5_4;
	int lock5_5;
	int lock5_6;
	int lock5_7;
	int lock5_8;
	int lock5_9;
	int lock5_10;
	
	
	public String getThemeName() {
		return themeName;
	}

	public void setThemeName(String themeName) {
		this.themeName = themeName;
	}

	public int getThemeCode() {
		return themeCode;
	}

	public void setThemeCode(int themeCode) {
		this.themeCode = themeCode;
	}

	public int getLockerNum() {
		return lockerNum;
	}

	public void setLockerNum(int lockerNum) {
		this.lockerNum = lockerNum;
	}

	public int getLock1_1() {
		return lock1_1;
	}

	public void setLock1_1(int lock1_1) {
		this.lock1_1 = lock1_1;
	}

	public int getLock1_2() {
		return lock1_2;
	}

	public void setLock1_2(int lock1_2) {
		this.lock1_2 = lock1_2;
	}

	public int getLock1_3() {
		return lock1_3;
	}

	public void setLock1_3(int lock1_3) {
		this.lock1_3 = lock1_3;
	}

	public int getLock1_4() {
		return lock1_4;
	}

	public void setLock1_4(int lock1_4) {
		this.lock1_4 = lock1_4;
	}

	public int getLock1_5() {
		return lock1_5;
	}

	public void setLock1_5(int lock1_5) {
		this.lock1_5 = lock1_5;
	}

	public int getLock1_6() {
		return lock1_6;
	}

	public void setLock1_6(int lock1_6) {
		this.lock1_6 = lock1_6;
	}

	public int getLock1_7() {
		return lock1_7;
	}

	public void setLock1_7(int lock1_7) {
		this.lock1_7 = lock1_7;
	}

	public int getLock1_8() {
		return lock1_8;
	}

	public void setLock1_8(int lock1_8) {
		this.lock1_8 = lock1_8;
	}

	public int getLock1_9() {
		return lock1_9;
	}

	public void setLock1_9(int lock1_9) {
		this.lock1_9 = lock1_9;
	}

	public int getLock1_10() {
		return lock1_10;
	}

	public void setLock1_10(int lock1_10) {
		this.lock1_10 = lock1_10;
	}

	public int getLock2_1() {
		return lock2_1;
	}

	public void setLock2_1(int lock2_1) {
		this.lock2_1 = lock2_1;
	}

	public int getLock2_2() {
		return lock2_2;
	}

	public void setLock2_2(int lock2_2) {
		this.lock2_2 = lock2_2;
	}

	public int getLock2_3() {
		return lock2_3;
	}

	public void setLock2_3(int lock2_3) {
		this.lock2_3 = lock2_3;
	}

	public int getLock2_4() {
		return lock2_4;
	}

	public void setLock2_4(int lock2_4) {
		this.lock2_4 = lock2_4;
	}

	public int getLock2_5() {
		return lock2_5;
	}

	public void setLock2_5(int lock2_5) {
		this.lock2_5 = lock2_5;
	}

	public int getLock2_6() {
		return lock2_6;
	}

	public void setLock2_6(int lock2_6) {
		this.lock2_6 = lock2_6;
	}

	public int getLock2_7() {
		return lock2_7;
	}

	public void setLock2_7(int lock2_7) {
		this.lock2_7 = lock2_7;
	}

	public int getLock2_8() {
		return lock2_8;
	}

	public void setLock2_8(int lock2_8) {
		this.lock2_8 = lock2_8;
	}

	public int getLock2_9() {
		return lock2_9;
	}

	public void setLock2_9(int lock2_9) {
		this.lock2_9 = lock2_9;
	}

	public int getLock2_10() {
		return lock2_10;
	}

	public void setLock2_10(int lock2_10) {
		this.lock2_10 = lock2_10;
	}

	public int getLock3_1() {
		return lock3_1;
	}

	public void setLock3_1(int lock3_1) {
		this.lock3_1 = lock3_1;
	}

	public int getLock3_2() {
		return lock3_2;
	}

	public void setLock3_2(int lock3_2) {
		this.lock3_2 = lock3_2;
	}

	public int getLock3_3() {
		return lock3_3;
	}

	public void setLock3_3(int lock3_3) {
		this.lock3_3 = lock3_3;
	}

	public int getLock3_4() {
		return lock3_4;
	}

	public void setLock3_4(int lock3_4) {
		this.lock3_4 = lock3_4;
	}

	public int getLock3_5() {
		return lock3_5;
	}

	public void setLock3_5(int lock3_5) {
		this.lock3_5 = lock3_5;
	}

	public int getLock3_6() {
		return lock3_6;
	}

	public void setLock3_6(int lock3_6) {
		this.lock3_6 = lock3_6;
	}

	public int getLock3_7() {
		return lock3_7;
	}

	public void setLock3_7(int lock3_7) {
		this.lock3_7 = lock3_7;
	}

	public int getLock3_8() {
		return lock3_8;
	}

	public void setLock3_8(int lock3_8) {
		this.lock3_8 = lock3_8;
	}

	public int getLock3_9() {
		return lock3_9;
	}

	public void setLock3_9(int lock3_9) {
		this.lock3_9 = lock3_9;
	}

	public int getLock3_10() {
		return lock3_10;
	}

	public void setLock3_10(int lock3_10) {
		this.lock3_10 = lock3_10;
	}

	public int getLock4_1() {
		return lock4_1;
	}

	public void setLock4_1(int lock4_1) {
		this.lock4_1 = lock4_1;
	}

	public int getLock4_2() {
		return lock4_2;
	}

	public void setLock4_2(int lock4_2) {
		this.lock4_2 = lock4_2;
	}

	public int getLock4_3() {
		return lock4_3;
	}

	public void setLock4_3(int lock4_3) {
		this.lock4_3 = lock4_3;
	}

	public int getLock4_4() {
		return lock4_4;
	}

	public void setLock4_4(int lock4_4) {
		this.lock4_4 = lock4_4;
	}

	public int getLock4_5() {
		return lock4_5;
	}

	public void setLock4_5(int lock4_5) {
		this.lock4_5 = lock4_5;
	}

	public int getLock4_6() {
		return lock4_6;
	}

	public void setLock4_6(int lock4_6) {
		this.lock4_6 = lock4_6;
	}

	public int getLock4_7() {
		return lock4_7;
	}

	public void setLock4_7(int lock4_7) {
		this.lock4_7 = lock4_7;
	}

	public int getLock4_8() {
		return lock4_8;
	}

	public void setLock4_8(int lock4_8) {
		this.lock4_8 = lock4_8;
	}

	public int getLock4_9() {
		return lock4_9;
	}

	public void setLock4_9(int lock4_9) {
		this.lock4_9 = lock4_9;
	}

	public int getLock4_10() {
		return lock4_10;
	}

	public void setLock4_10(int lock4_10) {
		this.lock4_10 = lock4_10;
	}

	public int getLock5_1() {
		return lock5_1;
	}

	public void setLock5_1(int lock5_1) {
		this.lock5_1 = lock5_1;
	}

	public int getLock5_2() {
		return lock5_2;
	}

	public void setLock5_2(int lock5_2) {
		this.lock5_2 = lock5_2;
	}

	public int getLock5_3() {
		return lock5_3;
	}

	public void setLock5_3(int lock5_3) {
		this.lock5_3 = lock5_3;
	}

	public int getLock5_4() {
		return lock5_4;
	}

	public void setLock5_4(int lock5_4) {
		this.lock5_4 = lock5_4;
	}

	public int getLock5_5() {
		return lock5_5;
	}

	public void setLock5_5(int lock5_5) {
		this.lock5_5 = lock5_5;
	}

	public int getLock5_6() {
		return lock5_6;
	}

	public void setLock5_6(int lock5_6) {
		this.lock5_6 = lock5_6;
	}

	public int getLock5_7() {
		return lock5_7;
	}

	public void setLock5_7(int lock5_7) {
		this.lock5_7 = lock5_7;
	}

	public int getLock5_8() {
		return lock5_8;
	}

	public void setLock5_8(int lock5_8) {
		this.lock5_8 = lock5_8;
	}

	public int getLock5_9() {
		return lock5_9;
	}

	public void setLock5_9(int lock5_9) {
		this.lock5_9 = lock5_9;
	}

	public int getLock5_10() {
		return lock5_10;
	}

	public void setLock5_10(int lock5_10) {
		this.lock5_10 = lock5_10;
	}

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
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

	public String getUseDate() {
		return useDate;
	}

	public void setUseDate(String useDate) {
		this.useDate = useDate;
	}

	public int getBookTime() {
		return bookTime;
	}

	public void setBookTime(int bookTime) {
		this.bookTime = bookTime;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public long getUsersCode() {
		return usersCode;
	}

	public void setUsersCode(long usersCode) {
		this.usersCode = usersCode;
	}

	public int getAssetsCode() {
		return assetsCode;
	}

	public void setAssetsCode(int assetsCode) {
		this.assetsCode = assetsCode;
	}

	public int getFacilityCode() {
		return facilityCode;
	}

	public void setFacilityCode(int facilityCode) {
		this.facilityCode = facilityCode;
	}

	public String getFacName() {
		return facName;
	}

	public void setFacName(String facName) {
		this.facName = facName;
	}

	public int getGubunCode() {
		return gubunCode;
	}

	public void setGubunCode(int gubunCode) {
		this.gubunCode = gubunCode;
	}

	public List<Integer> getBookCodes() {
		return bookCodes;
	}

	public void setBookCodes(List<Integer> bookCodes) {
		this.bookCodes = bookCodes;
	}

	public int getTicketCode() {
		return ticketCode;
	}

	public void setTicketCode(int ticketCode) {
		this.ticketCode = ticketCode;
	}
	
	
}
