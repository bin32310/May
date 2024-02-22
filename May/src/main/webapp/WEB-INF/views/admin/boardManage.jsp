<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/adminHeader.jsp" %>


<!-- 	
		<h1> /admin/boardManage.jsp</h1>
		<h1> 글 관리 페이지</h1>
-->
	<div class="board_section">
		<c:if test="${!empty us_id && !us_id.equals('admin')}">
				<input type="button" class="btn_blue" value="글쓰기" onclick="location.href='../board/boWrite';"> <br><br>
		</c:if>
		<div id="board_list"> <!-- list_section -->
			<table>
				<tr>
					<th class="tb_reply">답변상태</th>
					<th class="tb_state">글상태</th>
					<th class="tb_title">제목</th>
					<th class="tb_writer">작성자</th>
					<th class="tb_view">조회수</th>
				</tr>
				<c:forEach var="bl" items="${boardList}">
						<tr>
							<c:if test="${bl.bo_reply.equals('no') }">
								<td class="tb_reply"> 미답변</td>
							</c:if>
							<c:if test="${bl.bo_reply.equals('yes') }">
								<td class="tb_reply"> 답변완료</td>
							</c:if>
							
							<c:if test="${bl.bo_state.equals('upload') }">
								<td class="tb_reply"> 등록</td>
							</c:if>
							<c:if test="${bl.bo_state.equals('delete') }">
								<td class="tb_reply"> 삭제</td>
							</c:if>

							<c:if test="${bl.bo_lock.equals('unlock')}"><!-- 공개글 -->
								<td class="tb_title tb_td_title"><a href="../board/boRead?bo_num=${bl.bo_num}"> ${bl.bo_title }</a></td>
							</c:if>
							<c:if test="${bl.bo_lock.equals('lock')}"> <!-- 비공개글 -->
							<td class="tb_title tb_td_title">
								<img alt="lock_icon" src="../resources/img/lock_icon.png" width="30px" height="30px">
								<a href="../board/boRead?bo_num=${bl.bo_num}"> ${bl.bo_title }</a>
							</td>	
							</c:if>
							<td class="tb_writer tb_td_writer"> ${bl.us_id }</td>
							<td class="tb_view"> ${bl.bo_view }</td>
						</tr>
				</c:forEach>
			</table>
		</div><!-- list_section -->
		<!-- 페이지 번호 -->
		<div class="board_clearfix">
			<ul class="pagination pagination-sm no-margin pull-right">
				<c:if test="${pageVO.prev == true }">
					<li><a href="boardManage?page=${pageVO.startPage-1 }">«</a></li>
					&nbsp
				</c:if>
				
				<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
					&nbsp&nbsp
					<li ${pageVO.cri.page == i? 'class="active"':'' }><a href="boardManage?page=${i }">${i }</a></li>
					&nbsp&nbsp
				</c:forEach>
				
				<c:if test="${pageVO.next == true }">
					&nbsp
					<li><a href="boardManage?page=${pageVO.endPage+1 }">»</a></li>
				</c:if>
			</ul>
		</div>
	</div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>