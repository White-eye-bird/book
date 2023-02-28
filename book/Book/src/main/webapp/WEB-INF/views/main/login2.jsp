<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
    	 *{padding: 0; margin: 0;}

      .brand{
        background-image: url(<%=request.getContextPath()%>/resources/img/logo.png);
        width: 285px; height: 141px;
        margin: auto;
        display: block;
        background-size: 100% 100%;
      }
      
      .form-group{
        width: 400px;
      }
      .btn{
        width: 400px; margin-top: 18px;
        margin-bottom :18px;
      }
      .box {
        display: flex;
        justify-content: center ;
        align-items: center;
      }   
      
    </style>
  </head>
<body>
<form action="<%=request.getContextPath()%>/login" method="post">
  <div class="logo-group">
    <a class="brand" href="<c:url value="/"></c:url>"></a> 
  </div>
  <div class="box">
    <div class="box1">
      <div class="form-group">
        <label for="me_id">아이디</label>
        <input type="text" class="form-control" id="me_id" name="me_id">
      </div>
      <div class="form-group">
        <label for="me_pw">비밀번호</label>
        <input type="password" class="form-control" id="me_pw" name="me_pw">
      </div>
      <div>
       <button type="submit" class="btn btn-outline-primary">로그인</button>
      </div>
	  	<a href="<c:url value="/find?type=id"></c:url>">아이디 찾기</a>
	  	<a href="<c:url value="/find?type=pw"></c:url>">비밀번호 찾기</a>
    </div>
  </div>
 	</form>
</body>
</html>