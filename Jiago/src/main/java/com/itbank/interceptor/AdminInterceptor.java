package com.itbank.interceptor;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.itbank.model.UserDTO;

public class AdminInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();			
		UserDTO login = (UserDTO)session.getAttribute("login");	
		
		if(login.getUser_type().equals("Member")) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('권한이 필요합니다.'); location.href='http://localhost:8080/jiago/';  </script>");
			out.flush();
			out.close();
			
			return false;	

		}
		
		return true;
	}
}
