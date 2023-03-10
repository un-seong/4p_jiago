package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.MemberDTO;

@Repository
public interface MemberDAO {
	
	List<MemberDTO> selectAll(HashMap<String, Object> param);

	int selectMemberCount();

	List<MemberDTO> getSearchListAll(HashMap<String, Object> param);

	int selectSearchMemberCount(String user_id);

	int deleteMember(Integer integer);


}
