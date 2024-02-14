<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/userHeader.jsp" %>

<!-- 	
		<h1> /user/userMain.jsp</h1>
		<h1> 유저 메인페이지</h1>
-->


	

		<c:if test="${!empty us_id && !us_id.equals(admin)}">
				<a href="../board/boWrite">글 쓰기</a>
		</c:if>
		<div id="board_list"> <!-- list_section -->
			<table border='1'>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="bl" items="${boardList}">
					<tr>
						<td> ${bl.bo_num }</td>
						<td><a href="../board/boRead?bo_num=${bl.bo_num}"> ${bl.bo_title }</a></td>
						<td> ${bl.userVO.us_nickname }</td>
						<td> ${bl.bo_view }</td>
					</tr>
				</c:forEach>
			</table>
		</div><!-- list_section -->
<%@ include file="../include/userFooter.jsp" %>

</body>
</html>