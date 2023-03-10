package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import com.itbank.model.AnswerDTO;
import com.itbank.model.CompanyDTO;
import com.itbank.model.SurveyPreferGenderDTO;
import com.itbank.model.SurveyPreferQuestionDTO;
import com.itbank.model.SurveyQuestionDTO;
import com.itbank.model.SurveyUserDonateRankDTO;
import com.itbank.model.SurveyUserJoinDTO;
import com.itbank.model.UserDonateDTO;
import com.itbank.service.DonateService;
import com.itbank.service.SurveyService;

@RestController
@RequestMapping("/manage")
public class ManageAjaxController {
	
	@Autowired
	private SurveyService surveyService;
	
	@Autowired
	private DonateService donateService;
	
	
	@GetMapping("getSurveyDetailResult/{survey_idx}")
	public JSONObject surveyDetailJson(@PathVariable("survey_idx") int survey_idx) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("survey_idx", survey_idx+"");
		
		List<Integer> list = surveyService.getQuestionIDX(map);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		for(int i = 0; i < list.size(); i++) {
			map.put("question_idx", list.get(i)+"");
			List<AnswerDTO> answerList = surveyService.getSurveyResult(map);
			result.put(i + "", answerList);
		}
		
		JSONObject json = new JSONObject(result);
		return json;
	}
	
	@GetMapping("/getSurveyUserJoin")
	public JSONObject surveyUserJoinJson() {
		
		List<SurveyUserJoinDTO> dto = surveyService.getUserJoin();
		
		HashMap<String, Object> UserJoin = new HashMap<String, Object>();
		
		for(int i = 0; i < dto.size(); i++) {
			UserJoin.put(i+"", dto.get(i));
		}
		
		JSONObject json = new JSONObject(UserJoin);
		return json;
	}
	
	
	@GetMapping("/getSurveyUserDonateRank")
	public JSONObject getSurveyUserDonateRank() {
		
		List<SurveyUserDonateRankDTO> dto = surveyService.getUserDonateRank();
		
		HashMap<String, Object> UserJoin = new HashMap<String, Object>();
		
		for(int i = 0; i < dto.size(); i++) {
			UserJoin.put(i+"", dto.get(i));
		}
		
		JSONObject json = new JSONObject(UserJoin);		
		return json;
	}
	
	@GetMapping("/getSurveyPreferQuestion")
	public JSONObject getSurveyPreferQuestion() {
		
		List<SurveyPreferQuestionDTO> dto = surveyService.getSurveyPreferQuestion();
		
		HashMap<String, Object> UserJoin = new HashMap<String, Object>();
		
		for(int i = 0; i < dto.size(); i++) {
			UserJoin.put(i+"", dto.get(i));
		}
		
		JSONObject json = new JSONObject(UserJoin);		
		return json;
	}
	
	@GetMapping("/getDonateMonth")
	public JSONObject getDonateMonth() {
		
		 List<UserDonateDTO> list = donateService.getDonateHistory();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		for(int i = 0; i < list.size(); i++) {
			map.put(i+"", list.get(i));
		}
	
		JSONObject json = new JSONObject(map);
		
		return json;
	}
	
	 @GetMapping("/getSurveyPreferGender")
	   public JSONObject getSurveyPreferGender() {
	         
	         List<SurveyPreferQuestionDTO> dto = surveyService.getSurveyPreferGender();
	         
	         HashMap<String, Object> preferGender = new HashMap<String, Object>();
	         
	         for(int i = 0; i < dto.size(); i++) {
	            preferGender.put(i+"", dto.get(i));
	         }
	         
	         JSONObject json = new JSONObject(preferGender);
	         return json;
	      }
	
	 @GetMapping("/getSurveyCountByDonate")
	   public JSONObject getSurveyCountByDonate() {
	         
	         List<CompanyDTO> list = donateService.getSurveyCountByDonate();
	         
	         HashMap<String, Object> map = new HashMap<String, Object>();
	         
	         for(int i = 0; i < list.size(); i++) {
	            map.put(i+"", list.get(i));
	         }
	         
	         JSONObject json = new JSONObject(map);
	         return json;
	      }
	 
	 
	 @GetMapping("/getSurveyQuestionRanking")
		public JSONObject surveyQuestionRanking() {
			
			List<SurveyQuestionDTO> list = surveyService.getSurveyQuestionRanking();
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			for(int i = 0; i < list.size(); i++) {
				map.put(i+"", list.get(i));
			}
		
			JSONObject json = new JSONObject(map);
			
			return json;
		}
	 
	 @GetMapping("/getSurveyPreferAge")
		public JSONObject getSurveyPreferAge() {
			
		 	List<SurveyPreferGenderDTO> list = surveyService.getPreferAge();
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			for(int i = 0; i < list.size(); i++) {
				map.put(i+"", list.get(i));
			}
		
			JSONObject json = new JSONObject(map);
			
			return json;
		}
	 
	 @GetMapping("/getSurveyPreferJob")
		public JSONObject getSurveyPreferJob() {
			
		 	List<SurveyPreferGenderDTO> list = surveyService.getsurveyPreferJob();
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			for(int i = 0; i < list.size(); i++) {
				map.put(i+"", list.get(i));
			}
		
			JSONObject json = new JSONObject(map);
			
			return json;
		}
}
