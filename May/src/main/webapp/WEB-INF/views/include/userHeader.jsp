<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../resources/lib/wow/wow.min.js"></script>
    <script src="../resources/lib/easing/easing.min.js"></script>
    <script src="../resources/lib/waypoints/waypoints.min.js"></script>
    <script src="../resources/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="../resources/lib/counterup/counterup.min.js"></script>

    <!-- Template Javascript -->
    <script src="../resources/js/main.js"></script>
<head>
	<meta charset="UTF-8">
	<title>May</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="../resources/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Roboto:wght@500;700&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../resources/lib/animate/animate.min.css" rel="stylesheet">
    <link href="../resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../resources/css/style.css" rel="stylesheet">
    

    
</head>
<style>
#us_logout_btn{
	color : black;
}
</style>
<body>
<script type="text/javascript">
$(document).ready(function(){
	
	// 로그아웃 버튼 클릭
	$('#us_logout_btn').click(function(){
		
		$.ajax({
			type : "post",
			url : "../user/userLogout",
			dataType : "JSON",
			error: function(){
				alert("로그아웃 에러");
			},
			success : function(data){
					alert("로그아웃 완료");
					location.href="../user/userMain";

			} // success 끝	
		}); // ajax 끝
		
	}); // #us_logout_btn.click 끝
}); // documnet  끝
</script>


	
    <!-- Spinner Start -->
    <div id="spinner"
        class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->


    <!-- Navbar Start -->
    <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0 px-4 px-lg-5">
        	<a href="../user/userMain" class="navbar-brand d-flex align-items-center">
        
            	<img class="img-fluid me-2" src="../resources/img/icon-1.png" style="width:45px;">
            		 <h2 class="m-0 text-primary">May</h2>
        
        	</a>
        <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-4 py-lg-0">
                <a href="../user/userMain" class="nav-item nav-link active">Home</a>
                <a href="../user/userMypage" class="nav-item nav-link">내정보</a>
                <a href="../user/userMyBoard" class="nav-item nav-link">내글목록</a>
            </div>
            <div class="h-100 d-lg-inline-flex align-items-center d-none">
        		<c:if test="${empty us_id }">
					<a href="../user/userLogin">로그인</a>&ensp;
					<a href="../user/userJoin">회원가입</a>&ensp;
				</c:if>
				<c:if test="${!empty us_id && !us_id.equals('admin')}">
					<a href="../user/userMypage">마이페이지</a>&ensp;
				</c:if>
				<c:if test="${!empty us_id && us_id.equals('admin')}">
					<a href="../admin/adminMain">관리페이지</a>&ensp;
				</c:if>
				<c:if test="${!empty us_id}">
					<a id="us_logout_btn" style="cursor:pointer" >로그아웃</a>&ensp;
				</c:if>
            </div>
        </div>
    </nav>
    <!-- Navbar End -->
