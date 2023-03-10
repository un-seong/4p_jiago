package com.itbank.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.itbank.service.CompanyService;
import com.itbank.service.MemberService;

@RestController
public class MemberAjaxController {

   
   @Autowired MemberService memberService;
   @Autowired CompanyService companyService;
   
   @PostMapping("/memberAjax")
   public String memberAjax(@RequestBody String ob) throws JsonMappingException, JsonProcessingException {
      
     
      //   정규표현식을 이용하여 숫자 추출
       Pattern pattern = Pattern.compile("\\d+");
       Matcher matcher = pattern.matcher(ob);

       List<Integer> numbers = new ArrayList<>();
              
       while (matcher.find()) {
           // 추출된 숫자를 Integer 형태로 변환하여 리스트에 추가
           int number = Integer.parseInt(matcher.group());
           numbers.add(number);
       }
       
       int row = memberService.deleteMember(numbers);
       
      return row == 1 ? "성공하였습니다." : "실패하였습니다.";
   }
   
   
   
   @PostMapping("/memberAjax/company")
   public String memberAjaxCompany(@RequestBody String ob) throws JsonMappingException, JsonProcessingException {
      
     
      //   정규표현식을 이용하여 숫자 추출
       Pattern pattern = Pattern.compile("\\d+");
       Matcher matcher = pattern.matcher(ob);

       List<Integer> numbers = new ArrayList<>();
              
       while (matcher.find()) {
           // 추출된 숫자를 Integer 형태로 변환하여 리스트에 추가
           int number = Integer.parseInt(matcher.group());
           numbers.add(number);
           
       }
      
       int row = companyService.deleteCompany(numbers);
       
      return row == 1 ? "성공하였습니다." : "실패하였습니다.";
   }
   
   

}