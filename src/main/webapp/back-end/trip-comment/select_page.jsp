<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM TripCom: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Com: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Com: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllCom.jsp'>List</a> all Coms.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="comment.do" >
        <b>輸入行程留言ID (如1):</b>
        <input type="text" name="tripCommentId">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="tripCommentService" scope="page" class="chilltrip.tripcomment.model.TripCommentService" />
   
  <li>
     <FORM METHOD="post" ACTION="comment.do" >
       <b>選擇行程留言ID:</b>
       <select size="1" name="tripCommentId">
         <c:forEach var="tripCommentVO" items="${tripCommentService.all}" > 
          <option value="${tripCommentVO.tripCommentId}">${tripCommentVO.tripCommentId}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="comment.do" >
       <b>選擇會員ID:</b>
       <select size="1" name="tripCommentId">
         <c:forEach var="tripCommentVO" items="${tripCommentService.all}" > 
          <option value="${tripCommentVO.tripCommentId}">${tripCommentVO.memberId}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>行程留言管理</h3>

<ul>
  <li><a href='addCom.jsp'>Add</a> a new Com.</li>
</ul>

</body>
</html>