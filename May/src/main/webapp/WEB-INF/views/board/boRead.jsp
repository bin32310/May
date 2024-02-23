<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:choose>
	<c:when test="${!empty us_id && us_id.equals('admin')}">
		<%@ include file="../include/adminHeader.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="../include/userHeader.jsp" %>
	</c:otherwise>
</c:choose>
<!-- 	
		<h1> /board/boRead.jsp</h1>
		<h1> 유저 글읽기</h1>
-->
<style type="text/css">


#boRead_form{

	width: 100%;
	height: auto;
	text-align: center;
	margin-left: 15px;
}

input[type=text], textarea{

	background-color:transparent;
	border: none;
}
.form_div{
	margin-left: 25%;
	margin-right:25%;
	
}
.form_content{
	text-align: left;
}

#update {
	display : inline;
}

#updateOk, #unlock_radio_btn, #lock_radio_btn, #unlock_text, #lock_text {
	display : none;
}

#bo_title{
	width: 330px;
}

#us_nickname{
	width: 150px;
}

#bo_view{
	width: 50px;
	text-align: left;
}

.button_section{
	width : 100%; 
	text-align: center;
	right:0;
}

#alreadyDeleteText{
	color : red;
	border: none;
	display: inline;
}


</style>

<!-- 로그인 확인 -->
<c:if test="${empty us_id}">
	${"<script>alert('로그인이 필요합니다.');location.href='../user/userLogin';</script>" }
</c:if>

<!-- 삭제된 게시글 -->
<c:if test="${ !us_id.equals('admin') && boRead.bo_state.equals('delete')}">
	${"<script>alert('존재하지 않는 게시글입니다.');location.href='../user/userMain';</script>" }
</c:if>

<!-- 비공개 글 --> <!-- 비공개 글이고 관리자가 쓴글이 아닐 때 (원글이란 뜻)-->
<c:if test="${ boRead.bo_lock.equals('lock') && !boRead.us_id.equals('admin') }">
	<!-- 들어온 사람이 관리자가 아니고 작성자가 아니면 -->
	<c:if test="${!us_id.equals('admin') && !boRead.us_id.equals(us_id) }">
		${"<script>alert('비공개글은 작성자만 확인할 수 있습니다.');location.href='../user/userMain';</script>" }
	</c:if>
</c:if>

<!-- 비공개 답글 --> <!-- 비공개 글이고 관리자가 쓴글이면 (답변이란 뜻) -->
<c:if test="${ boRead.bo_lock.equals('lock') && boRead.us_id.equals('admin')}">
	<!-- 들어온 사람이 관리자나 작성자가 아니면 -->
	<c:if test="${!us_id.equals('admin') && !us_id.equals(writer) }">
		${"<script>alert('비공개답변입니다.');location.href='../user/userMain';</script>" }
	</c:if>
