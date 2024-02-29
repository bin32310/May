<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="../include/userHeader.jsp" %>  
<style>
.btn_blue{
	text-align: center;
}

.find_id{
	width : 50%;
	height: 60px;
}

#findIdBtn{

}

</style>
<c:if test="${!empty us_id}">
	${"<script>alert('잘못된 접근입니다.');location.href='../user/userMain';</script>" }
</c:if>

<!-- 	
		<h1> /user/userFindId.jsp</h1>
		<h1> 유저 아이디 찾기 페이지</h1>
-->

	<div>
		<div>
			<form action="" id="us_find_id_form" method="post">
				<input type="text" id="us_name" class="find_id" name="us_name" placeholder="이름" required="required"> <br>		
				<input type="text" id="us_tel" class="find_id" name="us_tel" placeholder="전화번호" required="required"> <br>  
				<input type="button" class="btn_blue" id="findIdBtn" value="아이디 찾기">
			</form>
		</div>
		<div>
			<a href="userLogin" >로그인</a> |
			<a href="userJoin" >회원가입</a> | 
			<a href="userFindPw" >비밀번호찾기</a>
		</div>
	</div>
	
<%@ include file="../include/footer.jsp" %>	
<script type="text/javascript">

$(document).ready(function(){
	
	var us_name = false;
	var us_tel = false;
	
	$('#us_name').keyup(function(){
		
		if($('#us_name').val().length >=1){
			us_name = true;
		}else{
			us_name = false;
		}
		
	});
	
	$('#us_tel').keyup(function(){
		
		if($('#us_tel').val().length >=1){
			us_tel = true;
		}else{
			us_tel = false;
		}
		
	});
	
	$('#findIdBtn').click(function(){
		
		if(!us_name){
			$('#us_name').focus();
			alert("이름을 입력하세요.");
			return;
		}
		
		if(!us_tel){
			$('#us_tel').focus();
			alert("전화번호를 입력하세요.");
			return;
		}
		
		$.ajax({
			type : "post",
			url : "/user/userFindId",
			data : $("#us_find_id_form").serialize(),
			dataType : "text",
			error: function(){
				alert("아이디 찾기 에러");
			},
			success : function(data){
				if(data=="없음"){
					alert("회원정보가 존재하지 않습니다.");
				}else{
					alert("회원님의 아이디는 " + data + "입니다.");
					location.href="../user/userLogin";
				}	
			} // success 끝	
		});	// ajax 끝 
	});
	
	
	
});

</script>	


</body>
</html>