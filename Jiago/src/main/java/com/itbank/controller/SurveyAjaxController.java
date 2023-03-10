package com.itbank.controller;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.model.AnswerDTO;
import com.itbank.model.SurveyExampleDTO;
import com.itbank.model.SurveyFormDTO;
import com.itbank.model.SurveyQuestionDTO;
import com.itbank.service.SurveyService;

@RestController
public class SurveyAjaxController {
   
   @Autowired SurveyService surveyService;
   
   @PostMapping("/survey/surveyAnswer/{survey_idx}")
   public int surveyAnswer(@RequestBody HashMap<String, Object> ob, @PathVariable("survey_idx") int survey_idx) {

      ob.put("survey_idx", survey_idx);

      
      int user_idx = Integer.parseInt((String) ob.get("user_idx"));
      @SuppressWarnings("unchecked")
      List<String> answerList = (List<String>) ob.get("answer_content");
      String answer_content = "";
      
      for(int i = 0; i < answerList.size(); i++) {
         if(i == answerList.size() - 1) {
            answer_content += answerList.get(i);
         }
         else { 
            answer_content += answerList.get(i) + ",";
         }
         
      }
      
      
      HashMap<String, String> map = new HashMap<String, String>();
      
      map.put("survey_idx", survey_idx + "");
      map.put("user_idx", ob.get("user_idx") + "");
      map.put("answer_content", answer_content);
      
      int row = surveyService.addAnswer(map);
   
      List<Integer> questionIdx = new ArrayList<Integer>(); 
      questionIdx = surveyService.getQuestionIDX(map);


      
      HashMap<String, Object> resultMap = new HashMap<String, Object>();
      resultMap.put("survey_idx", survey_idx);
      resultMap.put("user_idx", ob.get("user_idx"));
      resultMap.put("questionIdx", questionIdx);

      
      int answerSub = surveyService.answerSubstr(resultMap);
      int deleteAnswerResult = surveyService.deleteAnswerResult(resultMap);

      
      return answerSub;
   }
   
  
   
   @PostMapping("/survey/surveyQuestionAdd/{survey_idx}")
   public String surveyQuestionAdd(@RequestBody String question, @PathVariable("survey_idx") int survey_idx) throws JsonMappingException, JsonProcessingException {
	   

	   
	   ObjectMapper mapper = new ObjectMapper();
	   List<SurveyFormDTO> list = mapper.readValue(question, new TypeReference<List<SurveyFormDTO>>() {});
	   
	   
	   int row = surveyService.addQuestion(list, survey_idx);
	   
	   return "설문이 추가되었습니다.";
   }
   
      
   @GetMapping("/survey/surveyQuestionModify/{survey_idx}")
   public ModelAndView surveyQuestionUpdate(@PathVariable("survey_idx") int survey_idx) {
	   ModelAndView mav = new ModelAndView("/survey/surveyQuestionModify");
	   List<SurveyQuestionDTO> list = surveyService.selectQuestionList();
	   mav.addObject("list", list);

	   List<SurveyQuestionDTO> qList = surveyService.getSurveyQuestion(survey_idx);
	   List<SurveyExampleDTO> exList = surveyService.getSurveyExample(survey_idx);
	   
	   mav.addObject("qList", qList);
	   mav.addObject("exList", exList);
	   return mav;
   }
 
   
   @PostMapping("/survey/surveyQuestionModify/{survey_idx}")
   public String surveyQuestionModify(@RequestBody String question, @PathVariable("survey_idx") int survey_idx) throws JsonMappingException, JsonProcessingException {  
	   
	   
	   
	   ObjectMapper mapper = new ObjectMapper();
	   List<SurveyFormDTO> list = mapper.readValue(question, new TypeReference<List<SurveyFormDTO>>() {});
	   
	   
	   int row = surveyService.modifyQuestion(list, survey_idx);
		  
	   return "설문이 수정되었습니다.";
   }
      
   
   @GetMapping("/survey/surveyDelete/{survey_idx}")
   public String surveyDelete(@PathVariable("survey_idx") int survey_idx) {
	   int row = surveyService.deleteSurvey(survey_idx);
	   
	   return "설문이 삭제 되었습니다.";
   }

   @ExceptionHandler({SQLIntegrityConstraintViolationException.class})
   public String databaseError() {
	   
   return "이미 질문 리스트에 등록 된 질문 입니다.";
}
   
   
   
   
}
























