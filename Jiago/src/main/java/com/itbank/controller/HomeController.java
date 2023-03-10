package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.SurveyDTO;
import com.itbank.service.SurveyService;

@Controller
public class HomeController {
	
	@Autowired SurveyService surveyService;

	@GetMapping("/")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("home");
		List<SurveyDTO> list = surveyService.getHomeSurvey();
		mav.addObject("list", list);
		
		HashMap<String, String> dto = surveyService.getTotalDonate();
	      mav.addObject("totalDonate", dto.get("TOTALDONATE"));
	      mav.addObject("totalCount", dto.get("TOTALCOUNT"));
		
		
		return mav;
	}

	
}
