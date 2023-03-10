package com.itbank.model;

//		SURVEY_IDX          NOT NULL NUMBER         
//		COMPANY_IDX                  NUMBER         
//		SURVEY_TITLE        NOT NULL VARCHAR2(100)  
//		SURVEY_DATE         NOT NULL VARCHAR2(500)  
//		SURVEY_POINT                 NUMBER         
//		SURVEY_TIME         NOT NULL VARCHAR2(100)  
//		SURVEY_TARGETAGE             VARCHAR2(100)  
//		SURVEY_TARGETGENDER          VARCHAR2(100)  
//		SURVEY_INFO         NOT NULL VARCHAR2(3000) 
//		SURVEY_DELETE                VARCHAR2(10)   

public class SurveyDTO {
	private int survey_idx;
	private int company_idx;
	private String survey_title;
	private String survey_date;
	private int survey_point;
	private String survey_time;
	private String survey_targetAge;
	private String survey_targetGender;
	private String survey_targetJob;
	private String survey_info;
	private String survey_delete;
	
	public SurveyDTO() {
		
	}

	public int getSurvey_idx() {
		return survey_idx;
	}

	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
	}

	public int getCompany_idx() {
		return company_idx;
	}

	public void setCompany_idx(int company_idx) {
		this.company_idx = company_idx;
	}

	public String getSurvey_title() {
		return survey_title;
	}

	public void setSurvey_title(String survey_title) {
		this.survey_title = survey_title;
	}

	public String getSurvey_date() {
		return survey_date;
	}

	public void setSurvey_date(String survey_date) {
		this.survey_date = survey_date;
	}

	public int getSurvey_point() {
		return survey_point;
	}

	public void setSurvey_point(int survey_point) {
		this.survey_point = survey_point;
	}

	public String getSurvey_time() {
		return survey_time;
	}

	public void setSurvey_time(String survey_time) {
		this.survey_time = survey_time;
	}

	public String getSurvey_targetAge() {
		return survey_targetAge;
	}

	public void setSurvey_targetAge(String survey_targetAge) {
		this.survey_targetAge = survey_targetAge;
	}

	public String getSurvey_targetGender() {
		return survey_targetGender;
	}

	public void setSurvey_targetGender(String survey_targetGender) {
		this.survey_targetGender = survey_targetGender;
	}

	public String getSurvey_targetJob() {
		return survey_targetJob;
	}

	public void setSurvey_targetJob(String survey_targetJob) {
		this.survey_targetJob = survey_targetJob;
	}

	public String getSurvey_info() {
		return survey_info;
	}

	public void setSurvey_info(String survey_info) {
		this.survey_info = survey_info;
	}

	public String getSurvey_delete() {
		return survey_delete;
	}

	public void setSurvey_delete(String survey_delete) {
		this.survey_delete = survey_delete;
	}
	
	
	
	

}
