
<%@ include file="../include/userHeader.jsp" %>

<!-- 	
		<h1> /user/userMain.jsp</h1>
		<h1> 유저 메인페이지</h1>
-->



		<c:if test="${!empty us_id && !us_id.equals(admin)}">
				<a href="../board/boWrite">글 쓰기</a>
		</c:if>

	
	<div id="board_list"> <!-- list_section -->
		<table border="1">
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<c:forEach var="bl" items="${boardList}">
				<div class="list_section">
					<a href="../board/read?bo_num=${bl.bo_num}">
						<tr>
							<td colspan="2">${bl.bo_num }</td>
							<td colspan="6">${bl.bo_title }</td>
							<td colspan="2">${bl.bo_write }</td>
						</tr>
					</a>
				</div>
			</c:forEach> 
		</table>
	</div><!-- list_section -->


<%@ include file="../include/userFooter.jsp" %>	

<script type="text/javascript">

$(document).ready(function(){
	
	// 로그아웃
	$('#us_logout_btn').click(function(){
			console.log("us_logout_btn.click");
			$.ajax({
				type : "get",
				url : "/user/userLogout",
				error: function(){
					alert("로그아웃 에러");
				},
				success : function(){
					alert("로그아웃 완료");
					location.replace("/user/userMain");	
				} // success 끝	
			}); // ajax 끝
	}); // #us_logout_btn
	
});
</script>
</body>
</html>