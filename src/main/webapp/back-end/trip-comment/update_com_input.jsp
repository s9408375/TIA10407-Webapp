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

			<jsp:useBean id="memberService" scope="page"
				class="chilltrip.member.model.MemberService" />
			<!-- 			<tr> -->
			<!-- 				<td>�|��:<font color=red><b>*</b></font></td> -->
			<!-- 				<td><select size="1" name="memberId"> -->
			<%-- 						<c:forEach var="memberVO" items="${memberService.all}"> --%>
			<%-- 							<option value="${memberVO.memberId}" --%>
			<%-- 								${(tripCommentVO.memberId==memberVO.memberId)?'selected':'' }>${memberVO.name} --%>
			<%-- 						</c:forEach> --%>
			<!-- 				</select></td> -->
			<!-- 			</tr> -->

		</table>
		<br> 
		<input type="hidden" name="action" value="update"> 
		<input type="hidden" name="tripCommentId" value="<%=tripCommentVO.getTripCommentId()%>"> 
		<input type="submit" value="�e�X�ק�">
	</FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

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
$.datetimepicker.setLocale('zh');
$('#f_date1').datetimepicker({
    theme: '',              // theme: 'dark',
    timepicker: false,       // timepicker: true,
    step: 1,                // step: 60 (�o�Otimepicker���w�]���j60����)
    format: 'Y-m-d',         // format:'Y-m-d H:i:s',
    value: '<%=tripCommentVO.getCreateTime() != null
		? new java.text.SimpleDateFormat("yyyy-MM-dd").format(tripCommentVO.getCreateTime())
		: ""%>
	',

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