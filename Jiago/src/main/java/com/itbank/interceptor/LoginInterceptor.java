package com.itbank.interceptor;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.itbank.model.UserDTO;

public class LoginInterceptor extends HandlerInterceptorAdapter {

   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
         throws Exception {
      
       String requestURI = "";
       
       if(request.getRequestURI() != null) {
          requestURI = request.getRequestURI();
          requestURI = requestURI.substring(7);
          
       }
      
     
      HttpSession session = request.getSession();         
      UserDTO login = (UserDTO)session.getAttribute("login");   
      
      if(login == null) {   // 로그인이 되어 있지 않으면
         response.setContentType("text/html; charset=utf-8");
         PrintWriter out = response.getWriter();
         out.print("<script>alert('로그인이 필요합니다.'); location.href='http://localhost:8080/jiago/user/login?url=" + requestURI + "'</script>");
         out.flush();
         out.close();
         
         return false;   

      }
      
      return true;
   }
}