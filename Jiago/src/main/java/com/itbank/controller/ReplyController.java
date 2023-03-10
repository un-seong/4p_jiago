package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.ReplyDTO;
import com.itbank.service.BoardService;

@RestController
@RequestMapping("/board/reply")

public class ReplyController {
	
	@Autowired private BoardService boardService;
	
	@GetMapping("/{qboard_idx}")
	public List<ReplyDTO> getReplyList(@PathVariable("qboard_idx") int qboard_idx) {
		List<ReplyDTO> list = boardService.getReplyList(qboard_idx);
		return list;
	}
	
	@PostMapping("/{qboard_idx}")
	public int writeReply(@RequestBody ReplyDTO dto) {
		int row = boardService.writeReply(dto);
		return row;
	}
	
	@DeleteMapping("/{qboard_idx}/{reply_idx}")
	public int deleteReply(@PathVariable("reply_idx") int reply_idx) {
		int row = boardService.replyDelete(reply_idx);
		
		return row;
	}
	
	
}
