package com.itbank.model;

import java.sql.Date;

// NOTICE_IDX     NOT NULL NUMBER         
// NOTICE_ADMIN   NOT NULL VARCHAR2(100)  
// NOTICE_NAME    NOT NULL VARCHAR2(100)  
// NOTICE_CONTENT NOT NULL VARCHAR2(2000) 
// NOTICE_DATE             DATE  

public class NoticeDTO {
	
	private int notice_idx;
	private String notice_admin;
	private String notice_name;
	private String notice_content;
	private Date notice_date;

	public int getNotice_idx() {
		return notice_idx;
	}

	public void setNotice_idx(int notice_idx) {
		this.notice_idx = notice_idx;
	}

	public String getNotice_admin() {
		return notice_admin;
	}

	public void setNotice_admin(String notice_admin) {
		this.notice_admin = notice_admin;
	}

	public String getNotice_name() {
		return notice_name;
	}

	public void setNotice_name(String notice_name) {
		this.notice_name = notice_name;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public Date getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}

	

}
