<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
  	.home-banner{
  		width: 1000px; height:400px
  	}
  </style>
</head>
<body>
<div class="home-banner container">
	<div id="demo" class="carousel slide" data-ride="carousel">
	  <!-- Indicators -->
	  <ul class="carousel-indicators">
	    <li data-target="#demo" data-slide-to="0" class="active"></li>
	    <li data-target="#demo" data-slide-to="1"></li>
	    <li data-target="#demo" data-slide-to="2"></li>
	  </ul>
	  <!-- The slideshow -->
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="<%=request.getContextPath()%>/resources/img/main_banner_Independent.jpg" alt="Independent" width="1000" height="400">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=request.getContextPath()%>/resources/img/main_banner_ebs.jpg" alt="ebs" width="1000" height="400">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=request.getContextPath()%>/resources/img/main_banner_slamdunk.jpg" alt="slamdunk" width="1000" height="400">
	    </div>
	  </div>
	  <!-- Left and right controls -->
	  <a class="carousel-control-prev" href="#demo" data-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </a>
	  <a class="carousel-control-next" href="#demo" data-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </a>
	</div>
</div>
</body>
</html>