</c:if>

	<div>
		<br><hr><br><br>
		<div class="form_div">
			<form action="" id="boRead_form" name="boRead_form" method="post">
				<input type="hidden" id="bo_num" name="bo_num" value="${boRead.bo_num }" >
				<input type="hidden" id="re_ref" name="re_ref" value="${boRead.re_ref }" >
				<input type="hidden" id="bo_reply" name="bo_reply" value="${boRead.bo_reply }" >
				<input type="hidden" id="bo_lock_now" name="bo_lock_now" value="${boRead.bo_lock }">
				<div class="form_content">
				<h1 class="board_number">${boRead.bo_num }번째 글 
				<c:if test="${boRead.bo_state.equals('delete') }">
					<input id="alreadyDeleteText" value="삭제됨">
				</c:if>
				<c:if test="${boRead.bo_lock.equals('lock') }">
					<img alt="lock_icon" src="../resources/img/lock_icon.png" width="30px" height="30px">
				</c:if>
				</h1>
				<input type="hidden" id="bo_num" name="bo_num" value="${boRead.bo_num }">
				<label for="bo_title">제목 : &nbsp <input type="text" id="bo_title" name="bo_title" value="${boRead.bo_title }" disabled="disabled">	</label>&nbsp	
		   		<label for="us_nickname">글쓴이 : &nbsp <input type="text" id="us_nickname" name="us_nickname" value="${boRead.userVO.us_nickname }" disabled="disabled" ></label>&nbsp			
		   		<label for="bo_view">조회수 : &nbsp <input type="text" id="bo_view" name="bo_view" value="${boRead.bo_view }" disabled="disabled" ></label>		
		   		
		   		<label for="unlock" id="unlock_text" >
		   			공개
		   			<input type="radio" id="unlock_radio_btn" name="bo_lock" value="unlock" checked="checked" disabled="disabled" >
	   			</label>			
		   		<label for="lock" id="lock_text" >
		   			비공개
		   			<input type="radio" id="lock_radio_btn" name="bo_lock" value="lock" disabled="disabled" >
	   			</label>			
				<hr>
				<textarea rows="5" cols="100" id="bo_content" name="bo_content" disabled="disabled">${boRead.bo_content }</textarea><br>
				<div class="button_section">
					<c:if test="${us_id.equals(boRead.us_id)}">
						<input type="button" id="update" class="btn_blue" value="수정하기">
						<input type="button" id="updateOk" class="btn_blue" value="수정완료">
						<input type="button" id="delete" class="btn_red" value="삭제하기">
					</c:if>
					<c:if test="${boRead.bo_reply.equals('yes')}">
						<input type="button" class="btn_blue" id="goReply" value="답변보기">
					</c:if>
					<c:if test="${boRead.bo_reply.equals('re')}">
						<input type="button" class="btn_blue" id="goOrigin" value="원글보기">
					</c:if>
					<c:if test="${us_id.equals('admin') && boRead.bo_state.equals('upload') && boRead.bo_reply.equals('no')}">
						<input type="button" id="admin_reply" class="btn_blue" value="답변하기">
					</c:if>
					<input type="button" id="back" class="btn_gray" value="목록으로" onclick="location.href='../user/userMain';">
				</div>			
				</div>
			</form>
		</div>
		<br><br>
	</div>
	
<!-- 글 삭제하기 버튼 클릭시 Modal -->
<div id="deleteModal" class="modal">
	<div class="modal_content">
		<div class="modal_header">
			<h4 class="modal-title">글을 삭제 하시겠습니까?</h4>
		</div>
		<div class="modal_footer">
			<button type="button" class="modal_btn_yes" id="deleteModalYes">네</button>
			<button type="button" class="modal_btn_no" id="deleteModalNo">아니오</button>
		</div>
	</div>
	<div class="modal_layer"></div>
</div>

<!-- 답변하기 버튼 클릭시 Modal -->
<div id="replyModal" class="modal">
	<div class="modal_content">
		<form action="" method="post">
			<div class="modal_header">
				<h4 class="modal-title">${boRead.bo_num }번째 글 답변</h4>
					<textarea rows="5" cols="30" id="bo_reply_content" name="bo_reply_content" placeholder="답변내용"></textarea><br>
			</div>
			<div class="modal_footer">
				<button type="button" class="modal_btn_yes" id="replyModalYes">답변등록</button>
				<button type="button" class="modal_btn_no" id="replyModalNo">취소</button>
			</div>
		</form>
	</div>
	<div class="modal_layer"></div>
</div>


<%@ include file="../include/footer.jsp" %>

