package com.may.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.may.domain.UserVO;

@Repository(value="userDAO")
public class UserDAOImpl {

	

	private static final Logger logger = LoggerFactory.getLogger(UserDAOImpl.class);
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.may.mapper.UserMapper";
	
	// 현재시간 
	public String getTime() {
      //디비연결
      SqlSession sqlSession = sqlFactory.openSession();
      String time = sqlSession.selectOne("com.may.mapper.userMapper.getTime");
      return time;
   }
   
   // 회원가입
   public int userJoin(UserVO joinVO) {
	   logger.debug("userJoin(UserVO joinVO)호출");
      return sqlSession.insert(NAMESPACE + ".userJoin", joinVO);
   }
   
   // 회원가입 - user id 중복체크
   public String userIdCheck(String us_id) {
	   logger.debug("userIdCheck(String us_id)호출");
	   return sqlSession.selectOne(NAMESPACE + ".userIdCheck", us_id);
   }
   
   // 회원가입 - user tel 중복체크
   public String userTelCheck(String us_tel) {
	   logger.debug("userTelCheck(String us_tel)호출");
	   return sqlSession.selectOne(NAMESPACE + ".userTelCheck", us_tel);
   }
   
   // 로그인
   public UserVO userLogin(UserVO loginVO) {
      logger.debug("userLogin(UserVO loginVO)호출 ");
      return sqlSession.selectOne(NAMESPACE + ".userLogin",loginVO);
   }
   
   // 아이디 찾기
   public String userFindId(UserVO userVO) {
	   logger.debug("userFindId(UserVO userVO)호출 ");
	   return sqlSession.selectOne(NAMESPACE + ".userFindId",userVO);
   }
   
   // 비밀번호 찾기
   public String userFindPw(UserVO userVO) {
	   logger.debug("userFindPw(UserVO userVO)호출 ");
	   return sqlSession.selectOne(NAMESPACE + ".userFindPw",userVO);
   }
   
   // 회원 정보 조회(내정보)
   public UserVO userInfo(String us_id) {
      logger.debug("userInfo(String us_id) 호출 ");
      return sqlSession.selectOne(NAMESPACE + ".userInfo",us_id);
   }

   // 회원 비밀번호 체크(정보수정)
   public String userPwCheck(String us_id) {
	   logger.debug("userPwCheck(String us_id) 호출");
	   return sqlSession.selectOne(NAMESPACE + ".userPwCheck", us_id);	   
   }
   
   // 회원 비밀번호 변경(정보수정)
   public int userPwUpdate(UserVO userVO) {
	   logger.debug("userPwUpdate(UserVO userVO) 호출");
	   return sqlSession.update(NAMESPACE + ".userPwUpdate", userVO);	   
   }
   
   // 회원정보 수정
   public int userInfoUpdate(UserVO userVO) {
	   logger.debug("userInfoUpdate(UserVO userVO) 호출");
	   return sqlSession.update(NAMESPACE + ".userInfoUpdate", userVO);
  }

   // 회원 탈퇴
   public int userDelete(String us_id) {
	   logger.debug("userDelete(String us_id)호출 ");
	   return sqlSession.delete(NAMESPACE + ".userDelete",us_id);
   }
      
      
	
}
