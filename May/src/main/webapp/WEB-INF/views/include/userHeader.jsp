<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
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
    
</head>
<style type="text/css">

/* yes or no button*/
.btn_blue{
 	display:inline-block;
  	width:100px;
	background-color: #16D5FF;
	color: white;
    font-weight: 400;
    text-align: center;
    vertical-align: middle;
    border: 1px solid transparent; 
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;

}


.btn_red {
 	display:inline-block;
  	width:100px;
	background-color : red;
	color: white;
    font-weight: 400;
    text-align: center;
    vertical-align: middle;
    border: 1px solid transparent; 
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;

}

.btn_gray {
 	display:inline-block;
  	width:100px;
	background-color : gray;
	color: white;
    font-weight: 400;
    text-align: center;
    vertical-align: middle;
    border: 1px solid transparent; 
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;

}


/* Modal 모달 */

.modal {
	display:none;
  	position:fixed;
  	width:100%;
  	height:100%;
  	top : 0;
  	right :0;
  	bottom:0;
  	left:0;
  	z-index:1050;
}

.modal h2 {
  	margin:0;   
}

.modal_header{
  	min-height: 16.42857143px;
  	padding-bottom : 15px;
  	border-bottom: 1px solid #e5e5e5;
  	text-align: center;
}

.modal_footer{
	padding-top : 15px;
  	text-align: right;
  	border-top: 1px solid #e5e5e5;
}

.modal-footer .btn + .btn {
  	margin-bottom: 0;
  	margin-left: 5px;

}

.modal .modal_btn_no {
 	display:inline-block;
  	width:100px;
	background-color : gray;
	color: white;
    font-weight: 400;
    text-align: center;
    vertical-align: middle;
    border: 1px solid transparent; 
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;
}

.modal .modal_btn_yes{
 	display:inline-block;
  	width:100px;
	background-color: #007bff;
	color: white;
    font-weight: 400;
    text-align: center;
    vertical-align: middle;
    border: 1px solid transparent; 
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;
}


.modal .modal_content {
  	width:300px;
  	margin:100px auto;
  	padding:20px 10px;
  	background:#fff;
  	border:2px solid #666;
}

.modal .modal_layer {
  	position:fixed;
  	top:0;
  	left:0;
  	width:100%;
  	height:100%;
  	background:rgba(0, 0, 0, 0.5);
  	z-index:-1;
}   


/* 테이블 */
table{
	border: 1px solid #000000;
	border-collapse: collapse;
}

table th, td{
	border: 1px solid #000000;
}

table th{
	font-weight: bold;
	font-size: large;
	text-align: center;
	background-color: #16D5FF ;
	opacity : 0.7;
	
}

.tb_td_title, .tb_td_writer{
	text-align: left;
	padding-left : 10px;
}



.tb_num, .tb_title, .tb_writer, .tb_view{
	font-size: medium;
	color: #000000;
}

.tb_num{
	width: 10%;
	text-align: center;
}

.tb_title{
	width : 40%;
}

.tb_writer{
	width: 20%;	
}

.tb_view{
	width: 10%;
	text-align: center;
}



/* a */

a{
	color : #000000;
	font-weight: bold;
}

/* span */
span{
	color : #000000;
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
					location.reload();

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
            		 <h2 class="m-0 text-primary">May	</h2>
       
        	</a>
        <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-4 py-lg-0">
                <a href="../user/userMain" class="nav-item nav-link active">Home</a>
                <a href="about.html" class="nav-item nav-link">About</a>
                <a href="service.html" class="nav-item nav-link">Service</a>
                <a href="roadmap.html" class="nav-item nav-link">Roadmap</a>
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                    <div class="dropdown-menu shadow-sm m-0">
                        <a href="feature.html" class="dropdown-item">Feature</a>
                        <a href="token.html" class="dropdown-item">Token Sale</a>
                        <a href="faq.html" class="dropdown-item">FAQs</a>
                        <a href="404.html" class="dropdown-item">404 Page</a>
                    </div>
                </div>
                <a href="contact.html" class="nav-item nav-link">Contact</a>
            </div>
            <div class="h-100 d-lg-inline-flex align-items-center d-none">
        		<c:if test="${empty us_id }">
					<a href="../user/userLogin">로그인</a>&ensp;
					<a href="../user/userJoin">회원가입</a>&ensp;
				</c:if>
				<c:if test="${!empty us_id && !us_id.equals(admin)}">
					<a href="../user/userMypage">내정보</a>&ensp;
				</c:if>
				<c:if test="${!empty us_id && us_id.equals(admin)}">
					<a href="../admin/adminMain">관리페이지</a>&ensp;
				</c:if>
				<c:if test="${!empty us_id}">
					<a href="" id="us_logout_btn">로그아웃</a>&ensp;
				</c:if>
            </div>
        </div>
    </nav>
    <!-- Navbar End -->
