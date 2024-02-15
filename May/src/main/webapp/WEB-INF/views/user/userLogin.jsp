<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
    
<c:if test="${ not empty us_id}">
	${"<script>alert('잘못된 접근입니다.');location.href='../user/userMain';</script>" }
</c:if>
<!-- 	
		<h1> /user/userLogin.jsp</h1>
		<h1> 유저 로그인페이지</h1>
-->

	<div>
		<div>
			<h1> 로그인 </h1>
			<fieldset>
				<form action="" id="us_login_form" name="us_login_form" method="post">
					<input type="text" id="us_id" name="us_id" placeholder="아이디" required="required">		
					<input type="password" id="us_pw" name="us_pw" placeholder="비밀번호" required="required">  
					<input type="button" id="login" value="로그인">
				</form>
			</fieldset>
		</div>
		<div>
			<input type="button" value="회원가입" onclick="location.href='/user/userJoin';"> | 
			<input type="button" value="아이디찾기" onclick="location.href='/user/userFindId';"> |
			<input type="button" value="비밀번호찾기" onclick="location.href='/user/userFindPw';"> |
			<input type="button" id="back" value="돌아가기" onclick="back();">
		</div>
	</div>
<%@ include file="../include/userFooter.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	
	
	// 로그인 버튼 클릭 시
	$('#login').click(function(){
		$.ajax({
			type : "post",
			url : "/user/userLogin",
			data : $("#us_login_form").serialize(),
			dataType : "JSON",
			error: function(){
				alert("로그인 에러");
			},
			success : function(data){
				if(data == 1){
					alert("로그인 성공");
					location.replace("/user/userMain");
				}else{
					alert("아이디 또는 비밀번호가 틀렸습니다.");
				}
			} // success 끝	
		}); // ajax 끝
	}); // #login.click
	
	
});			
		
//뒤로가기 
function back(){
	history.back(); 
}	


</script>
</body>
</html>