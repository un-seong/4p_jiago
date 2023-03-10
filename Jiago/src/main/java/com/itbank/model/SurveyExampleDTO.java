package com.itbank.model;

public class SurveyExampleDTO {
	
	private int example_idx;
	private int survey_idx;
	private int question_idx;
	private String example_content;
	
	public SurveyExampleDTO() {
		
	}

	public int getExample_idx() {
		return example_idx;
	}

	public void setExample_idx(int example_idx) {
		this.example_idx = example_idx;
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

	public String getExample_content() {
		return example_content;
	}

	public void setExample_content(String example_content) {
		this.example_content = example_content;
	}
	
	
	
}
