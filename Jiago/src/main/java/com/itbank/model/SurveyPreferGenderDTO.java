package com.itbank.model;

public class SurveyPreferGenderDTO {

   private String user_gender;
   private String survey_title;
   private int count;
   private int ranking;
   
   private String age_range;
   private String user_job;
   
   
   public String getUser_gender() {
      return user_gender;
   }
   public void setUser_gender(String user_gender) {
      this.user_gender = user_gender;
   }
   public String getSurvey_title() {
      return survey_title;
   }
   public void setSurvey_title(String survey_title) {
      this.survey_title = survey_title;
   }
   public int getCount() {
      return count;
   }
   public void setCount(int count) {
      this.count = count;
   }
   public int getRanking() {
      return ranking;
   }
   public void setRanking(int ranking) {
      this.ranking = ranking;
   }
public String getAge_range() {
	return age_range;
}
public void setAge_range(String age_range) {
	this.age_range = age_range;
}
public String getUser_job() {
	return user_job;
}
public void setUser_job(String user_job) {
	this.user_job = user_job;
}
   
   
   
}
