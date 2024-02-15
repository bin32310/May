<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/userHeader.jsp" %>
<style>

.board_section{
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	padding-left: 10%;
	padding-right: 10%;
	
}

table td .tb_view{
	text-align: center;
}

</style>
<!-- 	
		<h1> /user/userMain.jsp</h1>
		<h1> 유저 메인페이지</h1>
-->

    <!-- Header Start -->
    <div class="container-fluid hero-header bg-light py-5 mb-5">
        <div class="container py-5">
            <div class="row g-5 align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 mb-3 animated slideInDown">Welcome to the May</h1>
                    <p class="animated slideInDown"> 환영합니다!</p>
                </div>
                <div class="col-lg-6 animated fadeIn">
                    <img class="img-fluid animated pulse infinite" style="animation-duration: 3s;" src="../resources/img/hero-1.png"
                        alt="">
                </div>
            </div>
        </div>
    </div>
    <!-- Header End -->

	
	<div class="board_section">
		<c:if test="${!empty us_id && !us_id.equals(admin)}">
				<input type="button" class="btn_blue" value="글쓰기" onclick="location.href='../board/boWrite';"> <br><br>
		</c:if>
		<div id="board_list"> <!-- list_section -->
			<table>
				<tr>
					<th class="tb_num">번호</th>
					<th class="tb_title">제목</th>
					<th class="tb_writer">글쓴이</th>
					<th class="tb_view">조회수</th>
				</tr>
				<c:forEach var="bl" items="${boardList}">
					<tr>
						<td class="tb_num"> ${bl.bo_num }</td>
						<td class="tb_title tb_td_title"><a href="../board/boRead?bo_num=${bl.bo_num}"> ${bl.bo_title }</a></td>
						<td class="tb_writer tb_td_writer"> ${bl.userVO.us_nickname }</td>
						<td class="tb_view"> ${bl.bo_view }</td>
					</tr>
				</c:forEach>
			</table>
		</div><!-- list_section -->
	</div>
<%@ include file="../include/userFooter.jsp" %>

</body>
</html>