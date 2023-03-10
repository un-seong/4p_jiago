package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.MemberDTO;
import com.itbank.model.Paging;
import com.itbank.repository.MemberDAO;

@Service
public class MemberService {
	
	@Autowired private MemberDAO dao;

	public List<MemberDTO> getListAll(Paging paging) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		param.put("offset", paging.getOffset());
		param.put("perPage", paging.getPerPage());
		
		return dao.selectAll(param);
	}
	
	public int getMemberCount() {
		return dao.selectMemberCount();
	}

	public int getMemberSearchCount(String user_id) {
		return dao.selectSearchMemberCount(user_id);
	}

	public List<MemberDTO> getSearchListAll(String user_id, Paging paging) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("offset", paging.getOffset());
		param.put("perPage", paging.getPerPage());
		param.put("user_id", user_id);
		
		return dao.getSearchListAll(param);

	}

	public int deleteMember(List<Integer> numbers) {
		int row = 0;
	
		
		for(int i = 0; i< numbers.size(); i++) {
			row = dao.deleteMember(numbers.get(i));
		}
		return row;
	}


}
