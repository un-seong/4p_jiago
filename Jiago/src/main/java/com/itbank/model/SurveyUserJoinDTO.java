package com.itbank.model;

public class SurveyUserJoinDTO {

	
	private int user_idx;
	private String user_name;
	private int survey_participation_rate;
	
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getSurvey_participation_rate() {
		return survey_participation_rate;
	}
	public void setSurvey_participation_rate(int survey_participation_rate) {
		this.survey_participation_rate = survey_participation_rate;
	}
	
	
}
