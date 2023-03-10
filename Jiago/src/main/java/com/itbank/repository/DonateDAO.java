package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.CompanyDTO;
import com.itbank.model.UserDonateDTO;

@Repository
public interface DonateDAO {

   HashMap<String, UserDonateDTO> selectDonateList();

   int insertUserPoint(HashMap<String, String> hashmap);

   void minusUserPoint(HashMap<String, String> hashmap);

   List<UserDonateDTO> selectDonateHistory();

   List<CompanyDTO> selectSurveyCountByDonate();


   
   
}