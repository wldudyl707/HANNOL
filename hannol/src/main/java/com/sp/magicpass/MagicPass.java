package com.sp.magicpass;

import java.util.List;

public class MagicPass {
	private long facilityCode;
	private String name;
	private int state; // 0: 사용불가, 1: 사용중
	private String saveMainFileName;
	private long gubunCode; // 1: 놀이기구
	private long themeCode; // 1: 프린세스, 2: 토이스토리, 3:미니언즈, 5: 라이온킹, 6: 니모
	private int congestion; // 0: 혼잡, 1: 보통, 2: 원활
	private long mpCode;
	private int mpTime;
	private String mpDate;
	private List<Integer> ticketCode;
	private int ticketsCode;
	private String goodsName;
	private long usersCode;
	private int cnt;
	private int ticketGubun;
	private String gubunName;

	public String getGubunName() {
		return gubunName;
	}

	public void setGubunName(String gubunName) {
		this.gubunName = gubunName;
	}

	public int getTicketGubun() {
		return ticketGubun;
	}

	public void setTicketGubun(int ticketGubun) {
		this.ticketGubun = ticketGubun;
	}

	public long getFacilityCode() {
		return facilityCode;
	}

	public void setFacilityCode(long facilityCode) {
		this.facilityCode = facilityCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getSaveMainFileName() {
		return saveMainFileName;
	}

	public void setSaveMainFileName(String saveMainFileName) {
		this.saveMainFileName = saveMainFileName;
	}

	public long getGubunCode() {
		return gubunCode;
	}

	public void setGubunCode(long gubunCode) {
		this.gubunCode = gubunCode;
	}

	public long getThemeCode() {
		return themeCode;
	}

	public void setThemeCode(long themeCode) {
		this.themeCode = themeCode;
	}

	public int getCongestion() {
		return congestion;
	}

	public void setCongestion(int congestion) {
		this.congestion = congestion;
	}

	public long getMpCode() {
		return mpCode;
	}

	public void setMpCode(long mpCode) {
		this.mpCode = mpCode;
	}

	public int getMpTime() {
		return mpTime;
	}

	public void setMpTime(int mpTime) {
		this.mpTime = mpTime;
	}

	public String getMpDate() {
		return mpDate;
	}

	public void setMpDate(String mpDate) {
		this.mpDate = mpDate;
	}

	public List<Integer> getTicketCode() {
		return ticketCode;
	}

	public void setTicketCode(List<Integer> ticketCode) {
		this.ticketCode = ticketCode;
	}

	public int getTicketsCode() {
		return ticketsCode;
	}

	public void setTicketsCode(int ticketsCode) {
		this.ticketsCode = ticketsCode;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public long getUsersCode() {
		return usersCode;
	}

	public void setUsersCode(long usersCode) {
		this.usersCode = usersCode;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	@Override
	public String toString() {
		return "facilityCode : " + facilityCode + "name : " + name + "state : " + state + "saveMainFileName : "
				+ saveMainFileName + "gubunCode : " + gubunCode + "themeCode : " + themeCode + "congestion : "
				+ congestion + "mpCode : " + mpCode + "mpTime : " + mpTime + "mpDate : " + mpDate + "ticketCode : "
				+ ticketCode + "goodsName : " + goodsName + "usersCode : " + usersCode + "cnt : " + cnt;
	}

}
