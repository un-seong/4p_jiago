package com.itbank.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class PopUpController {
	
	@RequestMapping("/popUp/pwmodify")
	public String pwmodify() {
		return "user/pwmodify";
	}
	
	@RequestMapping("/popUp/emailCheckMail/{email}")
	public ModelAndView emailCheckMail(@PathVariable("email") String email) {
		ModelAndView mav = new ModelAndView("user/joinCheckEmail");
		mav.addObject("email", email);
		
		return mav;
	}


}
