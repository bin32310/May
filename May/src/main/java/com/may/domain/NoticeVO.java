package com.may.domain;

import lombok.Data;

@Data
public class NoticeVO {
	
	// 관리자가 쓴 글 (공지사항)
	
	private int no_num; // 게시글 번호(AI)
	private String no_title; // 제목
	private String no_content; // 내용
	private String no_img; // 이미지

}
