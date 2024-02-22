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
	
	private int re_ref; // 답글의 그룹번호
						// 일반글 : 글 번호와 동일(bno == re_ref)
						// 답글 : 원글의 그룹번호와 동일(re_ref==re_ref)
	
	private int re_lev; // 답글의 들여쓰기(레벨)
						// 일반글 : 항상 0 (들여쓰기 없음)
						// 답글 : 원글(기준)의 re_lev + 1 
	
	private int re_seq; // 답글의 순서(시퀀스)
						// 일반글 : 항상 0 (일반글이 가장 위쪽에 위치) 
						// 답글 : 원글(기준)의 re_seq + 1 
	
	private UserVO userVO; // userVO

}
