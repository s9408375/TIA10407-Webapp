<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="chilltrip.tripcomment.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
TripCommentService tripCommentService = new TripCommentService();
List<TripCommentVO> list = tripCommentService.getAll();
pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>�Ҧ���{�d�� - listAllEmp.jsp</title>

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

	<h4>�����m�߱ĥ� EL ���g�k����:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>�Ҧ���{�d�� - listAllCom.jsp</h3>
				<h4>
					<a href="select_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>��{�d��ID</th>
			<th>�|��ID</th>
			<th>��{ID</th>
			<th>����</th>
			<th>�Ӥ�</th>
			<th>�إ߮ɶ�</th>
			<th>�d�����e</th>
			<th>�ק�</th>
			<th>�R��</th>
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
						<input type="submit" value="�ק�"> <input type="hidden"
							name="tripCommentId" value="${tripCommentVO.tripCommentId}"> <input type="hidden"
							name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="comment.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="�R��"> <input type="hidden"
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