package com.may.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.may.domain.BoardVO;
import com.may.domain.Criteria;
import com.may.domain.NoticeVO;
import com.may.domain.UserVO;
import com.may.persistence.AdminDAOImpl;
import com.may.persistence.BoardDAOImpl;

@Service(value="adminService")
public class AdminServiceImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);
	
	// AdminDAO 객체 주입
	@Inject
	private AdminDAOImpl adao;
	
	// 메인 화면
 
	
	// 전체 회원 목록 조회
	public List<UserVO> userList(Criteria cri) throws Exception{
		logger.debug("userList(Criteria cri) 호출");
		return adao.userList(cri);
	}
	
	// 전체 회원 수 조회
	public int userCount(Criteria cri) throws Exception {
		logger.debug("service : userCount() 호출 ");
		return adao.userCount(cri);
	}
	
	// 전체 글 목록 조회
	public List<BoardVO> boardList(Criteria cri) throws Exception{
		logger.debug("boardList(Criteria cri) 호출");
		return adao.boardList(cri);
	}
	
	// 전체 글 수 조회
	public int boardCount() throws Exception {
		logger.debug("service : boardCount() 호출 ");
		return adao.boardCount();
	}
	
	// 미답변 글 목록 조회
	public List<BoardVO> noBoardList(Criteria cri) throws Exception{
		logger.debug("noBoardList(Criteria cri) 호출");
		return adao.noBoardList(cri);
	}
	
	// 미답변 글 수 조회
	public int noBoardCount() throws Exception {
		logger.debug("service : noBoardCount() 호출 ");
		return adao.noBoardCount();
	}
	
	// re_seq 확인
	public Integer boReplySeq(Integer re_ref) {
		logger.debug("boReplySeq(Integer re_ref) 호출 ");
		return 	adao.boReplySeq(re_ref);
	}
	
	// 답변등록
	public int boReply(BoardVO boardVO) {
		logger.debug("boReply(BoardVO boardVO) 호출 ");
		return 	adao.boReply(boardVO);
	}
	
	// 답변등록
	public int boReplyUpadte(BoardVO boardVO) {
		logger.debug("boReplyUpadte(BoardVO boardVO) 호출 ");
		return 	adao.boReplyUpadte(boardVO);
	}
	
}
