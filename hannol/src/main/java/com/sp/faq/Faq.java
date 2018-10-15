package com.sp.faq;

public class Faq {
	private long faqCode;
	private String subject;
	private String content;
	private String created;
	private int gubunCode;
	private String gubunName;

	public long getFaqCode() {
		return faqCode;
	}

	public void setFaqCode(long faqCode) {
		this.faqCode = faqCode;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	public int getGubunCode() {
		return gubunCode;
	}

	public void setGubunCode(int gubunCode) {
		this.gubunCode = gubunCode;
	}

	public String getGubunName() {
		return gubunName;
	}

	public void setGubunName(String gubunName) {
		this.gubunName = gubunName;
	}

}
