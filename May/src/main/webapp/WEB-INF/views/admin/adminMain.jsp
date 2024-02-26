<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminHeader.jsp" %>
<style>

.container {
	width: 1000px;
	height: 500px;
	margin-top: 10%;
}

.menu_Section {
	width : 300px;
	height : 300px;
	padding-left: 15%;
	padding-right: 15%;
	float: left;
}
.adminMenu {

	width: 200px;
	height: 200px;
}

.menu_text_section{
	width : 200px;
	align-content: center;
}


</style>

<!-- 	
		<h1> /admin/adminMain.jsp</h1>
		<h1> 관리자 페이지</h1>
-->
<hr>
<div class="container">
	<div class="menu_Section">
		<a href="../admin/noticeManage">
			<h1 class="menu_text_section">공지관리</h1>
			<img src="../resources/img/noticeManage.png" class="adminMenu">
		</a>
	</div>
	<div class="menu_Section">
		<a href="../admin/userManage">
			<h1 class="menu_text_section">회원관리</h1>
			<img src="../resources/img/userManage.png" class="adminMenu">
		</a>
	</div>
	<div class="menu_Section">
		<a href="../admin/boardManage">
			<h1 class="menu_text_section">글관리</h1>
			<img src="../resources/img/boardManage.png" class="adminMenu">
		</a>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>