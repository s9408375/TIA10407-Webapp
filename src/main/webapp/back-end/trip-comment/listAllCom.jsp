<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="chilltrip.tripcomment.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
TripCommentService tripCommentService = new TripCommentService();
List<TripCommentVO> list = tripCommentService.getAll();
pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>所有行程留言 - listAllEmp.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}

img#photo {
	width: 50%;
	height: 50%;
}
</style>

</head>
<body bgcolor='white'>

	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有行程留言 - listAllCom.jsp</h3>
				<h4>
					<a href="select_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>行程留言ID</th>
			<th>會員ID</th>
			<th>行程ID</th>
			<th>評分</th>
			<th>照片</th>
			<th>建立時間</th>
			<th>留言內容</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="tripCommentVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${tripCommentVO.tripCommentId}</td>
				<td>${tripCommentVO.memberId}</td>
				<td>${tripCommentVO.tripId}</td>
				<td>${tripCommentVO.score}</td>
				<td>
				  <img id="photo" src="data:image/png;base64, ${tripCommentVO.photo_base64}" alt="Red dot" />
				</td>
				<td>${tripCommentVO.createTime}</td>
				<td>${tripCommentVO.content}</td>
				<td>
					<FORM METHOD="post"
						ACTION="comment.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> <input type="hidden"
							name="tripCommentId" value="${tripCommentVO.tripCommentId}"> <input type="hidden"
							name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="comment.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="tripCommentId" value="${tripCommentVO.tripCommentId}"> <input type="hidden"
							name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>