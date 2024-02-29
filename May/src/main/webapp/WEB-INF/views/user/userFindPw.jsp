<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="../include/userHeader.jsp" %>  
<style>

.find_pw{
	width : 50%;
	height: 60px;
}

</style>
<c:if test="${!empty us_id}">
	${"<script>alert('잘못된 접근입니다.');location.href='../user/userMain';</script>" }
</c:if>

<!-- 	
		<h1> /user/userFindPw.jsp</h1>
		<h1> 유저 비밀번호 찾기 페이지</h1>
-->

	<div>
		<div>
		<form action="" id="us_find_pw_form" method="post">
			<input type="text" id="us_id" class="find_pw" name="us_id" maxlength="30" placeholder="아이디"> <br>		
			<input type="text" id="us_tel" class="find_pw" name="us_tel" maxlength="11" placeholder="(-를 제외한)전화번호"> <br> 
			<input type="button" class="btn_blue" id="findPwBtn" value="비밀번호 찾기" 	style="width : 130px;">
			</form>
		</div>
		<div>
			<a href="useLogin" >로그인</a> |
			<a href="userJoin" >회원가입</a> | 
			<a href="userFindId" >아이디찾기</a>
		</div>
	</div>
	
<%@ include file="../include/footer.jsp" %>	
<script type="text/javascript">

$(document).ready(function(){
	
	var us_id = false;
	var us_tel = false;
	
	$('#us_id').keyup(function(){
		
		if($('#us_id').val().length >=1){
			us_id = true;
		}else{
			us_id = false;
		}
		
	});
	
	$('#us_tel').keyup(function(){
		
		if($('#us_tel').val().length >=1){
			us_tel = true;
		}else{
			us_tel = false;
		}
		
	});
	
	$('#findPwBtn').click(function(){
		
		if(!us_id){
			$('#us_id').focus();
			alert("아이디를 입력하세요.");
			return;
		}
		
		if(!us_tel){
			$('#us_tel').focus();
			alert("전화번호를 입력하세요.");
			return;
		}
		
		$.ajax({
			type : "post",
			url : "/user/userFindPw",
			data : $("#us_find_pw_form").serialize(),
			dataType : "text",
			error: function(){
				alert("비밀번호 찾기 에러");
			},
			success : function(data){
				if(data=="없음"){
					alert("회원정보가 존재하지 않습니다.");
				}else{
					alert("회원님의 비밀번호는 " + data + "입니다.");
					location.href="../user/userLogin";
				}	
			} // success 끝	
		});	// ajax 끝 
	});
	
	
	
});

</script>

</body>
</html>