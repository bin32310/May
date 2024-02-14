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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.may.domain.BoardVO;
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
		// 전체 글 목록 불러오기
		List<BoardVO> boardVO = bService.boardList();
		logger.info("test : " + boardVO);
		model.addAttribute("boardList", bService.boardList());
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
	
	// user id 중복 체크
	@ResponseBody
	@RequestMapping(value="userIdCheck", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public String userIdCheckPOST(String us_id) {
		logger.debug("userIdCheckPOST(String us_id)호출");
		String result = "입력";
		if(us_id == null || us_id.equals("")){ // 아이디 입력안함
			logger.debug("입력 ? : " + result);
		}else{
			result = uService.userIdCheck(us_id);
			logger.debug("result 값 체크 : " + result);
			if(result == null || result.equals("")){ //중복 아이디 없음
				result = "가능";
				logger.debug("가능 ? : " + result);
			}else { // 중복 아이디 있음
				
			}
		}
		return result;
		
	}
	
	// user tel 중복 체크
	@ResponseBody
	@RequestMapping(value="userTelCheck", method = RequestMethod.POST)
	public String userTelCheckPOST(String us_tel) {
		logger.debug("userTelCheck(String us_tel)호출");
		if(us_tel == null || us_tel.equals("")) { // 전화번호 입력안함
			return "입력";
		}else {
			String result = uService.userTelCheck(us_tel);
			if(result == null || result.equals("")){ //중복 전화번호 없음
				result = "가능";
			}
			logger.debug("result2 : " +  result);
			return result;
		}
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
   @RequestMapping(value = "/userLogout", method = RequestMethod.POST)
   public int userLogoutPOST(HttpSession session) {
      logger.debug("userLogoutPOST()호출 ");
      // 세션정보 초기화
      session.invalidate();
      return 1;
   }

}
