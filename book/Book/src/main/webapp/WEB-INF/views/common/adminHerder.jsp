<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
 <style>
   *{padding: 0;margin: 0;}
   html,body { height:100% }
   ul,li{ list-style: none; }
   a:hover { text-decoration: none;}
   a:link { text-decoration:none; color: inherit;}
   a:visited { text-decoration: none; color: inherit;}

   
   .box-log{
     display: flex;
     justify-content: center;
   }
   
   /*로고*/
   .img-group{
     display: inline-block
   }
   .home{
   	background-image: url(<%=request.getContextPath()%>/resources/img/logo.png);
     width: 175px; height:81px; display:blook;
     background-size: 100% 100%
   }
   
   .side-bar{
     background-color: #eeee;
     width: 250px; height: 100%;
   }
   .side-bar-list{
     display: flex;
     justify-content: center;
   }
   .item-box{
     font-size: 22px;
     font-weight: bold;
     margin: 10px ;
     color: #3498DB;
   }
   .item{
     font-size: 22px;
     margin: 10px ;
     font-weight: bold;
     color: #3498DB;

   }
   /*사이드바*/
   .side-bar{
   float:left;
   }

 
 </style>
</head>
<body>
<div class="side-bar">
 <div class="box-log">
   <a class="home" href="<c:url value="/"></c:url>"></a>
 </div>
 <div class="side-bar-list">
  <ul>
    <li class="item-box">도서 관리</li>
    <ul>
    	<li class="item"> 
        <a href="<c:url value="/admin/addcategory"></c:url>"> 카테고리 등록</a>
      </li>
      <li class="item"> 
        <a href="<c:url value="/admin/addbook"></c:url>"> 도서 등록</a>
      </li>
      <li class="item"> 
        <a href=""> 도서 수정</a>
      </li>
      <li class="item"> 
        <a href=""> 도서 목록</a>
      </li>
    </ul>
    <li class="item-box">판매 관리</li>
    <ul>
      <li class="item"> 
        <a href=""> 주문 관리</a>
      </li>
      <li class="item"> 
        <a href=""> 매출 관리</a>
      </li>
      <li class="item"> 
        <a href=""> 통계</a>
      </li>
    </ul>
    <li class="item-box">운영 관리</li>
    <ul>
      <li class="item"> 
        <a href="">Q&A</a>
      </li>
      <li class="item"> 
        <a href="">리뷰</a>
      </li>
    </ul>
  </ul>
 </div>
</div>


</body>
</html>