</body>
<script type="text/javascript">
$(document).ready(function(){
	
	// 공개여부 체크
	var lock_check = $('#bo_lock_now').val();
	if(lock_check == "lock"){
		$('#lock_radio_btn').prop('checked', true);
	}
	
	// 삭제하기 버튼 클릭 시 Modal show
	$('#delete').click(function(){
		$('#deleteModal').css("display","block");
	}); // #delete.click
	
	// 삭제 Yes
	$('#deleteModalYes').click(function(){
		
		var bo_reply = $('#bo_reply').val();
		var re_ref = $('#re_ref').val();
		
		$.ajax({
			type : "post",
			url : "/board/boDelete",
			data : {"bo_reply" : bo_reply, "re_ref" : re_ref},
			dataType : "JSON",
			error: function(){
				alert("삭제 에러");
			},
			success : function(data){
				if(data >= 1){
					alert("삭제 완료");
					location.replace("../user/userMain");
				}else{
					alert("삭제 실패");
					location.reload();
				}
			} // success 끝	
		}); // ajax 끝
	}); //#deleteModalYes.click
	
	// 삭제 No
	$('#deleteModalNo').click(function(){
		$('#deleteModal').css("display","none");		
	});
	
	// 수정하기 버튼 클릭 시
	$('#update').click(function(){
		$('#bo_title').attr("disabled",false);
		$('#bo_content').attr("disabled",false);
		
		$('#update').css("display","none");
		$('#updateOk').css("display","inline");
		
		$('#lock_radio_btn').attr("disabled",false);
		$('#lock_radio_btn').css("display","inline");
		$('#unlock_radio_btn').attr("disabled",false);
		$('#unlock_radio_btn').css("display","inline");
		
		$('#lock_text').css("display","inline");
		$('#unlock_text').css("display","inline");
		

	}); // #modefy.click
	
	// 수정완료 버튼 클릭 시
	$('#updateOk').click(function(){
		
		$.ajax({
			type : "post",
			url : "/board/boUpdate",
			data : $("#boRead_form").serialize(),
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
	
	
	// 답변하기 버튼 클릭 시 Modal show
	$('#admin_reply').click(function(){
		$('#replyModal').css("display","block");
	}); // #admin_reply.click
	
	// 답변 Yes
	$('#replyModalYes').click(function(){
		
		var bo_num = $('#bo_num').val();
		var bo_content = $('#bo_reply_content').val();
		var bo_lock = $('#bo_lock_now').val();
		
		$.ajax({
			type : "post",
			url : "/admin/boReply",
			data : {"bo_num" : bo_num, "bo_content" : bo_content ,  "bo_lock" : bo_lock },
			dataType : "JSON",
			error: function(){
				alert("답변등록 에러");
			},
			success : function(data){
				if(data == 1){
					$('#replyModal').css("display","none");	
					$('#admin_reply').css("display","none");
					alert("답변등록 완료");
					
				}else{
					alert("답변등록 실패");
				}
			} // success 끝	
		}); // ajax 끝
	}); //#replyModalYes.click
	
	// 답변 No
	$('#replyModalNo').click(function(){
		$('#replyModal').css("display","none");		
		$('#bo_reply_content').val("");
	});
	
	// 답변보기 버튼
	$('#goReply').click(function(){
		
		var re_ref = $('#re_ref').val();
		
		$.ajax({
			type : "post",
			url : "/board/goReply",
			data : {"re_ref" : re_ref },
			dataType : "JSON",
			error: function(){
				alert("답변보기 에러");
			},
			success : function(data){
				if(data != null){
					//alert("답변보기 완료");
					location.href="../board/boRead?bo_num="+data;
				}else{
					alert("답변보기 실패");
				}
			} // success 끝	
		}); // ajax 끝
	});
	
	// 원글보기 버튼
	$('#goOrigin').click(function(){
		
		var re_ref = $('#re_ref').val();
		
		$.ajax({
			type : "post",
			url : "/board/goOrigin",
			data : {"re_ref" : re_ref },
			dataType : "JSON",
			error: function(){
				alert("원글보기 에러");
			},
			success : function(data){
				if(data != null){
					//alert("원글보기 완료");
					location.href="../board/boRead?bo_num="+data;
				}else{
					alert("원글보기 실패");
				}
			} // success 끝	
		}); // ajax 끝
	});
	
});	// $(document) 끝	
		


</script>
</html>