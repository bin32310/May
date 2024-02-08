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
	
	// 유저 게시판 리스트
	public List<BoardVO> boardList(){
		logger.debug("boardList() 호출");
		return bdao.boardList();
	}
	
	
	// 글쓰기
	public int boWrite(BoardVO boardVO) {
		logger.debug("boWrite(BoardVO boardVO) 호출 ");
		return 	bdao.boWrite(boardVO);
		
	}
}
