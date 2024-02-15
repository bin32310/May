package com.may.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.may.domain.BoardVO;
import com.may.domain.NoticeVO;

@Repository(value="adminDAO")
public class AdminDAOImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(AdminDAOImpl.class);
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.may.mapper.AdminMapper";
	
	// 공지사항 전체 글 목록 조회
	public List<NoticeVO> noticeList(){
		logger.debug("DAOImpl : noticeList() 호출");
		return sqlSession.selectList(NAMESPACE + ".noticeList");
	}
	
	// 공지사항 글쓰기
	public int noWrite(NoticeVO noticeVO) {
		logger.debug("DAOImpl : noWrite(NoticeVO noticeVO) 호출");
		return sqlSession.insert(NAMESPACE + ".noWrite", noticeVO);
	}
	
	
}
