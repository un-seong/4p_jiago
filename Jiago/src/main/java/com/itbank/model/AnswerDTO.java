package com.itbank.model;

import java.sql.Date;

public class AnswerDTO {
	private int answer_idx;
	private int user_idx;
	private String answer_content;
	private Date answer_date;
	private int question_idx;
	private int survey_idx;
	
	private int count;
	private String question_content;
	
	@Override
	public String toString() {
		String result = String.format("설문번호 : %d, 질문번호 : %d, 질문 : %s, 답변: %s, 결과 : %d", 
									  survey_idx, question_idx, question_content, answer_content, count);
		return result;
	}
	
	
	public AnswerDTO() {
	
	}

	public int getAnswer_idx() {
		return answer_idx;
	}

	public void setAnswer_idx(int answer_idx) {
		this.answer_idx = answer_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getAnswer_content() {
		return answer_content;
	}

	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}

	public Date getAnswer_date() {
		return answer_date;
	}

	public void setAnswer_date(Date answer_date) {
		this.answer_date = answer_date;
	}

	public int getQuestion_idx() {
		return question_idx;
	}

	public void setQuestion_idx(int question_idx) {
		this.question_idx = question_idx;
	}

	public int getSurvey_idx() {
		return survey_idx;
	}

	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
	}
	
	public int getCount() {
		return count;
	}


	public void setCount(int count) {
		this.count = count;
	}


	public String getQuestion_content() {
		return question_content;
	}


	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}
	
	
	
}

