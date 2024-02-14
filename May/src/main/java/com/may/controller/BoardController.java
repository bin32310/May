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
import org.springframework.web.bind.annotation.ResponseBody;

import com.may.domain.BoardVO;
import com.may.service.BoardServiceImpl;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardServiceImpl bService;
	
	// http://localhost:8080/board/boWrite
	//글쓰기 GET
	@RequestMapping(value = "boWrite", method = RequestMethod.GET)
	public void boWriteGET() {
		logger.debug("boWriteGET()호출");
	}
	
	// 글쓰기 POST
	@ResponseBody
	@RequestMapping(value = "boWrite", method = RequestMethod.POST)
	public int boWritePOST(BoardVO boardVO, HttpSession session) {
		logger.debug("boWritePOST(BoardVO boardVO)호출");
		boardVO.setUs_id((String)session.getAttribute("us_id"));
		logger.debug("글 정보 boardVO : " + boardVO);
		return bService.boWrite(boardVO);
	}
	
	// 글 읽기 GET
	@RequestMapping(value = "boRead", method = RequestMethod.GET)
	public void boReadGET(Integer bo_num, Model model) {
		logger.debug("boReadGET(Integer bo_num)호출");
		model.addAttribute("boRead", bService.boRead(bo_num));
	}
	
	// 글 삭제 POST
	@ResponseBody
	@RequestMapping(value = "boDelete", method = RequestMethod.POST)
	public int boDeletePOST(Integer bo_num) {
		logger.debug("boDeletePOST(Integer bo_num)호출");
		return  bService.boDelete(bo_num);
	}
	
	// 글 수정 POST
	@ResponseBody
	@RequestMapping(value = "boModify", method = RequestMethod.POST)
	public int boModifyPOST(BoardVO boardVO) {
		logger.debug("boModifyPOST(BoardVO boardVO)호출");
		return  bService.boModify(boardVO);
	}
	
	
	
	
}
