package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.MemberDTO;
import com.itbank.model.Paging;
import com.itbank.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired private MemberService memberService;
	
	@GetMapping("/list")
	public ModelAndView list(@RequestParam(defaultValue = "1") Integer page, @RequestParam("user_id") String user_id) {
		ModelAndView mav = new ModelAndView();
		
		int memberCount = 0;
		Paging paging = null;
		
		List<MemberDTO> list = null;
		
		if(user_id != "") {
			memberCount = memberService.getMemberSearchCount(user_id);
			paging = new Paging(page, memberCount);
			list = memberService.getSearchListAll(user_id, paging);
			
		}
		else {
			memberCount = memberService.getMemberCount();
			paging = new Paging(page, memberCount);
			list = memberService.getListAll(paging);
		}
		
		mav.addObject("user_id", user_id);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		
		return mav;
	}
	
}
