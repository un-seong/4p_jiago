package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.Paging;
import com.itbank.model.SurveyDTO;
import com.itbank.model.SurveyExampleDTO;
import com.itbank.model.SurveyQuestionDTO;
import com.itbank.model.UserDTO;
import com.itbank.model.UserDonateDTO;
import com.itbank.service.SurveyService;
import com.itbank.service.UserService;

@Controller
@RequestMapping("/survey")
public class SurveyController {
	
	private int Refresh = 0;

	@Autowired
	private SurveyService surveyService;
	
	@Autowired
	private UserService userService;
	

	@GetMapping("list")
	public ModelAndView list(@RequestParam(defaultValue = "1") Integer page,
			@RequestParam("survey_targetAge") String survey_targetAge,
			@RequestParam("survey_targetGender") String survey_targetGender,
			@RequestParam("survey_targetJob") String survey_targetJob) {

		ModelAndView mav = new ModelAndView();

		int count = 0;
		Paging paging = null;
		List<SurveyDTO> list = null;

		HashMap<String, String> test = new HashMap<String, String>();

		test.put("survey_targetAge", survey_targetAge);
		test.put("survey_targetGender", survey_targetGender);
		test.put("survey_targetJob", survey_targetJob);

		
		if(survey_targetAge == "" && survey_targetGender == "" && survey_targetJob == "") {
			count = surveyService.getSurveyListCount();
		}
		else count = surveyService.getSurveyListFilterCount(test);
		
		paging = new Paging(page, count);

		test.put("paging", paging + "");
		test.put("offset", paging.getOffset() + "");
		test.put("perPage", paging.getPerPage() + "");
		list = surveyService.filterList(test);

		mav.addObject("survey_targetAge", survey_targetAge);
		mav.addObject("survey_targetGender", survey_targetGender);
		mav.addObject("survey_targetJob", survey_targetJob);
		mav.addObject("list", list);
		mav.addObject("paging", paging);

		return mav;
	}

	@GetMapping("surveyDetailPage/{survey_idx}")
	public ModelAndView detail(@PathVariable("survey_idx") int survey_idx) {
		ModelAndView mav = new ModelAndView("/survey/surveyDetailPage");
		SurveyDTO dto = surveyService.getSurveyDetail(survey_idx);
		mav.addObject("dto", dto);
		return mav;
	}

	@GetMapping("surveyStart/{survey_idx}")
	public ModelAndView surveyStart(@PathVariable("survey_idx") int survey_idx, HttpSession session) {
		ModelAndView mav = new ModelAndView("/survey/surveyStart");
		List<SurveyQuestionDTO> list = surveyService.getSurveyQuestion(survey_idx);
		List<SurveyExampleDTO> exList = surveyService.getSurveyExample(survey_idx);
		
		int user_idx = ((UserDTO)session.getAttribute("login")).getUser_idx();
		
		HashMap<String, Integer> hash = new HashMap<String, Integer>();
		hash.put("survey_idx", survey_idx);
		hash.put("user_idx", user_idx);
		
		int row = surveyService.judge(hash);
		
		if(row > 1) {
			ModelAndView mav1 = new ModelAndView("user/result");
			String result = "이미 설문에 참여 하였습니다";
			mav1.addObject("result", result);
			mav1.addObject("address", "survey/list?survey_targetAge=&survey_targetGender=&survey_targetJob=");
			return mav1;
		}
		
		mav.addObject("list", list);
		mav.addObject("exList", exList);

		return mav;
	}

	@GetMapping("surveyComplete/{survey_idx}")
	public ModelAndView surveyComplete(@PathVariable("survey_idx") int survey_idx, HttpSession session) {
		ModelAndView mav = new ModelAndView("/survey/surveyComplete");
		UserDTO login = (UserDTO) session.getAttribute("login");
		
		String userName = login.getUser_name();
		int user_idx = login.getUser_idx();

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("survey_idx", survey_idx);
		resultMap.put("user_idx", user_idx);

		int userPoint = surveyService.addpoint(resultMap); // 포인트 적립
		int getPoint = surveyService.getUserPoint(user_idx); // 적립 포인트 들고 오기
		

		mav.addObject("userName", userName);
		mav.addObject("userPoint", getPoint);
		return mav;
	}


	@GetMapping("surveyAdd")
	public void surveyAdd() {
	}

	@PostMapping("surveyAdd")
	public String surveyAdd(SurveyDTO dto) {
		int row = surveyService.insertSurvey(dto);

		int surveyIdx = surveyService.selectSurveyIdx();

		return "redirect:/survey/surveyQuestionAdd/" + surveyIdx;
	}

	@GetMapping("surveyQuestionAdd/{surveyIdx}")
	public ModelAndView surveyQuestionAdd(@PathVariable("surveyIdx") int surveyIdx) {
		ModelAndView mav = new ModelAndView("/survey/surveyQuestionAdd");
		List<SurveyQuestionDTO> list = surveyService.selectQuestionList();
		mav.addObject("list", list);

		return mav;
	}
	
	@PostMapping("surveyComplete")
	   public String surveyPointComplete(UserDonateDTO dto) {

	      int row = surveyService.addUserDonate(dto);
	      int minus = surveyService.minusUserPoint(dto);
	      int row2 = userService.setGrade(dto.getUser_idx());            // DB에 등급 업데이트
	      return "redirect:/";
	   }
	

	@GetMapping("surveyManage")
	public ModelAndView surveyManage(@RequestParam(defaultValue = "1") Integer page) {

		ModelAndView mav = new ModelAndView();

		int count = surveyService.getSurveyCount();
		Paging paging = new Paging(page, count);

		

		List<SurveyDTO> list = surveyService.selectAllList(paging);

		mav.addObject("list", list);
		mav.addObject("paging", paging);

		return mav;
	}

	@GetMapping("surveyView/{survey_idx}")
	public ModelAndView view(@PathVariable("survey_idx") int survey_idx) {
		ModelAndView mav = new ModelAndView("/survey/surveyView");
		SurveyDTO dto = surveyService.getSurveyDetail(survey_idx);
		mav.addObject("dto", dto);

		List<SurveyQuestionDTO> list = surveyService.getSurveyQuestion(survey_idx);
		List<SurveyExampleDTO> exList = surveyService.getSurveyExample(survey_idx);

		mav.addObject("list", list);
		mav.addObject("exList", exList);

		return mav;
	}

	@GetMapping("surveyModify/{survey_idx}")
	public ModelAndView modifyInfo(@PathVariable("survey_idx") int survey_idx) {
		ModelAndView mav = new ModelAndView("/survey/surveyModify");
		SurveyDTO dto = surveyService.getSurveyDetail(survey_idx);
		mav.addObject("dto", dto);

		List<SurveyQuestionDTO> list = surveyService.getSurveyQuestion(survey_idx);
		List<SurveyExampleDTO> exList = surveyService.getSurveyExample(survey_idx);

		mav.addObject("list", list);
		mav.addObject("exList", exList);

		return mav;
	}

	@PostMapping("surveyModify/{survey_idx}")
	public String modify(SurveyDTO dto) {
		int row = surveyService.modifySurvey(dto);

		return "redirect:/survey/surveyView/{survey_idx}";
	}
	

	
	
	
	
}
