package com.sp.show;

import java.util.List;

public class Show {
	private int showCode;
	private int facilityCode;
	private int gubunCode;
	private int showInfoCode;

	private String showName;
	private String memo;
	private String saveFilename;
	private String name;				// facility
	private List<String> showTime;
	
	private String startDate;
	private String endDate;
	private String runningTime;
	private String saveLocFilename;
	
	private int showBookCode;
	private int seatCount;
	private List<Integer> seatNum;		// 좌석
	private String bookDate;			// 예약일자
	private String startTime;			// 시작시각
	private String screenDate;			// 상영날짜
	
	public String getScreenDate() {
		return screenDate;
	}
	public void setScreenDate(String screenDate) {
		this.screenDate = screenDate;
	}
	public int getShowBookCode() {
		return showBookCode;
	}
	public void setShowBookCode(int showBookCode) {
		this.showBookCode = showBookCode;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public List<Integer> getSeatNum() {
		return seatNum;
	}
	public void setSeatNum(List<Integer> seatNum) {
		this.seatNum = seatNum;
	}
	public int getSeatCount() {
		return seatCount;
	}
	public void setSeatCount(int seatCount) {
		this.seatCount = seatCount;
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
	public String getRunningTime() {
		return runningTime;
	}
	public void setRunningTime(String runningTime) {
		this.runningTime = runningTime;
	}
	public String getSaveLocFilename() {
		return saveLocFilename;
	}
	public void setSaveLocFilename(String saveLocFilename) {
		this.saveLocFilename = saveLocFilename;
	}
	public int getShowCode() {
		return showCode;
	}
	public void setShowCode(int showCode) {
		this.showCode = showCode;
	}
	public int getFacilityCode() {
		return facilityCode;
	}
	public void setFacilityCode(int facilityCode) {
		this.facilityCode = facilityCode;
	}
	public int getGubunCode() {
		return gubunCode;
	}
	public void setGubunCode(int gubunCode) {
		this.gubunCode = gubunCode;
	}
	public int getShowInfoCode() {
		return showInfoCode;
	}
	public void setShowInfoCode(int showInfoCode) {
		this.showInfoCode = showInfoCode;
	}
	public String getShowName() {
		return showName;
	}
	public void setShowName(String showName) {
		this.showName = showName;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<String> getShowTime() {
		return showTime;
	}
	public void setShowTime(List<String> showTime) {
		this.showTime = showTime;
	} 
}
