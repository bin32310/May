<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

#us_update_check , #us_update_not{
	display: none;
}

.text_area{
	width: 80px;
	height: 30px;
}

#us_pw_msg, #us_pw_new_msg, #us_pw_new_check_msg{
	display  :none;
	color : red;
}

.mypage_section{
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	text-align: center;
}

#nickname_no{
	display  :none;
	color:RED;
}

</style>

<c:if test="${empty us_id}">
	${"<script>alert('로그인이 필요한 서비스입니다.');location.href='../user/userLogin';</script>" }
</c:if>
<!-- 	
		<h1> /user/userMypage.jsp</h1>
		<h1> 유저 내정보 페이지</h1>
-->
	<div>
		<br><hr><br><br>
		<div class="mypage_section">
			<div class ="userInfo_section">
				<h1> 내정보 </h1>
				<br>
				<form action="" id="us_info_form" name="us_info_form" method="POST" onsubmit="joinCheck();">
					<span class="text_area"> 아이디 </span> <input type="text" id="us_id" name="us_id" value="${userInfo.us_id }" required="required" disabled="disabled"> <br><br>
					<span class="text_area"> 이름 </span> <input type="text" id="us_name" name="us_name" value="${userInfo.us_name }" required="required" disabled="disabled"> <br><br>
					<span class="text_area"> 닉네임 </span> <input type="text" id="us_nickname" name="us_nickname" value="${userInfo.us_nickname }" maxlength="8" disabled="disabled"> <br><br> 
					<span class="nick_check" id="nickname_no"> 닉네임을 입력해주세요.</span>	
					<span class="text_area"> 전화번호 </span> <input type="text" id="us_tel" name="us_tel" value="${userInfo.us_tel }" disabled="disabled"> <br><br>
					<input type="button" id="us_pw_update" class="btn_blue" value="비밀번호 변경" style="width:130px">  
					<input type="button" id="us_update" class="btn_blue" value="수정하기">
					<input type="button" id="us_update_check" class="btn_blue" value="수정완료">
					<input type="button" id="us_update_not" class="btn_gray" value="수정취소">
					<input type="button" id="us_delete" class="btn_gray" value="탈퇴하기">
				</form>
			</div>
		</div>
	</div>
	
<!-- 비밀번호 변경 버튼 클릭시 Modal -->
<div id="pw_update_Modal" class="modal">
	<div class="modal_content ">
		<div class="modal_header">
			<h4 class="modal-title">비밀번호 변경</h4>
			<form action="" id="us_pw_update_form" name="us_pw_update_form" method="POST">
				<input type="text" id="us_pw" name="us_pw" maxlength="8" placeholder="현재 비밀번호">
				<span id="us_pw_msg">3자 이상 8자 이하만 가능합니다.</span>
				<input type="text" id="us_pw_new" name="us_pw_new" maxlength="8" placeholder="새 비밀번호">
				<span id="us_pw_new_msg">3이상 8자 이하만 가능합니다.</span>
				<input type="text" id="us_pw_new_check" name="us_pw_new_check" maxlength="8" placeholder="새비밀번호 확인"><br>
				<span id="us_pw_new_check_msg">새비밀번호와 일치하지 않습니다.</span>
			</form>
		</div>
		<div class="modal_footer">
			<button type="button" class="modal_btn_yes" id="pwUpdateModalYes">변경</button>
			<button type="button" class="modal_btn_no" id="pwUpdateModalNo">취소</button>
		</div>
	</div>
	<div class="modal_layer"></div>
</div>	

<!-- 탈퇴하기 버튼 클릭시 Modal -->
<div id="us_delete_Modal" class="modal">
	<div class="modal_content ">
		<div class="modal_header">
			<h4 class="modal-title">정말 탈퇴하시겠습니까?</h4>
		</div>
		<div class="modal_footer">
			<button type="button" class="modal_btn_yes" id="usDeleteModalYes">네</button>
			<button type="button" class="modal_btn_no" id="usDeleteModalNo">아니오</button>
		</div>
	</div>
	<div class="modal_layer"></div>
</div>	

<%@ include file="../include/footer.jsp" %>
<script type="text/javascript">

