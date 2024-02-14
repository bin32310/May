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
	
	private static final String NAMESPACE = "com.mayeye.mapper.UserMapper";
	
	// 현재시간 
	public String getTime() {
      //디비연결
      SqlSession sqlSession = sqlFactory.openSession();
      String time = sqlSession.selectOne("com.mayeye.mapper.userMapper.getTime");
      return time;
   }
   
   // 회원가입
   public int userJoin(UserVO joinVO) {
	   logger.debug("DAOImpl : userJoin(UserVO joinVO)호출");
      return sqlSession.insert(NAMESPACE + ".userJoin", joinVO);
   }
   
   // 회원가입 - user id(email) 중복체크
   public String userIdCheck(String us_id) {
	   logger.debug("DAOImpl : userIdCheck(String us_id)호출");
	   return sqlSession.selectOne(NAMESPACE + ".userIdCheck", us_id);
   }
   
   // 회원가입 - user tel 중복체크
   public String userTelCheck(String us_tel) {
	   logger.debug("DAOImpl : userTelCheck(String us_tel)호출");
	   return sqlSession.selectOne(NAMESPACE + ".userTelCheck", us_tel);
   }
   
   // 로그인
   public UserVO userLogin(UserVO loginVO) {
      logger.debug("DAOImpl : userLogin()호출 ");
      return sqlSession.selectOne(NAMESPACE + ".userLogin",loginVO);
   }
   
   // 회원 정보 조회(내정보)
   public UserVO userInfo(String us_id) {
      logger.debug("DAOImpl : getUser(String us_id) 호출 ");
      return sqlSession.selectOne(NAMESPACE + ".userInfo",us_id);
   }

   
   // 회원정보 수정
   public void userInfoUpdate(UserVO userInfoUpdateVO) {
	   logger.debug("DAOImpl : userInfoUpdate(UserVO userInfoUpdateVO) 호출");
	   sqlSession.update(NAMESPACE + ".userInfoUpdate", userInfoUpdateVO);
       logger.debug(" DAOImpl : 수정완료");
         
  }

   // 회원 탈퇴
   public int userDelete(UserVO deleteVO) {
	   logger.debug("DAOImpl : userDelete(UserVO deleteVO)호출 ");
	   logger.debug("DAOImpl : 탈퇴 완료");
	   return sqlSession.delete(NAMESPACE + ".userDelete",deleteVO);
   }
      
      
	
}
