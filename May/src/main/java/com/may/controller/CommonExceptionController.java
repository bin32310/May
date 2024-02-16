package com.may.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


@ControllerAdvice
public class CommonExceptionController { // 공통의 예외 처리
	
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionController.class);
	
	@ExceptionHandler(Exception.class) 
	public String commonException(Exception e, Model model) {
		logger.debug(" Exception 타입의 예외가 발생할때마다 실행하는 메서드");
		logger.debug(" 모든 예외를 처리하는 메서드");
		
		logger.debug(""+e.getMessage());
		e.printStackTrace();
		model.addAttribute("e", e);
		
		return "common_err";
	}
}
