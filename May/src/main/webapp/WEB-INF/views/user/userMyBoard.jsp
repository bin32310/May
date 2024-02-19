<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<style>

.board_section{
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	padding-left: 10%;
	padding-right: 10%;
	
}

table td .tb_view{
	text-align: center;
}

table th, table td{
	color : #000000;
}

</style>

<c:if test="${empty us_id}">
	${"<script>alert('잘못된 접근입니다.');location.href='../user/userMain';</script>" }
</c:if>
<!-- 	
		<h1> /user/userMyBoard.jsp</h1>
		<h1> 내 글 관리 페이지</h1>
-->
	<div>
		<br><hr><br><br>
		<div class="board_section">
			<h1> 내 글 관리 </h1>
			<br>
			<c:if test="${!empty us_id && !us_id.equals('admin')}">
					<input type="button" class="btn_blue" value="글쓰기" onclick="location.href='../board/boWrite';"> <br><br>
			</c:if>
			<div class="board_list"> <!-- list_section -->
				<table>
					<tr>
						<th class="tb_num">번호</th>
						<th class="tb_title">제목</th>
						<th class="tb_writer">글쓴이</th>
						<th class="tb_view">조회수</th>
					</tr>
					<c:forEach var="bl" items="${boardList}">
							<tr>
								<td class="tb_num"> ${bl.bo_num }</td>
								<td class="tb_title tb_td_title"><a href="../board/boRead?bo_num=${bl.bo_num}"> ${bl.bo_title }</a></td>
								<td class="tb_writer tb_td_writer"> ${bl.userVO.us_nickname }</td>
								<td class="tb_view"> ${bl.bo_view }</td>
							</tr>
					</c:forEach>
				</table>
			</div><!-- list_section 끝 -->
			
			<div class="board_clearfix"><!-- 페이지 번호 -->
				<ul class="pagination pagination-sm no-margin pull-right">
					<c:if test="${pageVO.prev == true }">
						<li><a href="userMypage?page=${pageVO.startPage-1 }">«</a></li>
						&nbsp
					</c:if>
					
					<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
						&nbsp&nbsp
						<li ${pageVO.cri.page == i? 'class="active"':'' }><a href="userMypage?page=${i }">${i }</a></li>
						&nbsp&nbsp
					</c:forEach>
					
					<c:if test="${pageVO.next == true }">
						&nbsp
						<li><a href="userMypage?page=${pageVO.endPage+1 }">»</a></li>
					</c:if>
				</ul>
			</div><!-- 페이지 번호 끝-->
		</div>
	</div>

<%@ include file="../include/footer.jsp" %>
<script type="text/javascript">

$(document).ready(function(){
	

}); // document 끝 
</script>
</body>
</html>