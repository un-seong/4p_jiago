package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.BoardDTO;
import com.itbank.model.ReplyDTO;

@Repository
public interface BoardDAO {

	List<BoardDTO> selectAll(HashMap<String, Object> param);

	int selectBoardCount();

	void updateViewCount(int qboard_idx);

	BoardDTO selectOne(int qboard_idx);

	int insert(BoardDTO dto);

	int modify(BoardDTO dto);

	int delete(int qboard_idx);

	List<ReplyDTO> selectReplyList(int qboard_idx);

	int insertReply(ReplyDTO dto);


	int replyDelete(int reply_idx);

	List<BoardDTO> search(HashMap<String, Object> param);

	int selectSearchBoardCount(String qboard_title);

	int selectDeleteReply(int qboard_idx);

	int deleteReplyAll(int qboard_idx);

}
