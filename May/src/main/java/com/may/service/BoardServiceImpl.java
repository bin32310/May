package com.may.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.may.domain.BoardVO;
import com.may.domain.Criteria;
import com.may.persistence.BoardDAOImpl;

@Service(value="boardService")
public class BoardServiceImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	// BoardDAO 객체 주입
	@Inject
	private BoardDAOImpl bdao;
	
	// 메인 화면
	 
	// 전체 글 목록 조회
	public List<BoardVO> boardList(Criteria cri) throws Exception{
		logger.debug("boardList(Criteria cri) 호출");
		return bdao.boardList(cri);
	}
	
	// 전체 글 수 조회
	public int boardCount() throws Exception {
		logger.debug("service : boardCount() 호출 ");
		return bdao.boardCount();
	}
	
	// 내 글 목록 조회
	public List<BoardVO> myBoardList(Map<String, Object> map) throws Exception{
		logger.debug("myBoardList(Map map) 호출");
		return bdao.myBoardList(map);
	}
	
	// 내 글 수 조회
	public int myBoardCount(String us_id) throws Exception {
		logger.debug("service : myBoardCount(String us_id) 호출 ");
		return bdao.myBoardCount(us_id);
	}
	
	
	// 글쓰기
	public int boWrite(BoardVO boardVO) {
		logger.debug("boWrite(BoardVO boardVO) 호출 ");
		return 	bdao.boWrite(boardVO);
	}
	
	// 가장 최신 글 가져오기
	public int getBoMaxNum() {
		logger.debug("getBoMaxNum() 호출 ");
		return bdao.getBoMaxNum();
	}
	
	// 글읽기
	public BoardVO boRead(Integer bo_num) {
		logger.debug("boRead(Integer bo_num) 호출 ");
		return 	bdao.boRead(bo_num);
	}
	
	// 글 조회수 증가
	public int boViewUp(Integer bo_num) {
		logger.debug("boViewUp(Integer bo_num) 호출 ");
		return 	bdao.boViewUp(bo_num);
	}
	
	// 글삭제(원글과 답글 모두 삭제)
	public int boDelete(Integer re_ref) {
		logger.debug("boDelete(Integer re_ref) 호출 ");
		return 	bdao.boDelete(re_ref);
	}
	
	// 답변만삭제
	public int reDelete(Integer re_ref) {
		logger.debug("reDelete(Integer re_ref) 호출 ");
		return 	bdao.reDelete(re_ref);
	}
	
	// 글수정
	public int boUpdate(BoardVO boardVO) {
		logger.debug("boUpdate(BoardVO boardVO) 호출 ");
		return 	bdao.boUpdate(boardVO);
	}
	
	// 답변 공개여부 변경
	public int reLockUpdate(BoardVO boardVO) {
		logger.debug("reLockUpdate(BoardVO boardVO) 호출 ");
		return 	bdao.reLockUpdate(boardVO);
	}
	
	// 원글 작성자
	public String boWriter(int re_ref) {
		logger.debug("boWriter(int re_ref) 호출 ");
		return 	bdao.boWriter(re_ref);
	}
	
	// 답변보기
	public int goReply(int re_ref) {
		logger.debug("goReply(int re_ref) 호출 ");
		return bdao.goReply(re_ref);
	}
	
	// 답변보기
	public int goOrigin(int re_ref) {
		logger.debug("goOrigin(int re_ref) 호출 ");
		return bdao.goOrigin(re_ref);
	}
	
}
