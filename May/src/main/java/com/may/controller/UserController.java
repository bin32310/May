package com.may.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.may.domain.UserVO;
import com.may.service.BoardServiceImpl;
import com.may.service.UserServiceImpl;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Inject
	private UserServiceImpl uService;
	
	@Inject
	private BoardServiceImpl bService;
	
	// http://localhost:8080/user/userMain
	// 유저 메인 페이지로 이동
	@RequestMapping(value = "/userMain", method = RequestMethod.GET)
	public String userMainGET(HttpSession session, Model model) {
		logger.debug(" userMainGET()호출");
		// 글목록 불러오기
		//model.addAttribute("boardList", bService.boardList());
		return "/user/userMain";
	}
	
	// 회원가입 페이지로 이동(join-GET)
	// http://localhost:8080/user/userJoin
	@RequestMapping(value = "userJoin", method = RequestMethod.GET)
	public String userJoinGET() {
		logger.debug("userJoinGET()호출");
		return "/user/userJoin";
   }

	//회원가입
	@ResponseBody
	@RequestMapping(value = "userJoin", method = RequestMethod.POST)
	public int userJoinPOST(UserVO userVO) {
		logger.debug("userJoinPOST(UserVO userVO)호출");
		logger.debug("회원가입 정보 userVO : " + userVO);
		return uService.userJoin(userVO);
	}
	
	// 로그인 페이지로 이동(login-GET)
	// http://localhost:8080/user/userLogin
	@RequestMapping(value = "/userLogin", method = RequestMethod.GET)
	public String userLoginGET() {
		logger.debug("userLoginGET()호출");
		return "/user/userLogin";
   }
	
   // 로그인 시도(login-post)
	@ResponseBody
	@RequestMapping(value = "/userLogin", method = RequestMethod.POST)
	public int userLoginPOST(UserVO loginVO, HttpSession session, RedirectAttributes rttr){
		logger.debug("userLoginPOST()호출");

		// 로그인
		UserVO resultVO = uService.userLogin(loginVO);
		logger.debug("resultVO : " + resultVO);

		if(resultVO != null){
	  		// 세션에 로그인 정보 저장
	  		session.setAttribute("us_id", resultVO.getUs_id());
	  		session.setAttribute("us_nickname", resultVO.getUs_nickname());
	  		return 1;
		}
      return 0;
      
   }

   // 로그아웃 처리
   @ResponseBody
   @RequestMapping(value = "/userLogout", method = RequestMethod.GET)
   public void userLogoutGET(HttpSession session) {
      logger.debug("userLogoutGET()호출 ");
      // 세션정보 초기화
      session.invalidate();
   }

}
