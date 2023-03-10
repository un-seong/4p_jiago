package com.itbank.model;

public class Paging {

	private int page;					
	private int boardCount;				
	private final int perPage = 10;		
	private final int perSection = 10;
	
	private int offset;					
	private int section;				
	
	private int pageCount;				
	private int begin;					
	private int end;	
	private int start;
	private int finish;
	private boolean prev;				
	private boolean next;				
	
	public Paging(int page, int boardCount) {	
		
		this.page = page;				
		this.boardCount = boardCount;
		
		
		offset = (page - 1) * perPage;
		
		begin = ((int)(page - 0.1) / perSection) * perSection + 1;
		
		end = begin + perSection - 1;
		
		boolean flag = boardCount % perPage != 0;
		
		pageCount = boardCount / perPage + (flag ? 1 : 0);
		
		end = end >= pageCount ? pageCount : end;
		
		section = (page - 1) / perSection;
		
		int lastSection = (pageCount - 1) / perSection;
		
		prev = begin > perSection;
		
		next = lastSection > section;
	}
	
	@Override
	public String toString() {
		String str = "";
		str += "요청 받은 페이지 : %d\n";
		str += "전체 게시글 개수 : %d\n";
		str += "전체 페이지 개수 : %d\n";
		str += "현재 섹션 번호 : %d\n";
		str += "페이지 시작 번호 : %d\n";
		str += "페이지 끝 번호 : %d\n";
		str += "[이전] 출력 : %s\n";
		str += "[다음] 출력 : %s\n";
		str = String.format(str, page, boardCount, pageCount, section, begin, end, prev, next);
		return str;
	}
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getBegin() {
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getPerPage() {
		return perPage;
	}

	public int getPerSection() {
		return perSection;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getFinish() {
		return finish;
	}

	public void setFinish(int finish) {
		this.finish = finish;
	}

	
	
}


