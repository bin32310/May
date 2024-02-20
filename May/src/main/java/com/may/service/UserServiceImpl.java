package com.may.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.may.domain.UserVO;
import com.may.persistence.UserDAOImpl;

@Service(value="userService")
public class UserServiceImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	// BoardDAO 객체 주입
	@Inject
	private UserDAOImpl udao;
	
	// 메인 화면
	
	// 회원가입
	public int userJoin(UserVO joinVO) {
		logger.debug("ServiceImpl : userJoin(UserVO joinVO) 호출"); 
		return udao.userJoin(joinVO);
	}
	
	// 회원가입 - user id 중복체크
	public String userIdCheck(String us_id) {
		logger.debug("ServiceImpl : userIdCheck(String us_id) 호출"); 
		return udao.userIdCheck(us_id);
	}
	
   // 회원가입 - user tel 중복체크
	public String userTelCheck(String us_tel) {
		logger.debug("ServiceImpl : userTelCheck(String us_tel) 호출"); 
		return udao.userTelCheck(us_tel);
	}
	
	// 로그인 
	public UserVO userLogin(UserVO loginVO) {
		logger.debug("ServiceImpl : userLogin(UserVO loginVO)호출");
		return udao.userLogin(loginVO);
	}
	
	// 비밀번호 찾기 
	public String userFindPw(UserVO userVO) {
		logger.debug("ServiceImpl : userFindPw(UserVO userVO)호출");
		return udao.userFindPw(userVO);
	}
	
	// 회원 정보 조회(내정보)
	public UserVO userInfo(String us_id) {
      logger.debug("ServiceImpl : userInfo(String us_id)호출");  
      udao.userInfo(us_id);
      return udao.userInfo(us_id);
   }
	
	// 회원 비밀번호 체크(정보수정)
	public String userPwCheck(String us_id) {
		logger.debug("ServiceImpl : userPwCheck(userVO)호출");
		return udao.userPwCheck(us_id);
	}
	
	// 회원 비밀번호 변경
	public int userPwUpdate(UserVO userVO) {
		logger.debug("ServiceImpl : userPwUpdate(userVO)호출");
		return udao.userPwUpdate(userVO);
	}

	// 회원정보 수정
	public int userInfoUpdate(UserVO userVO) {
		logger.debug("ServiceImpl : userInfoUpdate(userVO)호출");
		return udao.userInfoUpdate(userVO);
	}
	
	// 회원탈퇴
	public int userDelete(String us_id) {
		logger.debug("ServiceImpl : userDelete(String us_id) 호출");
		return udao.userDelete(us_id);
	}

	
}
