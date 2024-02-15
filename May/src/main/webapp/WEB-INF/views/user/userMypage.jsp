<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<style>

/* 아이디/전화번호 유효성 체크 */
.id_check , .pw_check, .nick_check, .tel_check{
	display : none;
}
#id_ok, #pw_ok, #tel_ok{
	color:GREEN;
}
#id_no, #pw_no, #pwCk_no, #nick_no, #tel_no{
	color:RED;
}

#us_update_check{
	display: none;
}

.text_area{
	width: 80px;
	height: 30px;
}

</style>

<c:if test="${ empty us_id}">
	${"<script>alert('잘못된 접근입니다.');location.href='../user/userMain';</script>" }
</c:if>
<!-- 	
		<h1> /user/userMypage.jsp</h1>
		<h1> 유저 내정보 페이지</h1>
-->
	<div>
		<br><hr><br><br>
		<div >
			<form action="" id="us_info_form" name="us_info_form" method="POST" onsubmit="joinCheck();">
				<h1> 내정보 </h1>
				<div class="text_area"> 아이디 </div> <input type="text" id="us_id" name="us_id" value="${userInfo.us_id }" required="required" disabled="disabled"> <br><br>
				<div class="text_area"> 이름 </div> <input type="text" id="us_name" name="us_name" value="${userInfo.us_name }" required="required" disabled="disabled"> <br><br>
				<div class="text_area"> 닉네임 </div> <input type="text" id="us_nickname" name="us_nickname" value="${userInfo.us_nickname }" required="required" disabled="disabled" onkeyup="nicknameCheck();"> <br><br> 
				<div class="text_area"> 전화번호 </div> <input type="text" id="us_tel" name="us_tel" value="${userInfo.us_tel }" required="required" disabled="disabled"> <br><br>
				<input type="button" id="us_pw_update" value="비밀번호 변경">  
				<input type="button" id="us_update" value="수정하기">
				<input type="button" id="us_update_check" value="수정완료">
				<input type="button" id="us_delete" value="탈퇴하기">
			</form>
		</div>
	</div>
	
<!-- 비밀번호 변경 버튼 클릭시 Modal -->
<div id="pw_update_Modal" class="modal fade" role="dialog">
	<div class="modal-dialog ">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">비밀번호 변경</h4>
				<form action="" id="us_pw_update_form" name="us_pw_update_form" method="POST" onsubmit="pwUpdateCheck();">
					<input type="password" id="us_pw" name="us_pw" placeholder="현재 비밀번호" required="required">
					<input type="password" id="us_pw_new" name="us_pw_new" placeholder="새 비밀번호" required="required">
					<input type="password" id="us_pw_new_check" name="us_pw_new_check" placeholder="새비밀번호 확인" required="required">
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="pwUpdateModalYes">변경</button>
				<button type="button" class="btn btn-default" data-dismiss="modal" id="pwUpdateModalNo">취소</button>
			</div>
		</div>
	</div>
</div>	
	
<%@ include file="../include/userFooter.jsp" %>
<script type="text/javascript">

$(document).ready(function(){

	// 수정하기
	$('#us_update').click(function(){
		$('#us_update').css("display","none");
		$('#us_pw_update').css("display","none");
		$('#us_delete').css("display","none");
		$('#us_update_check').css("display","block");
		$('#us_nickname').attr("disabled",false);
	});
	
	// 수정완료
	$('#us_update_check').click(function(){
			$.ajax({       
				type : "post",
				url : "/user/userMypageUpdate",
				data : $("#us_info_form").serialize(),
				dataType : "JSON",
				error: function(){
					alert("내정보 수정 에러");
				},
				success : function(data){
					if(data==1){
						alert("내정보 수정 완료");
						location.reload();
					}else{
						alert("내정보 수정 실패");
					}	
				} // success 끝	
			}); // ajax 끝
	}); // #us_join_btn
	
	// 비밀번호 변경 
	$('#us_pw_update').click(function(){
		$('#pw_update_Modal').modal("show");
	});
	
	// 비밀번호 변경시 현재 비밀번호 확인
	$('#us_pw').click(function(){
		var us_pw = $('#us_pw').val();
		$.ajax({
			type : "post",
			url : "/user/userPwUpdateCheck",
			data : {"us_pw" : us_pw},
			dataType : "JSON",
			error: function(){
				alert("현재 비밀번호 확인 에러");
			},
			success : function(data){
				if(data == 1){
					console.log("현재 비밀번호 확인 성공");
				}else{
					console.log("현재 비밀번호 확인 실패");
				}
			} // success 끝	
		}); // ajax 끝
	});
	
	// 비밀번호 변경 Yes
	$('#pwUpdateModalYes').click(function(){
		var us_pw_new = $('#us_pw_new').val();
		$.ajax({
			type : "post",
			url : "/user/userPwUpdate",
			data : {"us_pw" : us_pw_new},
			dataType : "JSON",
			error: function(){
				alert("비밀번호 변경 에러");
			},
			success : function(data){
				if(data == 1){
					alert("비밀번호 변경 성공");
					location.reload();
				}else{
					alert("비밀번호 변경 실패");
					location.reload();
				}
			} // success 끝	
		}); // ajax 끝
	}); //#deleteModalYes.click
	
	// 비밀번호 변경 No
	$('#pwUpdateModalNo').click(function(){
		$('#pw_update_Modal').modal("hide");		
	});
	
	
}); // document 끝 


// 비밀번호 확인 체크 
function pwCheck(){
	if($('#us_pw_new').val() == $('#us_pw_new_check').val()){
		$('#pwCk_no').css("display","none");
	}else{
		$('#pwCk_no').css("display","block");
	}
}

// 닉네임 8자 이하 체크
function nicknameCheck(){
	if($('#us_nickname').val().length > 8){
		$('#nick_no').css("display","block");
	}else{
		$('#nick_no').css("display","none");
	}
}

function joinCheck(){
	
		console.log("회원가입 할수있는지 ");

}

//뒤로가기 
function backTo(){
	window.history.back(); 
}

</script>
</body>
</html>