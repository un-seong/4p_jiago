package com.itbank.model;

public class SurveyPreferQuestionDTO {

	private String company_name;
	private String question_content;
	private int preference_count;
	
	
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getQuestion_content() {
		return question_content;
	}
	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}
	public int getPreference_count() {
		return preference_count;
	}
	public void setPreference_count(int preference_count) {
		this.preference_count = preference_count;
	}
	
	
	
}
