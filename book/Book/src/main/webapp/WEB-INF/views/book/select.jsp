<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
 *{padding: 0; margin: 0; }
  ul,ol,li{ list-style: none; }
  a{text-decoration: none;}

  html, body{width: 100%; 
  display: flex;
    justify-content: center;
  }

  .container-top-level{
    width: 800px;
  }
  .title{
    font-size: 26px;
    font-weight: bold;
  }
  .sub-information{
    border-bottom: solid 2px #d5d5d5; 
  }

  .flex-container{
    display: flex;
  }
  .corver{
    width: 380px;
    height: 500px;
  }
  .flex-container2{
    display: flex;
    margin-top: 10px;
  }
  .information{
    width: 300px;
  }
  .empty{
    height: 150px;
  }
  .key{
    width: 100px;
  }
  .sale-prcie-value{
    font-size: 26px;
  }
  .top-btn, .down-btn{
    width: 20px; height: 13px;
    background-color: #f8f8f8;
    border: solid 1px #cdcdcd;
  }
  
  .down-btn{
    border-top:none;
    height: 12px;
  }
  .top-btn, .down-btn:hover{
   cursor: pointer;
  }
  
  
  .input-ea{
    width: 26px;
    height: 26px;
    border: solid 1px #cdcdcd;
    border-right: none;
  }
  .ea-value{
    display: flex;
  }
  .button-box{
    display: flex;
    justify-content: center;
    margin-top: 20px;
  }
  .btn-basket, .btn-buy-now, .btn-locker{
    display: block; 
    background-color: #007bff;
    border: none;
    border-radius: 5px;
    color: white;
    font-size:15px;
    text-align:center;
    width: 82px;
    padding: 9px 0 8px 0;
    margin: 0 6px 0 6px;
  }
  .btn-basket:hover, .btn-buy-now:hover, .btn-locker:hover{
    color: white;
    background-color: #0070e8;
    text-decoration: none;
  }
  .cantainer-2{
    display: flex;
    border-top: solid 2px #d5d5d5;
  }
  .coulm{
    width: 150px;
  }
  .content{
    /*책소개 컬럼 혼자 따로 놀아서 공간 줌*/
    width: 800px;
  }
</style>
</head>
<body>
<div class="container-top-level">
  <div class="box">
    <div class="box-1">
      <div class="title" name="bo_title">${b.bo_title}</div>
      <div class="sub-information">
      ${b.bo_author} (지은이) 
      <c:if test="b.bo_translator != null">
      	${b.bo_translator} (옮긴이) 
      </c:if>
      ${b.bo_publisher} 
      ${b.bo_date_str} </div>
    </div>
  </div>
  <div class="flex-container">
    <div class="corver">
      <img id ="corver-preview" width="380px" height="500px" src="<c:url value="${b.bo_thum_url}"></c:url>">
    </div>
    <div class="information">
      <div class="empty">
      </div>
      <div class="flex-container2">
        <div class="prcie key">정가</div>
        <div class="prcie-value" name="bo_price">${b.bo_price}</div>
      </div>
      <div class="flex-container2">
        <div class="ea key">수량</div>
        <div class="ea-value">
          <input type="text" class="input-ea" name="bo_ea" value="1">
          <div>
            <div class="top-btn" id="top-btn"></div>
            <div class="down-btn" id="down-btn"></div>
          </div>
        </div>
      </div>
      <div class="button-box" >
          <a href="#" class="btn-basket">장바구니</a>
          <a href="#" class="btn-buy-now">바로구매</a>
          <a href="" class="btn-locker">보관함</a>
      </div>
      <form action="<c:url value="/order"></c:url>" method="get" id="book-form">	 
			  <input type="hidden" name="bo_isbn" value="${b.bo_isbn}" >
			  <input type="hidden"  name="bo_ea" value="1">
		  </form>
    </div>
  </div>
 
  <div>
    <div class="cantainer-2">
      <div class="spec coulm">
        기본정보 
      </div>  
      <div class="spec content">
        ${b.bo_detail_page}쪽
        ${b.bo_detail_size}mm
        ${b.bo_detail_weight}g
        ISBN : 
        ${b.bo_isbn}
      </div>
    </div>
    <div class="cantainer-2">
      <div class="info coulm">
        책소개  
      </div>  
      <div class="info content">
       <p>${b.bo_intro} </p>
      </div>
    </div>
    <div class="cantainer-2">
      <div class="index coulm">
        목차
      </div>  
      <div class="index content" >
      	  ${b.bo_index}
      </div>
    </div>  
  </div>
  
</div>
<script type="text/javascript">
	$(function(){
		//전역변수
		let ea = $('[name=bo_ea]').val();
		// 수량변경 버튼클릭
	  $('.top-btn').click(function(){
	    ea = parseInt($('.input-ea').val())
	    if(ea<200){
	    	$('[name=bo_ea]').val(ea + 1)
			}else{
				alert('200개 이하만 주문이 가능합니다.')
				$('[name=bo_ea]').val(200);
			}
	  }) 
	  $('.down-btn').click(function(){
	  	 ea = parseInt($('[name=bo_ea]').val())
	    if(ea>1){
	    	$('[name=bo_ea]').val(ea - 1)
			}else{
				alert('1개 이상만 주문이 가능합니다.')
				$('[name=bo_ea]').val(1);
			}
	  })
	  
		//수량변경 직접입력
		$('[name=bo_ea]').change(function(){
			if (ea < 1) {
				alert('1개 이상으로 주문해주세요.');
				$('[name=bo_ea]').val(1);
			} else if (ea > 200) {
				alert('200개 이하로 주문해주세요.');
				$('[name=bo_ea]').val(200);
			}
		})
		
		//바로 구매(한개 구매)
   	$('.btn-buy-now').click(function(e) {
     e.preventDefault();// a링크x
     $('#book-form').submit();
   	})
   	//장바구니 버튼
   	$('.btn-basket').click(function(e){
   		e.preventDefault();
   		let bo_isbn = ${b.bo_isbn}
   		let bo_ea = $('[name=bo_ea]').val()
   		let obj ={
   				ba_bo_isbn : bo_isbn,
   				ba_ea : bo_ea
   		}
   		ajaxPost(false, obj, "/basket/add", function(data){
   			switch(data.res){
   			case 0:
   				alert('데이터 전송오류가 발생하였습니다. 다시 시도해주세요');
   				location.relord();
   				break
   			case 1 : 
   				alert('장바구니 등록이 실패했습니다. 로그인 해주세요.');
   				location.href ='<%=request.getContextPath()%>/login'
   				break
   			case 2:
   				alert('존재하지 않는 상품입니다.');
   				break
   			case 3:
   				var result = confirm('이미 장바구니 등록된 상품입니다. \n확인을 누르면 장바구니로 이동합니다');
   				if(result)
   					location.href ='<%=request.getContextPath()%>/basket'
   				break
   			case 4:	
   				var result = confirm('장바구니에 등록되었습니다. \n확인을 누르면 장바구니로 이동합니다');
   				if(result)
   					location.href ='<%=request.getContextPath()%>/basket'
   				break
   			}
   		})
   	})
	});
	function ajaxPost(async, dataObj, url, success) {
		$.ajax({
      async:async,
      type:'POST',
      data:JSON.stringify(dataObj),
      url:"<%=request.getContextPath()%>"+url,
      dataType:"json",
      contentType:"application/json; charset=UTF-8",
      success : function(data){
    	  success(data);
      }
	  });
	}
	
	
	
</script>
</body>
</html>