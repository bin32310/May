package com.may.persistence;

import java.util.List;
import java.util.Map;

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
	public int boardCount() throws Exception {
		logger.debug("boardCount() 호출");
		return sqlSession.selectOne(NAMESPACE + ".boardCount");
	}
	
	// 내 글 목록 조회
	public List<BoardVO> myBoardList(Map<String, Object> map) throws Exception {
		logger.debug("myBoardList(Map map) 호출");
		return sqlSession.selectList(NAMESPACE + ".myBoardList", map);
	}
	
	// 내 글 수 조회
	public int myBoardCount(String us_id) throws Exception {
		logger.debug("myBoardCount(String us_id) 호출");
		return sqlSession.selectOne(NAMESPACE + ".myBoardCount",us_id);
	}
	
	// 글쓰기
	public int boWrite(BoardVO boardVO) {
		logger.debug("boWrite(BoardVO boardVO) 호출");
		return sqlSession.insert(NAMESPACE + ".boWrite", boardVO);
	}
	
	// 가장 최신 글번호 가져오기
	public Integer getBoMaxNum() {
		logger.debug("getBoMaxNum() 호출 ");
		return sqlSession.selectOne(NAMESPACE + ".getBoMaxNum");
	}
	
	// 글읽기
	public BoardVO boRead(Integer bo_num) {
		logger.debug("boRead(Integer bo_num) 호출 ");
		return 	sqlSession.selectOne(NAMESPACE + ".boRead", bo_num);
	}
	
	// 글 조회수 증가
	public int boViewUp(Integer bo_num) {
		logger.debug("boViewUp(Integer bo_num) 호출 ");
		return sqlSession.update(NAMESPACE + ".boViewUp", bo_num);
	}
	
	// 글삭제(원글과 답글 모두 삭제)
	public int boDelete(Integer re_ref) {
		logger.debug("boDelete(Integer re_ref) 호출 ");
		return 	sqlSession.update(NAMESPACE + ".boDelete", re_ref);
	}
	
	// 답글삭제
	public int reDelete(Integer re_ref) {
		logger.debug("reDelete(Integer re_ref) 호출 ");
		return 	sqlSession.update(NAMESPACE + ".reDelete", re_ref);
	}
	
	// 글수정
	public int boUpdate(BoardVO boardVO) {
		logger.debug("boUpdate(BoardVO boardVO) 호출 ");
		return 	sqlSession.update(NAMESPACE + ".boUpdate", boardVO);
	}
	
	// 글-답글 공개여부 수정
	public int reLockUpdate(BoardVO boardVO) {
		logger.debug("reLockUpdate(BoardVO boardVO) 호출 ");
		return 	sqlSession.update(NAMESPACE + ".reLockUpdate", boardVO);
	}
	
	// 원글 작성자
	public String boWriter(int re_ref) {
		logger.debug("boWriter(int re_ref) 호출 ");
		return 	sqlSession.selectOne(NAMESPACE + ".boWriter", re_ref);
	}
	
	// 답글보기
	public int goReply(int re_ref) {
		logger.debug("goReply(int re_ref) 호출 ");
		return 	sqlSession.selectOne(NAMESPACE + ".goReply", re_ref);
	}
	
	// 원글보기
	public int goOrigin(int re_ref) {
		logger.debug("goOrigin(int re_ref) 호출 ");
		return 	sqlSession.selectOne(NAMESPACE + ".goOrigin", re_ref);
	}
	
}
