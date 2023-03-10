package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.CompanyDTO;
import com.itbank.model.Paging;
import com.itbank.repository.CompanyDAO;

@Service
public class CompanyService {
   
   @Autowired private CompanyDAO dao;

   public int getCompanySearchCount(String company_name) {
      return dao.selectSearchCompanyCount(company_name);
   }

   public List<CompanyDTO> getSearchListAll(String company_name, Paging paging) {
      HashMap<String, Object> param = new HashMap<String, Object>();
      param.put("offset", paging.getOffset());
      param.put("perPage", paging.getPerPage());
      param.put("company_name", company_name);
      
      return dao.getSearchListAll(param);
   }

   public int getCompanyCount() {
      return dao.selectCompanyCount();
   }

   public List<CompanyDTO> getListAll(Paging paging) {
      HashMap<String, Object> param = new HashMap<String, Object>();
      
      param.put("offset", paging.getOffset());
      param.put("perPage", paging.getPerPage());
      return dao.selectAll(param);
   }

   public int modifyCompany(CompanyDTO dto) {
      return dao.modifyCompany(dto);
   }

   public int insertCompany(CompanyDTO dto) {
      return dao.insertCompany(dto);
   }

   public CompanyDTO getCompanyDetail(int company_idx) {
      
      return dao.selectOneDetail(company_idx);
   }


   public int deleteCompany(List<Integer> numbers) {
      int row = 0;
         
      for(int i = 0; i< numbers.size(); i++) {
         row = dao.deleteCompany(numbers.get(i));
      }
      
      
      return row;
   }



}