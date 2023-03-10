package com.itbank.model;

//COMPANY_IDX       NOT NULL NUMBER        
//COMPANY_ID        NOT NULL VARCHAR2(30)  
//COMPANY_NAME      NOT NULL VARCHAR2(100) 
//COMPANY_NUM       NOT NULL VARCHAR2(20)  
//COMPANY_REGISTNUM NOT NULL VARCHAR2(50)  
//COMPANY_ADDRESS   NOT NULL VARCHAR2(100) 
//COMPANY_EMAIL     NOT NULL VARCHAR2(100) 

public class CompanyDTO {
	private int company_idx;
	private String company_id;
	private String company_name;
	private String company_num;
	private String company_registnum;
	private String company_address;
	private String company_email;
	private String company_delete;
	
	private int count;
	
	public int getCompany_idx() {
		return company_idx;
	}

	public void setCompany_idx(int company_idx) {
		this.company_idx = company_idx;
	}

	public String getCompany_id() {
		return company_id;
	}

	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getCompany_num() {
		return company_num;
	}

	public void setCompany_num(String company_num) {
		this.company_num = company_num;
	}

	public String getCompany_registnum() {
		return company_registnum;
	}

	public void setCompany_registnum(String company_registnum) {
		this.company_registnum = company_registnum;
	}

	public String getCompany_address() {
		return company_address;
	}

	public void setCompany_address(String company_address) {
		this.company_address = company_address;
	}

	public String getCompany_email() {
		return company_email;
	}

	public void setCompany_email(String company_email) {
		this.company_email = company_email;
	}

	public String getCompany_delete() {
		return company_delete;
	}

	public void setCompany_delete(String company_delete) {
		this.company_delete = company_delete;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

}
