package com.may.domain;

import lombok.Data;

/**
 * 페이징 처리를 계산하는 기준들
 */
@Data
public class Criteria{
	
	private int page;
	private int pageSize; // 한페이지에 표시되는 리스트 개수
	private String keyword;
	
	// 기본 설정
	public Criteria() {
		this.page = 1;
		this.pageSize = 6; // 한페이지에 표시되는 리스트 개수
	}
	
	// 
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	// 
	public void setPageSize(int pageSize) {
		if(pageSize <= 0 || pageSize > 100) {
			this.pageSize = 10;
			return;
		}
		this.pageSize = pageSize;
	}
	
	// 변수를 저장하기위한 목적X
	// mapper에서 호출되는 메서드 #{pageStart }를 호출함
	public int getPageStart() {
		return (this.page -1 ) * pageSize;
	}


}