$(document).ready(function(){
	
	var nickname = $('#us_nickname').val();
	var nickname_ok = true;
	var pw_ok = false;
	var pw_new_ok = false;
	var pw_new_check_ok = false;

	// 수정하기
	$('#us_update').click(function(){
		$('#us_update').css("display","none");
		$('#us_pw_update').css("display","none");
		$('#us_delete').css("display","none");
		$('#us_update_check').css("display","inline");
		$('#us_update_not').css("display","inline");
		$('#us_nickname').attr("disabled",false);
	});
	 
	// 수정하기 취소
	$('#us_update_not').click(function(){
		$('#us_update').css("display","inline");
		$('#us_pw_update').css("display","inline");
		$('#us_delete').css("display","inline");
		$('#us_update_check').css("display","none");
		$('#us_update_not').css("display","none");
		$('#us_nickname').val(nickname);
		$('#us_nickname').attr("disabled",true);
		$('#nickname_no').css("display","none");
		nickname_ok = true;
 
		
	});
	
	// 닉네임 체크
	$('#us_nickname').keyup(function(){
		if($('#us_nickname').val().length >= 1){
			$('#nickname_no').css("display","none");
			nickname_ok = true;
		}else{
			$('#nickname_no').css("display","block");
			nickname_ok = false;
		}
	});
	
	// 수정완료
	$('#us_update_check').click(function(){
		
		if(nickname_ok){
			
			$.ajax({       
				type : "post",
				url : "/user/userInfoUpdate",
				data : $("#us_info_form").serialize(),
				dataType : "JSON",
				error: function(){
					alert("수정 에러");
				},
				success : function(data){
					if(data==1){
						alert("수정 완료");
						location.reload();
					}else{
						alert("수정 실패");
					}	
				} // success 끝	
			}); // ajax 끝
		}else{
			$('#nick_no').css("display","block");
			$('#us_nickname').focus();
			nickname_ok = false;
		}
	}); // #us_update_check.click
	
	// 비밀번호 변경 
	$('#us_pw_update').click(function(){
		$('#pw_update_Modal').css("display","block");
	});
	
	// 비밀번호 체크 
	$('#us_pw').keyup(function(){
		if($('#us_pw').val().length >= 3 && $('#us_pw').val().length <= 8){
			$('#us_pw_msg').css("display","none");
			pw_ok  = true;
		}else{
			$('#us_pw_msg').css("display","block");
			pw_ok  = false;
		}
	});
	
	// 새 비밀번호 체크 
	$('#us_pw_new').keyup(function(){
		if($('#us_pw_new').val().length >= 3 && $('#us_pw_new').val().length <= 8){
			$('#us_pw_new_msg').css("display","none");
			pw_new_ok  = true;
		}else{
			$('#us_pw_new_msg').css("display","block");
			pw_new_ok  = false;
		}
	});
	
	// 새 비밀번호 확인 체크 
	$('#us_pw_new_check').keyup(function(){
		if($('#us_pw_new').val() == $('#us_pw_new_check').val()){
			$('#us_pw_new_check_msg').css("display","none");
			pw_new_check_ok  = true;
		}else{
			$('#us_pw_new_check_msg').css("display","block");
			pw_new_check_ok  = false;
		}
	});
	

	
	
	// 비밀번호 변경 Yes
	$('#pwUpdateModalYes').click(function(){
		var us_pw_new = $('#us_pw_new').val();
		var us_pw = $('#us_pw').val();
		
		if(!pw_ok){
			alert('현재 비밀번호를 입력하세요.');
			$('#us_pw').focus();
			return;
		}
		
		if(!pw_new_ok){
			alert('새 비밀번호를 입력하세요.');
			$('#us_pw_new').focus();
			return;
		}
		
		if(!pw_new_check_ok){
			alert('새 비밀번호와 똑같이 입력하세요.');
			$('#us_pw_new_check').focus();
			return;
		}

		$.ajax({
			type : "post",
			url : "/user/userPwUpdate",
			data : {"us_pw" : us_pw ,"us_pw_new" : us_pw_new },
			dataType : "JSON",
			error: function(){
				alert("비밀번호 변경 에러");
			},
			success : function(data){
				if(data == 1){
					alert("비밀번호 변경 성공");
					location.reload();
				}else{
					alert("비밀번호가 일치하지 않습니다.");
					location.reload();
				}
			} // success 끝	
		}); // ajax 끝

	}); //#pwUpdateModalYes.click
	
	// 비밀번호 변경 No
	$('#pwUpdateModalNo').click(function(){
		$('#pw_update_Modal').css("display","none");
		$('#us_pw').val("");
		$('#us_pw_new').val("");
		$('#us_pw_new_check').val("");
		$('#us_pw_msg').css("display","none");
		$('#us_pw_new_msg').css("display","none");
		$('#us_pw_new_check_msg').css("display","none");
		
	});
	
	// 탈퇴하기
	$('#us_delete').click(function(){
		$('#us_delete_Modal').css("display","block");
	});
	
	// 탈퇴하기 Yes
	$('#usDeleteModalYes').click(function(){
		$.ajax({
			type : "post",
			url : "/user/userDelete",
			dataType : "JSON",
			error: function(){
				alert("탈퇴 에러");
			},
			success : function(data){
				if(data == 1){
					alert("탈퇴 완료");
					location.href="../user/userMain";
				}else{
					alert("탈퇴 실패");
					location.reload();
				}
			} // success 끝	
		}); // ajax 끝
	}); //#usDeleteModalYes.click
	
	// 탈퇴하기 No
	$('#usDeleteModalNo').click(function(){
		$('#us_delete_Modal').css("display","none");	
	});
	
	
}); // document 끝 


//뒤로가기 
function backTo(){
	history.back(); 
}

</script>
</body>
</html>