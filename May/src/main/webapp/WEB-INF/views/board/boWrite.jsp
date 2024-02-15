<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userLogin</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.0/jquery.validate.min.js"></script>
<body>

<!-- 	
		<h1> /board/boWrite.jsp</h1>
		<h1> 유저 글쓰기</h1>
-->

<c:if test="${empty us_id || us_id.equals(null)}">
 <c:redirect url="../user/userLogin"/> 
</c:if>

	<div>
		<div>
			<h1> 글 작성 </h1>
			<fieldset>
				<form action="" id="boWrite_form" name="boWrite_form" method="post">
					<input type="text" id="bo_title" name="bo_title" placeholder="글제목" required="required">		
					<hr>
					<textarea rows="5" cols="10" id="bo_content" name="bo_content" placeholder="내용" required="required"></textarea> <br>
					<input type="file" name="uploadFile" multiple> <br>
					<div id="button_section">
						<input type="button" id="upload" value="등록하기">
						<input type="button" id="back" value="돌아가기" onclick="back();">
					</div>			
				</form>
			</fieldset>
		</div>
	</div>
<%@ include file="../include/userFooter.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	
	//#us_join_form.validate
	$("#boWrite_form").validate({
		rules:{
			bo_title:{required:true, rangelength:[1,30]},
			bo_content:{required:true, maxlength:500 }
		},
		messages:{
			bo_title:{required:"제목을 입력해주세요.", rangelength:"제목은 {0}자 이상, {1}자 이하만 가능합니다." },
			bo_content:{required:"내용을 입력해주세요.", maxlength:"내용은 {0}자까지만 입력 가능합니다."}
		}
	}); // #boWrite_form.validate
	
	// 등록하기 버튼 클릭 시
	$('#upload').click(function(){
		if($("#boWrite_form").valid()){
			console.log("if");
			$.ajax({
				type : "post",
				url : "/board/boWrite",
				data : $("#boWrite_form").serialize(),
				dataType : "JSON",
				error: function(){
					alert("글 등록 에러");
				},
				success : function(data){
					if(data == 1){
						alert("글 등록 성공");
						location.replace("/user/userMain");
					}else{
						alert("글 등록 실패");
					}
				} // success 끝	
			}); // ajax 끝
		} // if
	}); // #upload.click
	
	
	
});			
		
	
//뒤로가기 
function back(){
	history.back(); 
}

</script>
</body>
</html>