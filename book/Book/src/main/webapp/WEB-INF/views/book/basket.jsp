<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   .btn-up, .btn-down{
     width: 30px; height: 29px;
     background-color : gainsboro; border-radius: 0%;
     border: 1px solid #cdcdcd;
     padding: 0; margin: 0;
     font-weight: bold; font-size: 20px; text-align: center;
     line-height:23px
   }
   .table-basket{
     text-align: center;  
   }
   .table td{
     vertical-align :middle;
      
   }
   thead{
     background-color: #007bff;
     color: white;  
   }
   .table-basket-tbody tr{
     width: 200px;
   }
   .book-cover-sell{
     width: 120px;
   }
   .book-cover{
     width: 100%; 
   }
   .ea-box{
     display: flex;
     justify-content: center;
   }
   .ea-value{
     width: 50px; 
     outline: none !important;
     box-shadow: none !important;
     text-align: center;
   }
   .table-basket-sum{
     background-color: #e3f2fd;      
   }
   .table-basket-sum th{
     width: 15%;      
   }
   
  .select-checkbox, .checkbox-all{
   	 width: 20px; height: 20px;
   }
   
   .btn-delete, .btn-modify{
   		display:block;
   		margin: 10px
   }
   
 </style>
</head>
<body>
  <div class="container">
    <h2>장바구니</h2>
    <table class="table table-basket">
      <thead>
        <tr>
          <th>
          	<input type="checkbox" class="checkbox-all" checked>
          </th>
          <th class="book-cover-sell">도서</th>
          <th>도서명</th>
          <th>가격</th>
          <th>수량</th>
          <th>합계</th>
          <th></th>
        </tr>
      </thead>
      <tbody class="table-basket-tbody">
      <c:forEach items="${basketList}" var="ba">
        <tr>
          <td class= td-basket-info>
          	<input type="checkbox" class="select-checkbox" name="select-checkbox" checked>
            <input type="hidden" class="isbn" name="" value="${ba.ba_bo_isbn}">
            <input type="hidden" class="price" name="" value="${ba.ba_bo_price}">
            <input type="hidden" class="ea" name="" value="${ba.ba_ea}">
            <input type="hidden" class="product-total" name="" value="${ba.ba_bo_price * ba.ba_ea} ">
          </td>
         
          <td class="book-cover-sell">
            <img src="<c:url value="${ba.ba_bo_front_url}"></c:url>" class="book-cover" alt="책커버">
          </td>
          <td>${ba.ba_bo_title}</td>
          <td class="price">${ba.ba_bo_price}원</td>
          <td class="ea-sell">
            <div class="ea-box">
              <div class="btn btn-down">-</div>
              <input type="text" class="ea-value" name="ea" id="ea" value="${ba.ba_ea}">
              <div class="btn btn-up">+</div>
            </div>
          </td>
          <td>${ba.ba_bo_price * ba.ba_ea}원</td>
          <td class="btn-sell">
            <button type="button" class="btn btn-primary btn-modify" data-ba_bo_isbn="${ba.ba_bo_isbn}">변경</button>
           	<button type="button" class="btn btn-primary btn-delete" data-ba_bo_isbn="${ba.ba_bo_isbn}">삭제</button>
          </td>
        </tr>
       </c:forEach>
      </tbody>
    </table>
  </div>
  <div class="container">
    <table class="table table-basket-sum">
      <tbody>
        <tr>
          <th>총 상품 가격</th>
          <td class="totalPrice">자바스크립트</td>
        </tr>
        <tr>
          <th>총 주문 상품 수</th>
          <td class="totalCount">자바스크립트</td>
        </tr>
        <tr>
          <th>총결재 예상금액</th>
          <td class="finalTotaPrice">자바스크립트</td>
        </tr>
      </tbody>
    </table>
    <button class="btn btn-primary col-12 btn-order">선택한 상품 주문하기</button>
  </div>
  
  <!-- 수량 변경 및 삭제 from -->
  <form action ="/basket/update" method="post" class="ea-update-form">
  	<input type="hidden" name="ba_bo_isbn">
  	<input type="hidden" name="ba_ea">
  	<input type="hidden" name="ba_me_id" value="${user.me_id}">
  </form>
  <!-- 주문 from -->
  <form action ="/order" method="get" class="order-form">
 
  </form>
  
  <script type="text/javascript">
  $(function(){
	  setTotalInfo()
	  
	  $('.select-checkbox').change(function(){
		  setTotalInfo($('.td-basket-info'))
	  })
	  
	  //수량 조정(+ -) (name을 사용할경우 동시변환이 되기때문에 위치선택자를 사용함.)
	  $('.btn-up').click(function(){
	  	let ea = $(this).parent().find('input').val();
	  	$(this).parent().find('input').val(++ea);
	  })
	  $('.btn-down').click(function(){
	  	let ea = $(this).parent().find('input').val();
	  	$(this).parent().find('input').val(--ea);
	  })
	  // 수량 변경 버튼
	  $('.btn-modify').click(function(e){
		  e.preventDefault();
		  let isbn = $(this).data('ba_bo_isbn');
		  let ea = $(this).parent().siblings('.ea-sell').find('input').val();
		 	let id = $('[name=ba_me_id]').val()
		 // let id = ${user.me_id} //bird5 is defined data 타겟이나 히든input에 담아서 가져와야함
		 
		 let obj= {
				 ba_bo_isbn : isbn,
				 ba_ea : ea,
				 ba_me_id : id
		  }
			ajaxPost(false, obj, '/basket/update', function(data){
				location.reload();
			})
	  })
	  //삭제 버튼
		$('.btn-delete').click(function(){
	  	let isbn = $(this).data('ba_bo_isbn');
			let id = $('[name=ba_me_id]').val()
			let obj= {
				 ba_bo_isbn : isbn,
				 ba_me_id : id
		  }
			ajaxPost(false, obj, '/basket/delete', function(data){
				location.reload();
			})
		})
		//체크박스 전체선택 전체해제
		$('.checkbox-all').click(function(){
			if($('.checkbox-all').is(':checked'))
				$('.select-checkbox').prop('checked',true)
			else
				$('.select-checkbox').prop('checked',false)
		})
		//하위 체크박스가 모두 선택되면 전체선택
		$('.select-checkbox').click(function(){
			var total = $('.select-checkbox').length;
			var checked = $('.select-checkbox:checked').length;
			if(total == checked)
				$('.checkbox-all').prop('checked', true)
			else
				$('.checkbox-all').prop('checked', false)
		})
		$('.btn-order').click(function(){
			//체크된 데이터(isbn이랑 수량 아이디 보냄)
			let form_contents =''
			let order_num = 0;
			
			$('.td-basket-info').each(function(index, element){
				if($(this).find('.select-checkbox').is(':checked')){
					let ba_bo_isbn = $(this).find('.isbn').val();
					let ba_ea = $(this).find('.ea').val();
					
					let isbn_input ='<input type="hidden" name="or_bo_isbn" value="'+ba_bo_isbn+'">'
					form_contents += isbn_input
					let ea_input ='<input type="hidden" name="or_ea" value="'+ba_ea+'">'
					form_contents += ea_input
					
					order_num ++ ;
					console.log(order_num)
				}
			})
			$('.order-form').html(form_contents)
			$('.order-form').submit()
		})
  })
  //종합정보(뷰 계산)
  function setTotalInfo(){
	  let totalPrice = 0;
	  let totalCount = 0;
	  let finalTotalPrice = 0;
	  // 체크값이 ture인지 얻어야함 
	  
	  $('.td-basket-info').each(function(index, element){
		  if($(this).find('.select-checkbox').is(':checked')){
		  	totalPrice += parseInt($(this).find('.product-total').val())
		  	totalCount += parseInt($(this).find('.ea').val())
		  }
	  })
	 
		finalTotalPrice = totalPrice;
	  
	  $('.totalPrice').text(totalPrice + '원')
   	$('.totalCount').text(totalCount + '개')
    $('.finalTotaPrice').text(finalTotalPrice + '원')
  }
	  
  
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