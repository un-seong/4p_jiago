package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.BoardDTO;
import com.itbank.model.Paging;
import com.itbank.model.ReplyDTO;
import com.itbank.repository.BoardDAO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO dao;

	public List<BoardDTO> getListAll(Paging paging) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		param.put("offset", paging.getOffset());
		param.put("perPage", paging.getPerPage());
		return dao.selectAll(param);
	}
	public List<BoardDTO> search(String qboard_title, Paging paging) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("offset", paging.getOffset());
		param.put("perPage", paging.getPerPage());
		param.put("qboard_title",qboard_title);
		
		return dao.search(param);

	}

	public int getBoardCount() {
		return dao.selectBoardCount();
	}

	public BoardDTO get(int qboard_idx) {
		dao.updateViewCount(qboard_idx);
		return dao.selectOne(qboard_idx);
	}

	public int write(BoardDTO dto) {
		
		return dao.insert(dto);
	}

	public int modify(BoardDTO dto) {
		return dao.modify(dto);
	}

	public int delete(int qboard_idx) {
		return dao.delete(qboard_idx);
	}

	public List<ReplyDTO> getReplyList(int qboard_idx) {
		return dao.selectReplyList(qboard_idx);
	}

	public int writeReply(ReplyDTO dto) {
		return dao.insertReply(dto);
	}

	public int replyDelete(int reply_idx) {
		return dao.replyDelete(reply_idx);
	}
	public int getBoardSearchCount(String qboard_title) {
		return dao.selectSearchBoardCount(qboard_title);
	}
	public int selectDeleteReply(int qboard_idx) {
		return dao.selectDeleteReply(qboard_idx);
	}
	
	public int deleteReplyAll(int qboard_idx) {
		return dao.deleteReplyAll(qboard_idx);
	}

}
