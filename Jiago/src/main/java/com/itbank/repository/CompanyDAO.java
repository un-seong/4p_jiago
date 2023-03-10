package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import com.itbank.model.CompanyDTO;

public interface CompanyDAO {

	List<CompanyDTO> selectAll(HashMap<String, Object> param);

	List<CompanyDTO> getSearchListAll(HashMap<String, Object> param);

	int selectSearchCompanyCount(String company_name);

	int selectCompanyCount();

	int modifyCompany(CompanyDTO dto);

	int insertCompany(CompanyDTO dto);

	CompanyDTO selectOneDetail(int company_idx);

	int deleteCompany(int company_idx);

}
