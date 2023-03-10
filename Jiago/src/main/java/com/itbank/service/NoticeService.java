package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.NoticeDTO;
import com.itbank.model.Paging;
import com.itbank.repository.NoticeDAO;

@Service
public class NoticeService {
   
   @Autowired private NoticeDAO dao;

   public List<NoticeDTO> getListAll(Paging paging) {
	   HashMap<String, Object> param = new HashMap<String, Object>();
	   		
	   		param.put("offset", paging.getOffset());
	   		param.put("perPage", paging.getPerPage());
	   		return dao.selectAll(param);
	   	}
	   	public List<NoticeDTO> search(String notice_name, Paging paging) {
	   		HashMap<String, Object> param = new HashMap<String, Object>();
	   		param.put("offset", paging.getOffset());
	   		param.put("perPage", paging.getPerPage());
	   		param.put("notice_name",notice_name);
	   		
	   		return dao.search(param);

	   	}
   
   public int getNoticeCount() {
      return dao.selectNoticeCount();
   }

   

   public int write(NoticeDTO dto) {
      
      return dao.insert(dto);
   }

   public NoticeDTO get(int notice_idx) {
      
      return dao.selectOne(notice_idx);
   }

   public int modify(NoticeDTO dto) {
      return dao.modify(dto);
   }

   public int delete(int notice_idx) {
      return dao.delete(notice_idx);
   }
public int getNoticeSearchCount(String notice_name) {
	
	return dao.selectSearchNoticeCount(notice_name);
}


   
	
   
   


}