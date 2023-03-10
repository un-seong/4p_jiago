package com.itbank.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.UserDTO;
import com.itbank.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {
	
	
	@Autowired UserService userService;

	@GetMapping("login")
	public void login() {}
	
	   @PostMapping("login")
	   public ModelAndView login(HttpServletResponse response ,HttpServletRequest request ,HttpSession session, UserDTO account) {
	      ModelAndView mav = new ModelAndView();
	      if(account.getRemember_id() == null) {
	           Cookie cookie = new Cookie("user_id", null);  // 쿠키 값을 null로 설정
	           cookie.setMaxAge(0);  // 남은 만료시간을 0으로 설정
	           response.addCookie(cookie);
	      }
	      
	      
	      
	      UserDTO userAccount = userService.login(account);
	      mav.setViewName("user/result");
	      if(userAccount == null) {
	         mav.addObject("result","아이디 혹은 비밀번호가 잘못되었습니다.");
	         mav.addObject("address","user/login");
	         return mav;
	      }
	      
	      mav.addObject("result","로그인에 성공 했습니다.");
	      session.setAttribute("login", userAccount);   
	      
	      
	      if(account.getRemember_id() != null) {
	         Cookie cookie = new Cookie("user_id", userAccount.getUser_id());
	         cookie.setMaxAge(60 * 60 * 60 * 24);
	         response.addCookie(cookie);
	      }

	      
	      if(session.getAttribute("login") != null) {
	         UserDTO user = (UserDTO)session.getAttribute("login");
	         String userType = user.getUser_type();
	         if(userType.equals("Admin")) {
	            mav.addObject("result","사이트 관리자 "+ user.getUser_name() + "님 접속 되었습니다.");
	            mav.addObject("address","manage/manageHome");
	         }
	      }
	      
	      String url = (String)session.getAttribute("addurl");
	      session.removeAttribute("addurl");
	      if(url != null) {
	         mav.addObject("address",url);
	      }
	      
	      return mav;
	   }
		
		
		
	
	@GetMapping("join") 
	public void join() {}
	
	@PostMapping("join")
	public ModelAndView join(UserDTO user) {
		ModelAndView mav = new ModelAndView("user/result");
		int row = userService.join(user);
		String result = row == 1 ? "회원 가입에 성공했습니다." : "오류가 발생했습니다.";
		mav.addObject("result", result);
		mav.addObject("address", "user/login");
		return mav;
	}
	
	@GetMapping("logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/result");
		session.removeAttribute("login");
		mav.addObject("result","로그아웃에 성공했습니다.");
		return mav;
	}
	
	@GetMapping("findLoginId")
	public void findLoginId() {}
	
	@GetMapping("findLoginPw")
	public void findLoginPw() {}
	
	@GetMapping("pwCheckEmail")
	public ModelAndView pwCheckEmail() {
		ModelAndView mav = new ModelAndView("user/pwCheckEmail");
		List<String> user = userService.getEmailAndPhone();
		
		 mav.addObject("user",user);
		return mav;
	}
	
	@GetMapping("mypageHome")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView("user/mypageHome");
		UserDTO user = (UserDTO) session.getAttribute("login");
		int user_idx = user.getUser_idx();	// session idx 가져오기
		
		String point = userService.getPoint(user_idx);			// 현재 보유 포인트
		
		
		String totalPoint = userService.getTotalPoint(user_idx);	// 사용자 단일 계정 총합 기부
		
		if(point != null) {
			mav.addObject("point",point);
		}
		
		String grade = userService.getGrade(user_idx);	// 등급 책정
		
		int leftPoint = userService.getleftPoint(user_idx);
		mav.addObject("totalPoint",totalPoint);
		mav.addObject("grade",grade);
		mav.addObject("leftPoint",leftPoint);
			
		
		return mav; 
	}
	
	
	@GetMapping("mypageSecurity")
	public ModelAndView mypageSecurity(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		int user_idx = ((UserDTO)(session.getAttribute("login"))).getUser_idx();
		
		UserDTO dto = userService.getUser(user_idx);
		
		mav.addObject("dto", dto);
		
		return mav;
	}
	
	@PostMapping("userModify")
	public ModelAndView userModify(HttpSession session ,UserDTO user) {
		
		ModelAndView mav = new ModelAndView("user/result");
		int row = userService.update(user);
		if(row == 1) {
			mav.addObject("result","회원 정보 수정에 성공했습니다.");
			mav.addObject("address", "/user/mypageSecurity");
		} else {
			mav.addObject("result","오류가 발생했습니다.");
			
		}
		return mav;
	}
	
	@PostMapping("newPasswordSet")
	public ModelAndView newPasswordSet(@RequestParam("password") String first, @RequestParam("passwordCheck") String second) {
		ModelAndView mav = new ModelAndView("user/result");
		if(first.equals(second)) {
			UserDTO user = new UserDTO();
			user.setUser_pw(first);
			int row = userService.newPasswordSet(user);
			if(row == 1) {
				mav.addObject("result","비밀번호가 변경되었습니다.");
				mav.addObject("address","user/login.");
			}
			return mav;
		}
		mav.addObject("result","오류가 발생했습니다.");
		mav.addObject("address","user/findLoginPw");
		return mav;
	}
	
	@GetMapping("mypageQuit")
	public void mypageQuit() {}
	
	@PostMapping("mypageQuit")
	public ModelAndView mypageQuit(HttpSession session, @RequestParam("input_pw") String inputPw) {
		ModelAndView mav = new ModelAndView("user/result");
		String loginPw = (String)((UserDTO)session.getAttribute("login")).getUser_pw();
		
		boolean flag = userService.checkPw(loginPw ,inputPw);
		if(flag) {
			int idx = (int)((UserDTO)session.getAttribute("login")).getUser_idx();
			
			int row = userService.quit(idx);
			if(row == 1) {
				mav.addObject("result","회원 탈퇴가 성공적으로 이뤄졌습니다. 이용해주셔서 감사합니다.");
				session.removeAttribute("login");
				return mav;
			}
		}
		mav.addObject("result","오류가 발생했습니다.");
		mav.addObject("address","user/mypageQuit");
		return mav;
	}
	
}
