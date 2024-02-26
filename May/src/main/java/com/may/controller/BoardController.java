package com.may.controller;

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
import com.may.service.AdminServiceImpl;
import com.may.service.BoardServiceImpl;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardServiceImpl bService;
	@Inject
	private AdminServiceImpl aService;

	// http://localhost:8080/board/boWrite
	// 글쓰기 GET
	@RequestMapping(value = "boWrite", method = RequestMethod.GET)
	public void boWriteGET() throws Exception {
		logger.debug("boWriteGET()호출");
	}

	// 글쓰기 POST
	@ResponseBody
	@RequestMapping(value = "boWrite", method = RequestMethod.POST)
	public int boWritePOST(BoardVO boardVO, HttpSession session) throws Exception {
		logger.debug("boWritePOST(BoardVO boardVO)호출");
		
		Integer maxNum = bService.getBoMaxNum();
		if(maxNum == null) { // 첫글이면
			maxNum = 1;
		}else {
			maxNum += 1;
		}
		
		boardVO.setUs_id((String) session.getAttribute("us_id"));
		boardVO.setRe_ref(maxNum);
		logger.debug("글 정보 boardVO : " + boardVO);
		if (bService.boWrite(boardVO) == 1) {
			return maxNum;
		}
		return 0;

	}

	// 글 읽기 GET
	@RequestMapping(value = "boRead", method = RequestMethod.GET)
	public void boReadGET(Integer bo_num,Model model, HttpSession session) throws Exception {
		logger.debug("boReadGET(Integer bo_num)호출");
		logger.debug(" 조회수 증가 : " + bService.boViewUp(bo_num));

		// 글정보
		BoardVO boardVO = bService.boRead(bo_num);
		model.addAttribute("boRead", boardVO);
		
		// 답글일 경우 원작 작성자 id 정보 저장
		if (boardVO.getBo_reply().equals("re")){
			session.setAttribute("writer", bService.boWriter(boardVO.getRe_ref()));
		}
	}

	// 글 삭제 POST
	@ResponseBody
	@RequestMapping(value = "boDelete", method = RequestMethod.POST)
	public int boDeletePOST(String bo_reply, Integer re_ref) throws Exception {
		logger.debug("boDeletePOST(Integer bo_num)호출");
		
		// 답글만 삭제시
		// 답글이고 && 답글 삭제 성공시
		if(bo_reply.equals("re") && bService.reDelete(re_ref) == 1) {
			// 원글의 답변상태를 no로 update 
			BoardVO boardVO = new BoardVO();
			boardVO.setBo_num(re_ref);
			boardVO.setBo_reply("no");
			return aService.boReplyUpadte(boardVO);
		}
		// 원글과 답글 모두 삭제
		return bService.boDelete(re_ref);
	}

	// 글 수정 POST
	@ResponseBody
	@RequestMapping(value = "boUpdate", method = RequestMethod.POST)
	public int boUpdatePOST(BoardVO boardVO) throws Exception {
		logger.debug("boUpdatePOST(BoardVO boardVO)호출");
		
		// 답글의 공개, 비공개 여부 변경
		if (boardVO.getBo_reply().equals("yes")) {
			bService.reLockUpdate(boardVO);
		}
		return bService.boUpdate(boardVO);
	}
	
	// 답변보기 POST
	@ResponseBody
	@RequestMapping(value = "goReply", method = RequestMethod.POST)
	public int goReplyPOST(int re_ref) throws Exception {
		logger.debug("goReplyPOST(int re_ref)호출");
		
		// 답변의 bo_num 조회
		return bService.goReply(re_ref);
	}
	
	// 원글보기 POST
	@ResponseBody
	@RequestMapping(value = "goOrigin", method = RequestMethod.POST)
	public int goOriginPOST(int re_ref) throws Exception {
		logger.debug("goOriginPOST(int re_ref)호출");
		
		// 원글의 bo_num 조회
		return bService.goOrigin(re_ref);
	}

}
