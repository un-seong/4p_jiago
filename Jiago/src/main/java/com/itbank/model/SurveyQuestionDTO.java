package com.itbank.model;

	//SURVEY_QUESTION_IDX NOT NULL NUMBER        
	//SURVEY_IDX                   NUMBER        
	//QUESTION_IDX                 NUMBER        
	//QUESTION_CONTENT             VARCHAR2(200) 

public class SurveyQuestionDTO {

	private int survey_question_idx;
	private int survey_idx;
	private int question_idx;
	private String question_content;
	
	private int count;
	
	
	public int getSurvey_question_idx() {
		return survey_question_idx;
	}
	public void setSurvey_question_idx(int survey_question_idx) {
		this.survey_question_idx = survey_question_idx;
	}
	public int getSurvey_idx() {
		return survey_idx;
	}
	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
	}
	public int getQuestion_idx() {
		return question_idx;
	}
	public void setQuestion_idx(int question_idx) {
		this.question_idx = question_idx;
	}
	public String getQuestion_content() {
		return question_content;
	}
	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
}
