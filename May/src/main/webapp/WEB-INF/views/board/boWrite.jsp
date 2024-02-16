<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.0/jquery.validate.min.js"></script>
<style>
.bowrite_section{
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	text-align: center;
}

.write_section{
	padding: 10px;
}

.board_title{
	width : 50%;
	height: 40px;
}

.board_content{
	width : 50%;
	resize: none;
}

.btn_blue, .btn_gray{
	width : 25%;
	height: 40px;
}


</style>
<!-- 	
		<h1> /board/boWrite.jsp</h1>
		<h1> 유저 글쓰기</h1>
-->

<c:if test="${empty us_id || us_id.equals(null)}">
 <c:redirect url="../user/userLogin"/> 
</c:if>

	<div>
		<br><hr><br><br>
		<div class ="bowrite_section">
			<div class="write_section">
				<h1> 글 작성 </h1>
				<form action="" id="boWrite_form" name="boWrite_form" method="post">
					<input type="text" id="bo_title" class="board_title" name="bo_title" placeholder="글제목" required="required"><br><br>	
					<textarea rows="5" id="bo_content" class="board_content" name="bo_content" placeholder="내용" required="required" style="resize:none"></textarea><br><br>
					<div id="button_section">
						<input type="button" id="upload" class="btn_blue" value="등록하기">
						<input type="button" id="back"  class="btn_gray" value="돌아가기" onclick="backTo();">
					</div>			
				</form>
			</div>
		</div>
	</div>
<%@ include file="../include/userFooter.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	
	//#us_join_form.validate
	$("#boWrite_form").validate({
		rules:{
			bo_title:{required:true, rangelength:[1,20]},
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
function backTo(){
	history.back(); 
}

</script>
</body>
</html>