package com.may.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.may.domain.BoardVO;
import com.may.domain.NoticeVO;
import com.may.persistence.AdminDAOImpl;
import com.may.persistence.BoardDAOImpl;

@Service(value="adminService")
public class AdminServiceImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);
	
	// NoticeDAO 객체 주입
	@Inject
	private AdminDAOImpl adao;
	
	// 메인 화면
	
	// 공지사항 게시판 리스트
	public List<NoticeVO> noList(){
		logger.debug("noList() 호출");
		return adao.noticeList();
	}
	
	
	// 글쓰기
	public int noWrite(NoticeVO noticeVO) {
		logger.debug("noWrite(NoticeVO noticeVO) 호출 ");
		return 	adao.noWrite(noticeVO);
		
	}
}
