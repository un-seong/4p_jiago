package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.Paging;
import com.itbank.model.SurveyDTO;
import com.itbank.model.SurveyPreferGenderDTO;
import com.itbank.model.SurveyPreferQuestionDTO;
import com.itbank.service.SurveyService;

@Controller
@RequestMapping("/manage")
public class ManageController {
	
	@Autowired
	private SurveyService surveyService;

	@GetMapping("manageHome")
	public void manageHome() {}
	
	@GetMapping("surveyResultList")
	public ModelAndView surveyResultList(@RequestParam(defaultValue = "1") Integer page) {

		ModelAndView mav = new ModelAndView();

		int count = surveyService.getSurveyCount();
		Paging paging = new Paging(page, count);

		List<SurveyDTO> list = surveyService.selectAllList(paging);

		mav.addObject("list", list);
		mav.addObject("paging", paging);

		return mav;
	}
	
	@GetMapping("surveyDetailResult/{survey_idx}")
	public ModelAndView surveyDetailResult(@PathVariable("survey_idx") int survey_idx) {
		
		ModelAndView mav = new ModelAndView("/manage/surveyDetailResult");
		
		mav.addObject("survey_idx", survey_idx);
		
		return mav;
	}
	
	@GetMapping("surveyUserJoin")
	public ModelAndView surveyUserJoin() {
		ModelAndView mav = new ModelAndView("/manage/surveyUserJoin");
		
		return mav;
	}
	
	@GetMapping("surveyUserDonateRank")
	public ModelAndView surveyUserDonateRank() {
		ModelAndView mav = new ModelAndView("/manage/surveyUserDonateRank");
		
		return mav;
	}
	
	@GetMapping("surveyPreferQuestion")
	public ModelAndView surveyPreferQuestion() {
		ModelAndView mav = new ModelAndView("/manage/surveyPreferQuestion");
		
		List<SurveyPreferQuestionDTO> list = surveyService.getSurveyPreferQuestion();
		
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping("donateMonth")
	public ModelAndView donateMonth() {
		ModelAndView mav = new ModelAndView("/manage/donateMonth");
		
		return mav;
	}
	
	@GetMapping("surveyPreferGender")
	   public ModelAndView surveyPreferGender() {
	      ModelAndView mav = new ModelAndView("/manage/surveyPreferGender");
	      
	      return mav;
	   }
	
	@GetMapping("surveyCountByCompany")
	   public ModelAndView surveyCountByCompany() {
	      ModelAndView mav = new ModelAndView("/manage/surveyCountByCompany");
	      
	      return mav;
	   }
	
	@GetMapping("surveyQuestionRanking")
	   public ModelAndView surveyQuestionRanking() {
	      ModelAndView mav = new ModelAndView("/manage/surveyQuestionRanking");
	      
	      return mav;
	   }
	
	@GetMapping("surveyPreference")
	   public ModelAndView surveyPreference() {
	      ModelAndView mav = new ModelAndView();
	      
	      return mav;
	   }
	
	@GetMapping("surveyPreferAge")
	   public ModelAndView surveyPreferAge() {
	      ModelAndView mav = new ModelAndView("/manage/surveyPreferAge");
	      
	      List<SurveyPreferGenderDTO> list = surveyService.getPreferAge();
	      
	      mav.addObject("list", list);
	         
	      return mav;
	   }
	
	@GetMapping("surveyPreferJob")
	   public ModelAndView surveyPreferJob() {
	      ModelAndView mav = new ModelAndView("/manage/surveyPreferJob");
	      
	      List<SurveyPreferGenderDTO> list = surveyService.getsurveyPreferJob();
	      
	      mav.addObject("list", list);
	         
	      return mav;
	   }
}


