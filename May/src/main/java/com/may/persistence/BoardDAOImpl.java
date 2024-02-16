package com.may.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.may.domain.BoardVO;
import com.may.domain.Criteria;

@Repository(value="boardDAO")
public class BoardDAOImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(BoardDAOImpl.class);
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.may.mapper.BoardMapper";
	
	// 전체 글 목록 조회
	public List<BoardVO> boardList(Criteria cri) throws Exception {
		logger.debug("boardList(Criteria cri) 호출");
		return sqlSession.selectList(NAMESPACE + ".boardList", cri);
	}
	
	// 전체 글 수 조회
	public int boardCount(Criteria cri) throws Exception {
		logger.debug("boardCount(Criteria cri) 호출");
		return sqlSession.selectOne(NAMESPACE + ".boardCount",cri);
	}
	
	// 글쓰기
	public int boWrite(BoardVO boardVO) {
		logger.debug("boWrite(BoardVO boardVO) 호출");
			
		return sqlSession.insert(NAMESPACE + ".boWrite", boardVO);
	}
	
	// 글읽기
	public BoardVO boRead(Integer bo_num) {
		logger.debug("boRead(Integer bo_num) 호출 ");
		return 	sqlSession.selectOne(NAMESPACE + ".boRead", bo_num)  ;
	}
	
	// 글 조회수 증가
	public int boViewUp(Integer bo_num) {
		logger.debug("boViewUp(Integer bo_num) 호출 ");
		return sqlSession.update(NAMESPACE + ".boViewUp", bo_num)  ;
	}
	
	
	// 글삭제
	public int boDelete(Integer bo_num) {
		logger.debug("boDelete(Integer bo_num) 호출 ");
		return 	sqlSession.update(NAMESPACE + ".boDelete", bo_num)  ;
	}
	
	// 글수정
	public int boUpdate(BoardVO boardVO) {
		logger.debug("boUpdate(BoardVO boardVO) 호출 ");
		return 	sqlSession.update(NAMESPACE + ".boUpdate", boardVO)  ;
	}
	
}
