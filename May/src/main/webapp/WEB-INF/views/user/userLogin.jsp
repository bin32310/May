<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<style>

.userLogin{
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	text-align: center;
}

.btn_blue{
	width : 50%;
	height: 60px;
}

.login_id, .login_pw{
	width : 50%;
	height: 60px;
}

.login_section{
	padding: 10px;
}

</style>    

<c:if test="${ not empty us_id}">
	${"<script>alert('잘못된 접근입니다.');location.href='../user/userMain';</script>" }
</c:if>
<!-- 	
		<h1> /user/userLogin.jsp</h1>
		<h1> 유저 로그인페이지</h1>
-->

	<div>
		<br><hr><br><br>
		<div class="userLogin">
			<div class="login_section">
				<h1> 로그인 </h1><br>
				<form action="" id="us_login_form" name="us_login_form" method="post">
					<input type="text" id="us_id" class="login_id" name="us_id" placeholder="아이디" required="required"> <br>		
					<input type="password" id="us_pw" class="login_pw" name="us_pw" placeholder="비밀번호" required="required"> <br><br>  
					<input type="button" id="login" class="btn_blue" value="로그인">
				</form>
			</div>
			<div>
				<a href="userJoin" >회원가입</a> | 
				<a href="userFindId" >아이디찾기</a> |
				<a href="../user/userFindPw" >비밀번호찾기</a>
			</div>
		</div>
	</div>
<%@ include file="../include/footer.jsp" %>
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
					alert("회원정보가 없습니다.");
				}
			} // success 끝	
		}); // ajax 끝
	}); // #login.click
	
	
});			



</script>
</body>
</html>