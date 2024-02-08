package com.may.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.may.domain.BoardVO;

@Repository(value="boardDAO")
public class BoardDAOImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(BoardDAOImpl.class);
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.mayeye.mapper.BoardMapper";
	
	// 전체 글 목록 조회
	public List<BoardVO> boardList(){
		logger.debug("DAOImpl : boardList() 호출");
		return sqlSession.selectList(NAMESPACE + ".boardList");
	}
	
	// 글쓰기
	public int boWrite(BoardVO boardVO) {
		logger.debug("DAOImpl : boWrite(BoardVO boardVO) 호출");
			
		return sqlSession.insert(NAMESPACE + ".boWrite", boardVO);
	}
	
	
}
