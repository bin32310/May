package com.may.service;

import java.util.List;

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
	
	// 회원 정보 조회(내정보)
	public UserVO userInfo(String us_id) {
      logger.debug("ServiceImpl : userInfo(String us_id)호출");  
      udao.userInfo(us_id);
      return udao.userInfo(us_id);
   }
	
	// 회원정보 수정
	public void userInfoUpdate(UserVO userInfoUpdateVO) {
		logger.debug("ServiceImpl : userInfoUpdate(userInfoUpdateVo)호출");
		udao.userInfoUpdate(userInfoUpdateVO);
	}
	
	// 회원탈퇴
	public int userDelete(UserVO deleteVO) {
		logger.debug("ServiceImpl : userDelete(UserVO deleteVO) 호출");
		int result = udao.userDelete(deleteVO);
		return result;
	}
	      

	
}
