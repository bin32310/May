<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<!-- 	
		<h1> /board/boRead.jsp</h1>
		<h1> 유저 글읽기</h1>
-->
<style type="text/css">
#modify {
	display : block;
}

#modifyOk {
	display : none;
}

</style>
<c:if test="${empty us_id}">
	${"<script>alert('로그인이 필요합니다.');location.href='../user/userLogin';</script>" }
</c:if>
<c:if test="${boRead.bo_state.equals('삭제')}">
	${"<script>alert('존재하지 않는 게시글입니다.');location.href='../user/userMain';</script>" }
</c:if>

	<div>
		<div>
			<fieldset>
				<form action="" id="boRead_form" name="boRead_form" method="post">
					<input type="text" id="bo_title" name="bo_title" value="${boRead.bo_title }" disabled="disabled">		
					<input type="text" id="us_nickname" name="us_nickname" value="${boRead.userVO.us_nickname }" disabled="disabled">		
					<input type="text" id="bo_view" name="bo_view" value="${boRead.bo_view }" disabled="disabled">		
					<hr>
					<textarea rows="5" cols="10" id="bo_content" name="bo_content" disabled="disabled">${boRead.bo_content }</textarea> <br>
					<div id="button_section">
					<c:if test="${us_id.equals(boRead.us_id)}">
						<input type="button" id="modify" value="수정하기">
						<input type="button" id="modifyOk" value="수정완료">
						<input type="button" id="delete" value="삭제하기">
					</c:if>
						<input type="button" id="back" value="돌아가기" onclick="back();">
					</div>			
				</form>
			</fieldset>
		</div>
	</div>
	
<!-- 글 삭제하기 버튼 클릭시 Modal -->
<div id="deleteModal" class="modal fade" role="dialog">
	<!-- <div class="modal-dialog modal-lg"> -->
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">글을 삭제 하시겠습니까?</h4>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="deleteModalYes">네</button>
				<button type="button" class="btn btn-default" data-dismiss="modal" id="deleteModalNo">아니오</button>
			</div>
		</div>
	</div>
</div>

<%@ include file="../include/userFooter.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	

	// 삭제하기 버튼 클릭 시
	$('#delete').click(function(){
		$('#deleteModal').modal("show");

	}); // #delete.click

	
	// 삭제 Yes
	$('#deleteModalYes').click(function(){
		var bo_num = ${boRead.bo_num};
		$.ajax({
			type : "post",
			url : "/board/boDelete",
			data : {"bo_num" : bo_num},
			dataType : "JSON",
			error: function(){
				alert("글 삭제 에러");
			},
			success : function(data){
				if(data == 1){
					alert("글 삭제 성공");
					location.replace("../user/userMain");
				}else{
					alert("글 삭제 실패");
					location.reload();
				}
			} // success 끝	
		}); // ajax 끝
	}); //#deleteModalYes.click
	
	// 삭제 No
	$('#deleteModalNo').click(function(){
		$('#deleteModal').modal("hide");		
	});
	
	// 수정하기 버튼 클릭 시
	$('#modify').click(function(){
		console.log("수정 클릭");
		$('#bo_title').attr("disabled",false);
		$('#bo_content').attr("disabled",false);
		$('#modify').css("display","none");
		$('#modifyOk').css("display","block");

	}); // #modefy.click
	
	// 수정완료 버튼 클릭 시
	$('#modifyOk').click(function(){
		console.log("수정완료 클릭");
		var bo_title = $('#bo_title').val();
		var bo_content = $('#bo_content').val();
		var bo_num = ${boRead.bo_num};
		$.ajax({
			type : "post",
			url : "/board/boModify",
			data : {"bo_title" : bo_title , "bo_content" :  bo_content, "bo_num" : bo_num},
			dataType : "JSON",
			error: function(){
				alert("글 수정 에러");
			},
			success : function(data){
				if(data == 1){
					alert("글 수정 성공");
					location.reload();
				}else{
					alert("글 수정 실패");
					location.reload();
				}
			} // success 끝	
		}); // ajax 끝

	}); // #modefyOk.click
	
});	// $(document) 끝	
		
	
//뒤로가기 
function back(){
	history.back(); 
}

</script>
</body>
</html>