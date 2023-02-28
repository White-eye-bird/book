<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
 *{padding: 0; margin: 0; }
  ul,ol,li{ list-style: none; }
  a, a:hover{color:inherit}

  html, body{width: 100%;}
  /*표*/
  table, tb{
    margin:auto;
  }
  .container{
		display: flex;
    justify-content: center ;
  }
  .list-box{
    width: 950px;
    margin:auto;
  }
  .checkbox-sell{
    width: 15px;
  }
  .checkbox{
    position:relative;
    margin: 8px;
  }
  .cover{
    width:167px; height:239px;
  }
  .information{
    width:430px; height:160px;
  }
  .book-title{
   font-weight: bold;
  }
  .btn-list{
    width:80px; height:160px;
  }
  .btn-baskit, .btn-buy-now, .btn-locker{
    display: block;
    background-color: #007bff;
    border: none;
    border-radius: 5px;
    color: white;
    font-size:12px;
    text-align:center;
    width: 63px;
    padding: 9px 0 8px 0;
    margin-top: 15px ;
  }
  .btn-baskit:hover, .btn-buy-now:hover, .btn-locker:hover{
    color: white;
    background-color: #0070e8;
    text-decoration: none;
  }

</style>
</head>
<body>
<div class="list-box">
  <table class="a">
    <tbody>
      <c:forEach items="${list}" var="li">
      <tr>
        <td class="checkbox-sell">
          <input type="checkbox" class="checkbox" name="" id="">
        </td>
        <td class="cover">
        	<a href="<c:url value="/select?bo_isbn=${li.bo_isbn}"></c:url>">
          	<img src="<c:url value="${li.bo_thum_url}"></c:url>" alt="이미지" width="150px" height="220px">
        	</a>
        </td>
        <td class="information">
          <ui class="information-list">
          	<a href="<c:url value="/select?bo_isbn=${li.bo_isbn}"></c:url>">
            	<li class="book-title">${li.bo_title}</li>
            </a>
            <li> ${li.bo_author} | ${li.bo_publisher} | ${li.bo_date_ymstr} </li>
            <li>${li.bo_price} -> ${li.bo_sale_price}</li>
            <li>별점</li>
          </ui>
        </td>
        <td class="btn-list">
          <a href="" class="btn-baskit">장바구니</a>
          <a href="" class="btn-buy-now">바로구매</a>
          <a href="" class="btn-locker">보관함</a>
        </td>
      </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<div class="container">
  <ul class="pagination">
  	<c:if test="${pm.prev}">
    	<li class="page-item">
    		<a class="page-link" href="<c:url value="/list?page=${pm.startPage-1}"></c:url>">이전</a>
   		</li>
    </c:if>
    <c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    	<li class="page-item <c:if test="${pm.cri.page == i}">active</c:if>">
    		<a class="page-link" href="<c:url value="/list?page=${i}"></c:url>">${i}</a>
    	</li>
    </c:forEach>
    <c:if test="${pm.next}">
    	<li class="page-item">
    		<a class="page-link" href="<c:url value="/list?page=${pm.endPage+1}"></c:url>">다음</a>
    	</li>
    </c:if>
  </ul>
</div>
</body>
</html>