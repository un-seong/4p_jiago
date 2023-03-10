package com.itbank.model;

import java.util.List;

public class SurveyFormDTO {
	private int question_idx;
	private String question_content;
	private List<String> example_content;
	
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
	public List<String> getExample_content() {
		return example_content;
	}
	public void setExample_content(List<String> example_content) {
		this.example_content = example_content;
	}
	
	@Override
	public String toString() {
		return String.format("%d, %s, %s", question_idx, question_content, example_content);
	}
}
