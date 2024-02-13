package com.may.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.may.domain.BoardVO;
import com.may.persistence.BoardDAOImpl;

@Service(value="boardService")
public class BoardServiceImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	// BoardDAO 객체 주입
	@Inject
	private BoardDAOImpl bdao;
	
	// 메인 화면
	
	// 전체 글 목록 조회
	public List<BoardVO> boardList(){
		logger.debug("boardList() 호출");
		return bdao.boardList();
	}
	
	
	// 글쓰기
	public int boWrite(BoardVO boardVO) {
		logger.debug("boWrite(BoardVO boardVO) 호출 ");
		return 	bdao.boWrite(boardVO);
	}
	
	// 글읽기
	public BoardVO boRead(Integer bo_num) {
		logger.debug("boRead(Integer bo_num) 호출 ");
		return 	bdao.boRead(bo_num);
	}
	
	// 글삭제
	public int boDelete(Integer bo_num) {
		logger.debug("boDelete(Integer bo_num) 호출 ");
		return 	bdao.boDelete(bo_num);
	}
	
}
