package com.itbank.model;

//REPLY_IDX     NOT NULL NUMBER         
//QBOARD_IDX    NOT NULL NUMBER         
//USER_IDX      NOT NULL NUMBER         
//ADMIN_ID      NOT NULL VARCHAR2(200)  
//REPLY_CONTENT NOT NULL VARCHAR2(2000)

public class ReplyDTO {
	private int reply_idx;
	private int qboard_idx;
	private int user_idx;
	private String admin_id;
	private String reply_content;

	public int getReply_idx() {
		return reply_idx;
	}

	public void setReply_idx(int reply_idx) {
		this.reply_idx = reply_idx;
	}

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

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

}
