package com.itbank.model;

import java.sql.Date;

// QBOARD_IDX     NOT NULL NUMBER         
// USER_IDX                NUMBER         
// QBOARD_WRITER  NOT NULL VARCHAR2(100)  
// QBOARD_TITLE   NOT NULL VARCHAR2(100)  
// QBOARD_CONTENT NOT NULL VARCHAR2(2000) 
// QBOARD_DATE             DATE           
// QBOARD_PRIVACY NOT NULL VARCHAR2(30)   
// QBOARD_VIEW             NUMBER    

public class BoardDTO {

	private int qboard_idx;
	private int user_idx;
	private String qboard_writer;
	private String qboard_title;
	private String qboard_content;
	private Date qboard_date;
	private String qboard_privacy;
	private int qboard_view;

	public int getQboard_idx() {
		return qboard_idx;
	}

	public void setQboard_idx(int qboard_idx) {
		this.qboard_idx = qboard_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getQboard_writer() {
		return qboard_writer;
	}

	public void setQboard_writer(String qboard_writer) {
		this.qboard_writer = qboard_writer;
	}

	public String getQboard_title() {
		return qboard_title;
	}

	public void setQboard_title(String qboard_title) {
		this.qboard_title = qboard_title;
	}

	public String getQboard_content() {
		return qboard_content;
	}

	public void setQboard_content(String qboard_content) {
		this.qboard_content = qboard_content;
	}



	public String getQboard_privacy() {
		return qboard_privacy;
	}

	public void setQboard_privacy(String qboard_privacy) {
		this.qboard_privacy = qboard_privacy;
	}



	public Date getQboard_date() {
		return qboard_date;
	}

	public void setQboard_date(Date qboard_date) {
		this.qboard_date = qboard_date;
	}

	public int getQboard_view() {
		return qboard_view;
	}

	public void setQboard_view(int qboard_view) {
		this.qboard_view = qboard_view;
	}

}
