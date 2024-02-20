package com.may.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("UserVO")
public class UserVO {
	
	// user 회원
	
	private String us_id; // 아이디(이메일)
	private String us_pw; // 비밀번호(20자 제한)
	private String us_name; // 이름(실명)
	private String us_nickname; // 닉네임(8자 제한)
	private String us_tel; // 전화번호
	private String us_state; // 회원 상태(join, out)
	private String us_join_date; // 회원가입일
	private String us_out_date; // 회원탈퇴일

}
