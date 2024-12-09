<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="chilltrip.tripcomment.model.*"%>

<%
//見com.emp.controller.EmpServlet.java第163行存入req的empVO物件 (此為從資料庫取出的empVO, 也可以是輸入格式有錯誤時的empVO物件)
TripCommentVO tripCommentVO = (TripCommentVO) request.getAttribute("tripCommentVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>行程留言修改 - update_com_input.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>行程留言修改 - update_com_input.jsp</h3>
				<h4>
					<a href="select_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="comment.do" name="form1"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td>行程留言ID:<font color=red><b>*</b></font></td>
				<td><%=tripCommentVO.getTripCommentId()%></td>
			</tr>
			<tr>
				<td>會員ID:</td>
				<td><%=tripCommentVO.getMemberId()%></td>
			</tr>
			<tr>
				<td>行程ID:</td>
				<td><%=tripCommentVO.getTripId()%></td>
			</tr>
			<tr>
				<td>建立日期:</td>
				<td><%=tripCommentVO.getCreateTime()%></td>
			</tr>
			<tr>
				<td>星星數:</td>
				<td><input type="TEXT" name="score"
					value="<%=tripCommentVO.getScore()%>" size="45" /></td>
			</tr>
			<tr>
				<td>留言:</td>
				<td><input type="TEXT" name="content"
					value="<%=tripCommentVO.getContent()%>" size="45" /></td>
			</tr>

			<tr>
				<td>行程照片:</td>
				<td><input type="file" name="photo" /></td>
			</tr>

			<jsp:useBean id="TripCommentService" scope="page"
				class="chilltrip.tripcomment.model.TripCommentService" />
			

		</table>
		<br> 
		<input type="hidden" name="action" value="update"> 
		<input type="hidden" name="tripCommentId" value="<%=tripCommentVO.getTripCommentId()%>"> 
		<input type="hidden" name="memberId" value="<%=tripCommentVO.getMemberId()%>"> 
		<input type="hidden" name="tripId" value="<%=tripCommentVO.getTripId()%>"> 
		<input type="hidden" name="createTime" value="<%=tripCommentVO.getCreateTime()%>"> 
		<input type="submit" value="送出修改">
	</FORM>
</body>






</html>