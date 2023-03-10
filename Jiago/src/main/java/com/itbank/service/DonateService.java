package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.CompanyDTO;
import com.itbank.model.UserDonateDTO;
import com.itbank.repository.DonateDAO;

@Service
public class DonateService {

   @Autowired DonateDAO donateDAO;


   public HashMap<String, UserDonateDTO> getDonateList() {
      return donateDAO.selectDonateList();
   }


   public int addUserPoint(HashMap<String, String> hashmap) {
      return donateDAO.insertUserPoint(hashmap);
   }


   public void minusUserPoint(HashMap<String, String> hashmap) {
      donateDAO.minusUserPoint(hashmap);      
   }


public List<UserDonateDTO> getDonateHistory() {
	return donateDAO.selectDonateHistory();
}


public List<CompanyDTO> getSurveyCountByDonate() {
	return donateDAO.selectSurveyCountByDonate();
}

   
   
   
   
}