package com.may.domain;

import lombok.Data;

/*
 * 페이징처리 (+페이지 블럭)
 */
@Data
public class PageVO {
	
	   private int totalCount;   // 총 글의 수
	   private int startPage;   // 페이지 블럭 시작 번호
	   private int endPage;   // 페이지 블럭 끝 번호
	   private boolean prev;   // 이전
	   private boolean next;   // 다음
	   
	   private int displayPageNum = 3;   // 페이지블럭의 크기(개수)
	      
	   private Criteria cri;   // 페이지 정보, 페이지 사이즈 저장객체
	   
	   public void setTotalCount(int totalCount) {
		      this.totalCount = totalCount;
		      System.out.println("totalCount : " + totalCount);
		      calcPageData();
	   }
	   
	   // 페이징처리에 필요한 정보를 계산하는 메서드
	   public void calcPageData() {
	      endPage = (int)( Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum );
	      startPage = (endPage-displayPageNum)+1;   
	      System.out.println("Math.ceil(cri.getPage() : " + Math.ceil(cri.getPage()));
	      System.out.println("endPage : " + endPage);
	      System.out.println("displayPageNum : " + displayPageNum);
	      int tmpEndPage = (int)(Math.ceil(totalCount/(double)cri.getPageSize()));
	      System.out.println("tmpEndPage : " + tmpEndPage);
	      
	      if(endPage > tmpEndPage) {
	    	  System.out.println("if");
	         endPage = tmpEndPage;
	      }
	      
	      prev = startPage != 1;
	      next = endPage * cri.getPageSize() < totalCount;
	      
	   } // calcPageData()
}
