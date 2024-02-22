package com.may.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("BoardVO")
public class BoardVO {
	
	// 회원이 쓴 글
	
	private int bo_num; // 게시글 번호(AI)
	private String us_id; // 아이디(이메일)
	private String bo_title; // 제목
	private String bo_content; // 내용
	private int bo_view; // 조회수
	private String bo_state; // 글 상태(upload, delete)
	private String bo_lock; // 글 공개/비공개(lock, unlock)
	private String bo_reply; // 답변여부(no - 미답변, yes - 답변완료)
	
	private UserVO userVO; // userVO

}
