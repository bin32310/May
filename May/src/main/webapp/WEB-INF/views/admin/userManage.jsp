<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminHeader.jsp" %>


<!-- 	
		<h1> /admin/userManage.jsp</h1>
		<h1> 회원 관리 페이지</h1>
-->

<div id="user_list"> <!-- list_section -->
	<table>
		<tr>
			<th class="tb_us_state">상태</th>
			<th class="tb_us_id">아이디</th>
			<th class="tb_us_name">이름</th>
			<th class="tb_us_nickname">닉네임</th>
			<th class="tb_us_tel">전화번호</th>
			<th class="tb_us_joinDate">가입일</th>
			<th class="tb_us_outDate">탈퇴일</th>
		</tr>
		<c:forEach var="ul" items="${userList}">
			<tr>
				<td class="tb_us_state"> ${ul.us_state }</td>
				<td class="tb_us_id"> ${ul.us_id}</td>
				<td class="tb_us_name"> ${ul.us_name }</td>
				<td class="tb_us_nickname">${ul.us_nickname }</td>
				<td class="tb_us_tel"> ${ul.us_tel }</td>
				<td class="tb_us_joinDate"> ${ul.us_joinDate }</td>
				<td class="tb_us_outDate"> ${ul.us_outDate }</td>
			</tr>
		</c:forEach>
	</table>
</div><!-- list_section -->
<!-- 페이지 번호 -->
<div class="user_clearfix">
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
</div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>