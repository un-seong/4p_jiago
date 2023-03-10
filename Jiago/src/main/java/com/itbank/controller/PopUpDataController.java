package com.itbank.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.UserDTO;
import com.itbank.service.UserService;

@RestController
@RequestMapping("popUp")
public class PopUpDataController {

	@Autowired UserService userService;
	
	@PostMapping("pwUpdate")
	public int pwUpdate(HttpSession session , @RequestBody HashMap<String, String> param) {
		String modifyPw = param.get("modifyPw");
		
		String checkPw = param.get("checkPw");
		
		int idx = Integer.parseInt(param.get("idx"));
		if(modifyPw.equals(checkPw)) {
			session.removeAttribute("login");
			UserDTO user = new UserDTO();
			user.setUser_idx(idx);
			user.setUser_pw(modifyPw);
			int row = userService.pwUpdate(user);
			return row;
		}
		return 0;
	}

	@PostMapping("pwCheck") 
	public int pwCheck(@RequestBody HashMap<String, String> param) {
		return userService.pwCheck(param);
	}
		
		
	
	
	
	
}
