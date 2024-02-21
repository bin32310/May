package com.may.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.may.domain.Criteria;
import com.may.domain.PageVO;
import com.may.domain.UserVO;
import com.may.service.BoardServiceImpl;
import com.may.service.UserServiceImpl;

@Controller
@RequestMapping("/user")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserServiceImpl uService;

	@Inject
	private BoardServiceImpl bService;

	// http://localhost:8080/user/userMain
	// 유저 메인 페이지로 이동
	@RequestMapping(value = "/userMain", method = RequestMethod.GET)
	public void userMainGET(Criteria cri, Model model) throws Exception {
		logger.debug("userMainGET()호출");

		// 페이징 처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(bService.boardCount()); // 전체 글 수
		model.addAttribute("pageVO", pageVO);

		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		}

		// 전체 글 목록 불러오기
		List<BoardVO> boardList = bService.boardList(cri);
		model.addAttribute("boardList", boardList);
	}

	// 회원가입 페이지로 이동(join-GET)
	// http://localhost:8080/user/userJoin
	@RequestMapping(value = "userJoin", method = RequestMethod.GET)
	public void userJoinGET() throws Exception {
		logger.debug("userJoinGET()호출");
	}

	// 회원가입
	@ResponseBody
	@RequestMapping(value = "userJoin", method = RequestMethod.POST)
	public int userJoinPOST(UserVO userVO) throws Exception {
		logger.debug("userJoinPOST(UserVO userVO)호출");
		logger.debug("회원가입 정보 userVO : " + userVO);
		
		boolean us_id = false, us_pw = false, us_name = false, us_nickname = false, us_tel = false;

		if(userVO.getUs_id().length() >= 3 && userVO.getUs_id().length() <= 8) {
			us_id = true;
		}
		if(userVO.getUs_pw().length() >= 3 && userVO.getUs_pw().length() <= 8) {
			us_pw = true;
		}
		if(userVO.getUs_name().length() >= 1 && userVO.getUs_name().length() <= 15) {
			us_name = true;
		}
		if(userVO.getUs_nickname().length() >= 1 && userVO.getUs_nickname().length() <= 8) {
			us_nickname = true;
		}
		if(userVO.getUs_tel().length() == 11) {
			us_tel = true;
		}
		// 모든 조건 만족시
		if(us_id && us_pw && us_name && us_nickname && us_tel) {
			return uService.userJoin(userVO);
		}
		return 0;
	}

	// user id 중복 체크
	@ResponseBody
	@RequestMapping(value = "userIdCheck", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public String userIdCheckPOST(String us_id) throws Exception {
		logger.debug("userIdCheckPOST(String us_id)호출");
		String result = "불가능";
		if (us_id == null || us_id.equals("")) { // 아이디 입력안함
		} else {
			result = uService.userIdCheck(us_id);
			if (result == null || result.equals("")) { // 중복 아이디 없음
				result = "가능";
			}
		}
		return result;
	}

	// user tel 중복 체크
	@ResponseBody
	@RequestMapping(value = "userTelCheck", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public String userTelCheckPOST(String us_tel) throws Exception {
		logger.debug("userTelCheck(String us_tel)호출");
		String result = "불가능";
		if (us_tel == null || us_tel.equals("")) { // 전화번호 입력안함
		} else {
			result = uService.userTelCheck(us_tel);
			if (result == null || result.equals("")) { // 중복 전화번호 없음
				result = "가능";
			}
		}
		return result;
	}

	// 로그인 페이지로 이동(login-GET)
	// http://localhost:8080/user/userLogin
	@RequestMapping(value = "/userLogin", method = RequestMethod.GET)
	public String userLoginGET() throws Exception {
		logger.debug("userLoginGET()호출");
		return "/user/userLogin";
	}

	// 로그인 시도(login-post)
	@ResponseBody
	@RequestMapping(value = "/userLogin", method = RequestMethod.POST)
	public int userLoginPOST(UserVO loginVO, HttpSession session) throws Exception {
		logger.debug("userLoginPOST()호출");

		// 로그인
		UserVO resultVO = uService.userLogin(loginVO);
		logger.debug("resultVO : " + resultVO);

		if (resultVO != null) {
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
	public int userLogoutPOST(HttpSession session) throws Exception {
		logger.debug("userLogoutPOST()호출 ");
		// 세션정보 초기화
		session.invalidate();
		return 1;
	}

	// 아이디 찾기 페이지로 이동(userFindId-GET)
	// http://localhost:8080/user/userFindPw
	@RequestMapping(value = "/userFindId", method = RequestMethod.GET)
	public void userFindIdGET() throws Exception {
		logger.debug("userFindIdGET()호출");
	}

	// 아이디 찾기(userFindPw-POST)
	@ResponseBody
	@RequestMapping(value = "/userFindId", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public String userFindIdPOST(UserVO userVO) throws Exception {
		logger.debug("userFindIdPOST()호출");
		String us_id = uService.userFindId(userVO);
		if (us_id == null || us_id.equals("")) {
			return "없음";
		}
		return us_id;
	}

	// 비밀번호 찾기 페이지로 이동(userFindPw-GET)
	// http://localhost:8080/user/userFindPw
	@RequestMapping(value = "/userFindPw", method = RequestMethod.GET)
	public void userFindPwGET() throws Exception {
		logger.debug("userFindPwGET()호출");
	}

	// 비밀번호 찾기(userFindPw-POST)
	@ResponseBody
	@RequestMapping(value = "/userFindPw", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public String userFindPwPOST(UserVO userVO) throws Exception {
		logger.debug("userFindPwPOST()호출");
		String us_pk = uService.userFindPw(userVO);
		if (us_pk == null || us_pk.equals("")) {
			return "없음";
		}
		return us_pk;
	}

	// 내정보 페이지로 이동(Mypage-GET)
	// http://localhost:8080/user/userMypage
	@RequestMapping(value = "/userMypage", method = RequestMethod.GET)
	public void userMypageGET(HttpSession session, Model model) throws Exception {
		logger.debug("userMypageGET()호출");

		// 회원정보 조회
		model.addAttribute("userInfo", uService.userInfo((String) session.getAttribute("us_id")));
	}

	// 비밀번호 변경(userPwUpdate-POST)
	@ResponseBody
	@RequestMapping(value = "/userPwUpdate", method = RequestMethod.POST)
	public int userPwUpdatePOST(String us_pw, String us_pw_new, HttpSession session) throws Exception {
		logger.debug("userPwUpdatePOST()호출");
		// 세션 - 아이디
		String us_id = (String) session.getAttribute("us_id");

		String pwCK = uService.userPwCheck(us_id);
		if (pwCK == null || pwCK.equals("") || !pwCK.equals(us_pw)) {
			return 0;
		}
		UserVO userVO = new UserVO();
		userVO.setUs_id(us_id);
		userVO.setUs_pw(us_pw_new);
		return uService.userPwUpdate(userVO);

	}

	// 내정보 변경(userInfoUpdate-POST)
	@ResponseBody
	@RequestMapping(value = "/userInfoUpdate", method = RequestMethod.POST)
	public int userInfoUpdate(String us_nickname, HttpSession session) throws Exception {
		logger.debug("userInfoUpdatePOST()호출");
		// 세션 - 아이디
		String us_id = (String) session.getAttribute("us_id");

		if (us_nickname == null || us_nickname.equals("")) {
			return 0;
		}
		UserVO userVO = new UserVO();
		userVO.setUs_id(us_id);
		userVO.setUs_nickname(us_nickname);
		return uService.userInfoUpdate(userVO);
	}

	// 회원 탈퇴하기(userDelete-POST)
	@ResponseBody
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public int userDelete(HttpSession session) throws Exception {
		logger.debug("userDeletePOST()호출");
		if (uService.userDelete((String) session.getAttribute("us_id")) == 1) {
			session.invalidate();
			return 1;
		}
		return 0;
	}

	// 마이페이지 - 내 글 관리 페이지로 이동(userMyBoard-GET)
	// http://localhost:8080/user/userMyBoard
	@RequestMapping(value = "/userMyBoard", method = RequestMethod.GET)
	public void userMyBoardGET(Criteria cri, HttpSession session, Model model) throws Exception {
		logger.debug("userMyBoardGET()호출");

		UserVO userVO = new UserVO();
		userVO.setUs_id((String) session.getAttribute("us_id"));

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri", cri);
		map.put("userVO", userVO);

		// 페이징 처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(bService.myBoardCount(userVO.getUs_id())); // 내 글 수
		logger.debug("pageVO : " + pageVO);
		model.addAttribute("pageVO", pageVO);

		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		}

		// 내 글 목록 불러오기
		List<BoardVO> boardList = bService.myBoardList(map);
		model.addAttribute("boardList", boardList);

	}


}
