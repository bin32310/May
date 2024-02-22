<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminHeader.jsp" %>
<style>

.user_list_section{
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
		<h1> /admin/userManage.jsp</h1>
		<h1> 회원 관리 페이지</h1>
-->
	<div>
		<br><hr><br><br>
		<div class="user_list_section">
			<h1>회원 관리</h1>
			<br>
			<div  class="user_list">
				<table>
					<tr>
						<th class="tb_us_state">상태</th>
						<th class="tb_us_id">아이디</th>
						<th class="tb_us_name">이름</th>
						<th class="tb_us_nickname">닉네임</th>
						<th class="tb_us_tel">전화번호</th>
						<th class="tb_us_join_date">가입일</th>
						<th class="tb_us_out_date">탈퇴일</th>
					</tr>
					<c:forEach var="ul" items="${userList}">
						<tr>
							<td class="tb_us_state"> ${ul.us_state }</td>
							<td class="tb_us_id"> ${ul.us_id}</td>
							<td class="tb_us_name"> ${ul.us_name }</td>
							<td class="tb_us_nickname">${ul.us_nickname }</td>
							<td class="tb_us_tel"> ${ul.us_tel }</td>
							<td class="tb_us_join_date"> ${ul.us_join_date }</td>
							<td class="tb_us_out_date"> ${ul.us_out_date }</td> 
						</tr>
					</c:forEach>
				</table>
			</div><!-- user_list -->
			
			<div class="user_clearfix"><!-- 페이지 번호 -->
				<ul class="pagination pagination-sm no-margin pull-right">
					<c:if test="${pageVO.prev == true }">
						<li><a href="userManage?page=${pageVO.startPage-1 }">«</a></li>
						&nbsp
					</c:if>
					
					<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
						&nbsp&nbsp
						<li ${pageVO.cri.page == i? 'class="active"':'' }><a href="userManage?page=${i }">${i }</a></li>
						&nbsp&nbsp
					</c:forEach>
					
					<c:if test="${pageVO.next == true }">
						&nbsp
						<li><a href="userManage?page=${pageVO.endPage+1 }">»</a></li>
					</c:if>
				</ul>
			</div><!-- 페이지 번호 -->
		</div>
	</div>


<%@ include file="../include/footer.jsp" %>
</body>
</html>