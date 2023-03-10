package com.itbank.model;

import java.sql.Date;

//USER_IDX      NOT NULL NUMBER        
//USER_ID       NOT NULL VARCHAR2(100) 
//USER_PW       NOT NULL VARCHAR2(100) 
//USER_NAME     NOT NULL VARCHAR2(100) 
//USER_BIRTH    NOT NULL DATE          
//USER_GENDER   NOT NULL VARCHAR2(10)  
//USER_ADDRESS  NOT NULL VARCHAR2(200) 
//USER_PHONE             VARCHAR2(20)  
//USER_EMAIL             VARCHAR2(100) 
//USER_JOB      NOT NULL VARCHAR2(100) 
//USER_TYPE              VARCHAR2(10)  
//USER_JOINDATE          DATE          
//USER_WITHDRAW          VARCHAR2(10)  
//USER_AGREE             VARCHAR2(10)

public class MemberDTO {
	private int user_idx;
	private String user_withdraw;
	private String user_id;
	private String user_pw;
	private String user_name;
	private Date user_birth;
	private String user_gender;
	private String user_address;
	private String user_phone;
	private String user_email;
	private String user_job;
	private String user_type;
	private Date user_joindate;
	private String user_agree;

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public Date getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(Date user_birth) {
		this.user_birth = user_birth;
	}

	public String getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_job() {
		return user_job;
	}

	public void setUser_job(String user_job) {
		this.user_job = user_job;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public Date getUser_joindate() {
		return user_joindate;
	}

	public void setUser_joindate(Date user_joindate) {
		this.user_joindate = user_joindate;
	}

	public String getUser_withdraw() {
		return user_withdraw;
	}
	

	public void setUser_withdraw(String user_withdraw) {
		this.user_withdraw = user_withdraw;
	}

	public String getUser_agree() {
		return user_agree;
	}

	public void setUser_agree(String user_agree) {
		this.user_agree = user_agree;
	}

}
