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
import com.may.domain.UserVO;

@Repository(value="adminDAO")
public class AdminDAOImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(AdminDAOImpl.class);
	
	@Inject
	private SqlSessionFactory sqlFactory;
	 
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.may.mapper.AdminMapper";
	
	
	// 전체 회원 목록 조회
	public List<UserVO> userList(Criteria cri) throws Exception {
		logger.debug("userList(Criteria cri) 호출");
		return sqlSession.selectList(NAMESPACE + ".userList", cri);
	}
		
	// 전체 회원 수 조회
	public int userCount(Criteria cri) throws Exception {
		logger.debug("userCount(Criteria cri) 호출");
		return sqlSession.selectOne(NAMESPACE + ".userCount",cri);
	}
	
	
	// 전체 글 목록 조회
	public List<BoardVO> boardList(Criteria cri) throws Exception {
		logger.debug("boardList(Criteria cri) 호출");
		return sqlSession.selectList(NAMESPACE + ".boardList", cri);
	}
	
	// 전체 글 수 조회
	public int boardCount() throws Exception {
		logger.debug("boardCount() 호출");
		return sqlSession.selectOne(NAMESPACE + ".boardCount");
	}
	
	// 답변등록
	public int boReply(BoardVO boardVO) {
		logger.debug("boReply(BoardVO boardVO) 호출");
		return sqlSession.insert(NAMESPACE + ".boReply", boardVO);
	}
	
}
