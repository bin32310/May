package com.may.controller;


import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.may.domain.BoardVO;
import com.may.domain.Criteria;
import com.may.domain.PageVO;
import com.may.domain.UserVO;
import com.may.service.AdminServiceImpl;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private AdminServiceImpl aService;
	
	// http://localhost:8080/admin/adminMain
	// 관리자 메인 페이지
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public void adminMainGET(Criteria cri, Model model)throws Exception {
		logger.debug("adminMainGET()호출");
	}
	
	// 공지 관리 페이지
	@RequestMapping(value = "/noticeManage", method = RequestMethod.GET)
	public void noticeManageGET(Criteria cri, Model model)throws Exception {
		logger.debug("noticeManageGET()호출");
	}
	
	// 회원 관리 페이지
	@RequestMapping(value = "/userManage", method = RequestMethod.GET)
	public void userManageGET(Criteria cri, Model model)throws Exception {
		logger.debug("userManageGET()호출");
		
		// 페이징 처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(aService.userCount(cri)); // 전체 회원 수
		pageVO.setDisplayPageNum(10);
		logger.debug("pageVO : " + pageVO);
		model.addAttribute("pageVO", pageVO);
	
		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		}
		
		// 전체 회원 목록 불러오기
		List<UserVO> userList = aService.userList(cri);
		logger.debug("userList : " + userList);
		model.addAttribute("userList", userList);
	}
	
	// 글 관리 페이지
	@RequestMapping(value = "/boardManage", method = RequestMethod.GET)
	public void boardManageGET(Criteria cri, Model model)throws Exception {
		logger.debug("boardManageGET()호출");
	}
	
}
