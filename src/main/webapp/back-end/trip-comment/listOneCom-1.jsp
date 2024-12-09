<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Set"%>
<%@ page import="chilltrip.tripcomment.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
//Set<TripCommentVO>  tripCommentVOSet = (Set<TripCommentVO>) request.getAttribute("tripCommentVOSet"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>單一行程留言 - listOneCom-1.jsp</title>

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
	width: 600px;
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

	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>單一行程留言 - listOneCom.jsp</h3>
				<h4>
					<a href="select_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
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
		</tr>
	
		<tr>
			<td>${tripCommentVO.tripCommentId}</td>
			<td>${tripCommentVO.memberId}</td>
			<td>${tripCommentVO.tripId}</td>
			<td>${tripCommentVO.score}</td>
			<td><img id="photo" src="data:image/png;base64, ${tripCommentVO.photo_base64}" alt="Red dot"/></td>
			<td>${tripCommentVO.createTime}</td>
			<td>${tripCommentVO.content}</td>
		</tr>
	
	</table>

</body>
</html>