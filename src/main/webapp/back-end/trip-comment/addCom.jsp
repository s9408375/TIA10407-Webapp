<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="chilltrip.tripcomment.model.*"%>

<%
//��com.emp.controller.EmpServlet.java��238��s�Jreq��empVO���� (������J�榡�����~�ɪ�empVO����)
TripCommentVO tripCommentVO = (TripCommentVO) request.getAttribute("tripCommentVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>��{�d���s�W - addCom.jsp</title>

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
				<h3>��{�d���s�W - addCom.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="select_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/tomcat.png"
						width="100" height="100" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>��Ʒs�W:</h3>

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
				<td>�|��ID:</td>
				<td><input type="TEXT" name="memberId"
					value="<%=(tripCommentVO == null) ? "1" : tripCommentVO.getMemberId()%>"
					size="45" /></td>
			</tr>
			<tr>
				<td>��{ID:</td>
				<td><input type="TEXT" name="tripId"
					value="<%=(tripCommentVO == null) ? "1" : tripCommentVO.getTripId()%>"
					size="45" /></td>
			</tr>
			<tr>
				<td>�Ыخɶ�:</td>
				<td><input name="createTime" id="f_date1" type="text" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()) %>" readonly /></td>
			</tr>
			<tr>
				<td>�P�P��:</td>
				<td><input type="TEXT" name="score"
					value="<%=(tripCommentVO == null) ? "" : tripCommentVO.getScore()%>"
					size="45" /></td>
			</tr>
			<tr>
				<td>�d��:</td>
				<td><input type="TEXT" name="content"
					value="<%=(tripCommentVO == null) ? "" : tripCommentVO.getContent()%>"
					size="45" /></td>
			</tr>

			<tr>
				<td>��{�Ӥ�:</td>
				<td><input type="file" name="photo" /></td>
			</tr>

			<jsp:useBean id="tripCommentService" scope="page"
				class="chilltrip.tripcomment.model.TripCommentService" />

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="�e�X�s�W">
	</FORM>

</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<%-- <%-- <% --%>
<!-- // java.sql.Timestamp createTime = null; -->
<!-- // try { -->
<!-- // 	createTime = tripCommentVO.getCreateTime(); -->
<!-- // } catch (Exception e) { -->
<!-- // 	createTime = new java.sql.Timestamp(System.currentTimeMillis()); -->
<!-- // } -->
<%-- <%-- %> --%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
//         $.datetimepicker.setLocale('zh');
//         $('#f_date1').datetimepicker({
// 	       theme: '',              //theme: 'dark',
// 	       timepicker:false,       //timepicker:true,
// 	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
// 	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
// 		   value: new Date().toISOString().slice(0, 16) // �w�]����e�ɶ� (�t�p�ɻP����)
		   
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
	//startDate:	            '2017/07/10',  // �_�l��
	//minDate:               '-1970-01-01', // �h������(���t)���e
	//maxDate:               '+1970-01-01'  // �h������(���t)����
	});

	// ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

	//      1.�H�U���Y�@�Ѥ��e������L�k���
	//      var somedate1 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      2.�H�U���Y�@�Ѥ��᪺����L�k���
	//      var somedate2 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      3.�H�U����Ӥ�����~������L�k��� (�]�i���ݭn������L���)
	//      var somedate1 = new Date('2017-06-15');
	//      var somedate2 = new Date('2017-06-25');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//		             ||
	//		            date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});
</script>
</html>