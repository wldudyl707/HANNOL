package com.sp.ticket;

import java.util.List;
import java.util.Map;

public interface TicketService {
	public List<Ticket> listTicket() throws Exception;
	public int checkReservation(Map<String, Object> map) throws Exception;
	public int checkYearTicket(Map<String, Object> map) throws Exception;
	public String checkUserBirth(long usersCode) throws Exception;
	public List<Ticket> listYearTicket() throws Exception;
}
