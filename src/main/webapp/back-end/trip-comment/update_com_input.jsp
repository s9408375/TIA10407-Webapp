<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="chilltrip.tripcomment.model.*"%>

<%
//��com.emp.controller.EmpServlet.java��163��s�Jreq��empVO���� (�����q��Ʈw���X��empVO, �]�i�H�O��J�榡�����~�ɪ�empVO����)
TripCommentVO tripCommentVO = (TripCommentVO) request.getAttribute("tripCommentVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>��{�d���ק� - update_com_input.jsp</title>

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
				<h3>��{�d���ק� - update_com_input.jsp</h3>
				<h4>
					<a href="select_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>��ƭק�:</h3>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
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
				<td>��{�d��ID:<font color=red><b>*</b></font></td>
				<td><%=tripCommentVO.getTripCommentId()%></td>
			</tr>
			<tr>
				<td>�|��ID:</td>
				<td><%=tripCommentVO.getMemberId()%></td>
			</tr>
			<tr>
				<td>��{ID:</td>
				<td><%=tripCommentVO.getTripId()%></td>
			</tr>
			<tr>
				<td>�إߤ��:</td>
				<td><%=tripCommentVO.getCreateTime()%></td>
			</tr>
			<tr>
				<td>�P�P��:</td>
				<td><input type="TEXT" name="score"
					value="<%=tripCommentVO.getScore()%>" size="45" /></td>
			</tr>
			<tr>
				<td>�d��:</td>
				<td><input type="TEXT" name="content"
					value="<%=tripCommentVO.getContent()%>" size="45" /></td>
			</tr>

			<tr>
				<td>��{�Ӥ�:</td>
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
		<input type="submit" value="�e�X�ק�">
	</FORM>
</body>






</html>