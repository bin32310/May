package com.may.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.may.service.AdminServiceImpl;
import com.may.service.UserServiceImpl;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private AdminServiceImpl aService;
	
	// http://localhost:8080/admin/adminMain
	// 관리자 메인 페이지 호출
	
}
