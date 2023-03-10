package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.CompanyDTO;
import com.itbank.model.Paging;
import com.itbank.service.CompanyService;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	@Autowired private CompanyService companyService;
	
	@GetMapping("/list")
	public ModelAndView list(@RequestParam(defaultValue = "1") Integer page, @RequestParam("company_name") String company_name) {
		ModelAndView mav = new ModelAndView();
		
		int companyCount = 0;
		Paging paging = null;
		List<CompanyDTO> list = null;
		
		if(company_name != "") {
			companyCount = companyService.getCompanySearchCount(company_name);
			paging = new Paging(page, companyCount);
			list = companyService.getSearchListAll(company_name, paging);
		}
		else {
			companyCount = companyService.getCompanyCount();
			paging = new Paging(page, companyCount);
			list = companyService.getListAll(paging);
			
		}
		mav.addObject("company_name", company_name);
		mav.addObject("list",list);
		mav.addObject("paging", paging);
		
		
		return mav;
	}
	
	@GetMapping("add")
	public void companyadd() {}
	
	@PostMapping("add")
	public String add(CompanyDTO dto) {
		int row = companyService.insertCompany(dto);
		return "redirect:/company/list?company_name=";
	}
	
	@GetMapping("/modify/{company_idx}")
	public ModelAndView modifyInfo(@PathVariable("company_idx") int company_idx) {
		ModelAndView mav = new ModelAndView("/company/modify");
		CompanyDTO dto = companyService.getCompanyDetail(company_idx);
		
		mav.addObject("dto", dto);
		return mav;
		
	}
	@PostMapping("/modify/{company_idx}")
	public String modify(CompanyDTO dto) {
		int row = companyService.modifyCompany(dto);
		
		return "redirect:/company/list?company_name=";
	}
	
	
}
