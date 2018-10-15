<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<%
// 여기서 값 안넘어 오면 에러~~~~~~~~~!!! 조심조심~~~!!
	Integer seatCount = (Integer)request.getAttribute("seatCount");
	List<Integer> sList = (List<Integer>)request.getAttribute("seatList");

	boolean[] seatList = new boolean[seatCount+1];
	for (int i = 1; i < seatList.length; i++) {
		seatList[i] = true;
	}
	
	if(sList != null) {
		for(Integer i : sList) {
			seatList[i] = false;
		}
	}
%>
<style>
.seat{
	cursor:pointer;
}
.noSelectSeat{
	cursor: no-drop;
	background-color: #69789d;
}
.selectedSeat{
	background-color: #550adf;
	color: white;
	cursor:pointer;
}
input {
	border: none;
	text-align: center;
}
</style>


<div style="margin: 30px auto; width: 600px; background-color: #dfe5f3; text-align: center;"><strong>stage</strong></div>
<div style="margin: -10px auto; width: 600px;">

	<form action="" name="seatForm" method="post">

		<table style="width: 100%; border-spacing: 1; border-collapse: collapse;">
			
			<%
				int row = 0;
				row = seatCount / 15 + 1;
				int k = 1; // 진짜 열
				
				jump:
				for (int i = 1; i <= row; i++) {
					out.print("<tr height='30' align='center' bgcolor='#dfe5f3'>");
					for (int col = 1; col < 18; col++) {
						if (col % 6 == 0) {
							out.print("<td width='30' bgcolor='gray'>&nbsp;</td>");
						} else {
							if (seatList[k] == false) {
								out.print("<td width='30'>" + "<input type=text name='seat' id='"+  k + "' readonly='readonly' class='noSelectSeat' size='2' value='" + k + "'></div></td>");
							} else {
								out.print("<td width='30'><input type=text name='seat' id='" + k + "' readonly='readonly' class='seat' size='2' value='" + k + "'></div></td>");
							}
							
							if(k == seatCount) {
								out.print("</tr>");
								break jump;
							}
	
							k++;
						}
					}
					out.print("</tr>");
				}
			%>
		</table>
	
		<div style="margin: 30px auto; width: 600px; text-align: right;">
			<button class="btn btn-default btn-info" type="button" onclick="selectSeatSubmit()">선택 완료</button>
		</div>
		
		
		<input type="hidden" name="screenDate" value="${screenDate}">
		<input type="hidden" name="startTime" value="${startTime}">
		<input type="hidden" name="showInfoCode" value="${showInfoCode}">
	
	</form>
</div>

