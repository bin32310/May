<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 바로 페이지 이동 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:forward page="/user/userMain" /> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>May</title>
</head>
<body>

<h1>index.jsp 페이지 입니다.</h1>



	<form action="">
		<input type="button" value="회원 페이지" onclick="location.href='/user/userMain';"> <br><br>
		<input type="button" value="관리자 페이지" onclick="location.href='/admin/adminMain';">
	</form>

	

</body>
</html>
