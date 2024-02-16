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
import com.may.service.AdminServiceImpl;
import com.may.service.UserServiceImpl;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private AdminServiceImpl aService;
	
	// http://localhost:8080/admin/adminMain
	// 관리자 메인 페이지
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public void adminMainGET(Criteria cri, HttpSession session, Model model)throws Exception {
		logger.debug("adminMainGET()호출");
		
	}
}
