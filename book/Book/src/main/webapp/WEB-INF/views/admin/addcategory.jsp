<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
  .select-category-box{
    display: flex;
    justify-content: space-around;
    width: 300px;
  }
  .category{
    margin-right:10px ;
  }
  .book-category-name{
    width: 250px; height: 35px;
  }
  .book-category-add{
    width: 60px; height: 35px;
    border: solid 1px #007bff;
    background-color: #007bff;
    color: white;
  }
  .book-category-add:hover{
    border: solid 1px #0070e8;
    background-color: #0070e8;
  }
  .book-type{
    width: 100px; height: 35px;
    border: solid 1px #8f8f9d;
    border-radius: 0px;
    background-color: white ;
  }
</style>
</head>
<body>
<div>
  <h2>카테고리 등록</h2>
</div>
<div>
  <div class="select-category-box">
    <div>
      <input type="radio" name="category" class="category" value="대분류" id="large-category">대분류 
    </div>
    <div>
       <input type="radio" name="category" class="category" value="중분류" id="medium-category">중분류 
    </div>
    <div>
      <input type="radio" name="category" class="category" value="소분류" id="small-category">소분류 
    </div>
  </div>    
  <!--대분류-->
  <form method="post">
	  <div class="large-category-box">
	    <input type="text" class="book-category-name" name="la_name"> 
	    <button class="book-category-add">추가</button>
	  </div>
  </form>
  <!--중분류-->
  <form method="post">
	  <div class="medium-category-box">
	    <select class="book-type large_category" name="me_la_code" >
	      <option value=""selected>= 대분류 =</option>
	      <c:forEach items="${largeList}" var="la">
	      	<option value="${la.la_code}" name="">${la.la_name}</option>
	      </c:forEach>
	    </select>
    <input type="text" class="book-category-name" name="me_name"> 
    <button class="book-category-add">추가</button>
    </div> 
  </form>
  <!--소분류-->
  <form method="post">
	  <div class="small-category-box">
	    <select class="book-type  large_category" name="me_la_code" id="" >
	      <option value=""  name="" selected>= 대분류 =</option>
	      <c:forEach items="${largeList}" var="la">
		      <option value="${la.la_code}">${la.la_name}</option>
	      </c:forEach>
	    </select>
	    <select class="book-type medium_category" name="sm_me_code" id="" >
	      <option value="" selected>= 중분류 =</option>
	      <c:forEach items="${mediumList}" var="me">
	      		<option value="${me.me_code}">${me.me_name}</option>
	    	</c:forEach>
	    </select>
	    <input type="text" class="book-category-name" name="sm_name"> 
	    <button class="book-category-add">추가</button>
	  </div>
	 </form>
</div>
</body>
<script>

$(document).ready(function(){
		// 초깃값
    $('.large-category-box').hide();   
    $('.medium-category-box').hide();
    $('.small-category-box').hide();	

    $("input[name='category']").change(function(){
			// 대분류 결제 선택 시.
			if($("input[name='category']:checked").val() == '대분류'){
				$('.large-category-box').show();
				$('.medium-category-box').hide();
				$('.small-category-box').hide();
			}	
			// 중분류 결제 선택 시.
			else if($("input[name='category']:checked").val() == '중분류'){
				$('.large-category-box').hide();
				$('.medium-category-box').show();
				$('.small-category-box').hide();
			}
			// 소분류 선택 시.
			else if($("input[name='category']:checked").val() == '소분류'){
				$('.large-category-box').hide();
				$('.medium-category-box').hide();
				$('.small-category-box').show();
			}
		});
   $('.book-type').change(function(){
	   	
	   	let tb_name = $(this).hasClass("large_category")? "medium_category":"";//테이블명 
			let code = 0;//대분류 또는 중분류 코드번호
			try{
				if(tb_name != "large_category")
					code = parseInt($(this).val())		
			}catch(e){
				return;
			}
			let obj = {
					tb_name : tb_name,
					code : code
			}
			getCategory(obj)
   })
   getCategory({
		tb_name : "large_category",
		code : 0
	})
});

function getCategory(obj){

	ajaxPost(false, obj, "/admin/category", function(data){
		console.log(data);
		let list = data.list;
		let str = '';
		if(obj.tb_name == 'large_category'){
			str += '<option value="" >= 대분류 =</option>';
			for(ca of list){
				str += '<option value="'+ca.la_code+'" >'+ca.la_name+'</option>';
			}
			$('.large_category').html(str);
		}else if(obj.tb_name == 'medium_category'){
			str += '<option value="" >= 중분류 =</option>';
			for(ca of list){
				str += '<option value="'+ca.me_code+'" >'+ca.me_name+'</option>';
			}
			$('.medium_category').html(str);
		}else if(obj.tb_name == 'small_category'){
			str += '<option value="" >= 소분류 =</option>';
			for(ca of list){
				str += '<option value="'+ca.sm_code+'" >'+ca.sm_name+'</option>';
			}
			$('.small_category').html(str);
		}
	})
	
}
function ajaxPost(async, dataObj, url, success){
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
</html>