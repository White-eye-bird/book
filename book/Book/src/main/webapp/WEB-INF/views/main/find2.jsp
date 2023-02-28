<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<style>
	 *{padding: 0; margin: 0;}

	  .brand{
	    background-image: url(<%=request.getContextPath()%>/resources/img/logo.png);
	    width: 285px; height: 141px;
	    margin: auto;
	    display: block;
	    background-size: 100% 100%;
	  }
	  .container{
	  	width: 460px;
	  }
	  
	  .form-group{
	    width: 400px;
	  }
	  .btn{
	    width: 400px; margin-top: 18px;
	    margin-bottom :18px;
	  }
 </style>
<body>
	<div class="logo-group">
    <a class="brand" href="<c:url value="/"></c:url>"></a> 
  </div>
  <div class="container">
	  <br>
	  <ul class="nav nav-tabs" role="tablist">
	    <li class="nav-item">
	      <a class="nav-link active" data-toggle="tab" href="#id">아이디 찾기</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link papa" data-toggle="tab" href="#pw">비번 찾기</a>
	    </li>
	  </ul>
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div id="id" class="container tab-pane active"><br>
	      <h3>아이디 찾기</h3>
	      <div class="form-group">
	      	<input type="text" class="form-control me_email"  id="me_email" name="me_email" placeholder="이메일을 입력하세요" >
	      </div>
	      <div class="form-group">
	      	<input type="text" class="form-control me_phone" id="me_phone" name="me_phone" placeholder="핸드폰번호를 입력하세요 (010-1234-1234)">
	      </div>
	      <button class="btn btn-outline-primary btn-fine-id col-12">아이디 찾기</button>
	    </div>
	    <div id="pw" class="container tab-pane fade"><br>
	      <h3>비번찾기</h3>
	      <div class="form-group">
	      	<input type="text" class="form-control me_id" id="me_id" name="me_id" placeholder="아이디를 입력하세요" >
	      </div>
	      <div class="form-group">
	      	<input type="text" class="form-control me_phone" id="me_phone" name="me_phone" placeholder="핸드폰번호를 입력하세요 (010-1234-1234)">
	      </div>
	      <button class="btn btn-outline-primary btn-fine-pw col-12">비밀번호 찾기</button>
	    </div>  
	  </div>
	</div>
<script type="text/javascript">
	$(function(){
			$('[href="#${type}"]').click();
		
	})
	$(function(){
		//정규식
		let emailRegex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i
		let phoneRegex =/\d{3}-\d{4}-\d{4}/
		let idRegex = /[a-z0-9]{5,20}/
		
		$('.btn-fine-id').click(function(){
			let me_email =$('#id [name=me_email]').val()
	 		let me_phone =$('#id [name=me_phone]').val()
		 		
	 		//이메일 정규식
		  if(!emailRegex.test(me_email)){
			  alert('이메일이 올바른 형식이 아닙니다.')
			  $('#id [name=me_email]').focus();
			  return;
		  }
	 		//핸드폰 정규식
		  if(!phoneRegex.test(me_phone)){
			  alert('휴대전화번호가 올바른 형식이 아닙니다.')
			  $('#id [name=me_phone]').focus();
			  return;
		  }
				
			//입력한 값으로 객체를 만들어서 에이젝스로 전송한다.
			let object = {
				me_email : me_email,
				me_phone : me_phone
			}
			ajaxPost(false, object, "/ajax/find/id", function(data){
				if(data.id == null)
					alert('일치하는 아이디가 없습니다.')
				else
					alert('아이디는 '+ data.id +'입니다')
			})
		})
		$('.btn-fine-pw').click(function(){
			let me_id = $('#pw [name=me_id]').val()
			let me_phone = $('#pw [name=me_phone]').val()
			
			if(!idRegex.test(me_id)){
				alert('아이디가 올바른 형식이 아닙니다.')
				$('#pw [name=me_id]').focus();
				return;
			}
			if(!phoneRegex.test(me_phone)){
			  alert('휴대전화번호가 올바른 형식이 아닙니다.')
			  $('#pw [name=me_phone]').focus();
			  return;
		  }
			
			let object = {
					me_id : me_id,
					me_phone : me_phone
			}
			ajaxPost(false, object, "/ajex/find/pw", function(data){
				if(data.res)
					alert('입력한 이메일로 새비밀번호를 발송했습니다.')
				else
					alert('존재하지 않는 정보입니다.')
	 		})
	 	})
	})
	function ajaxPost(async, dataObj, url, success){
		$.ajax({
			async:async,
			type:'POST',
			data:JSON.stringify(dataObj),
			url:"<%=request.getContextPath()%>"+url,
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			success:function(data){
				success(data);
			}
		})
	}

</script>
</body>
</html>