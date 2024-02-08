<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userMain</title>

</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>

<!-- 	
		<h1> /user/userMain.jsp</h1>
		<h1> 유저 메인페이지</h1>
-->

		<c:if test="${empty us_id }">
				<a href="../user/userLogin">로그인</a>
				<a href="../user/userJoin">회원가입</a>
				<input type="hidden" value="${us_id }" id="session_us_id">
		</c:if>
		<c:if test="${!empty us_id && !us_id.equals(admin)}">
				<a href="../board/boWrite">글쓰기</a>
				<a id="us_logout_btn">로그아웃</a>
		</c:if>
		<c:if test="${!empty us_id && us_id.equals(admin)}">
				<a href="../admin/adminMain">관리페이지</a>
		</c:if>
				


	
	<div id="board_list"> <!-- list_section -->
		<c:forEach var="bl" items="${boardList}">
			<div class="list_section">
				<a href="../board/read?bo_num=${bl.bo_num}">
					<input type="text" value="${bl.bo_title }" name="bo_title" disabled="disabled">
					<input type="text" value="${bl.bo_write }" name="bo_write" disabled="disabled">
				</a>
			</div>
		</c:forEach> 
	</div><!-- list_section -->

	
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