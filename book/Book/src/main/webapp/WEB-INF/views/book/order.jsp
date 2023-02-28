<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
var IMP = window.IMP; // 생략가능
IMP.init("imp78873511"); // <-- 본인 가맹점 식별코드 삽입

function requestPay() {
	IMP.request_pay({
	  pg : 'html5_inicis.INIpayTest',//{PG사 코드값}.{PG사 상점아이디}
	  pay_method : 'card',
	  merchant_uid: "57008833-33004", 
	  name : '당근 10kg',
	  amount : 1004,
	  buyer_email : 'Iamport@chai.finance',
	  buyer_name : '포트원 기술지원팀',
	  buyer_tel : '010-1234-5678',
	  buyer_addr : '서울특별시 강남구 삼성동',
	  buyer_postcode : '123-456'
	}, function (rsp) { // callback
	  if (rsp.success) {
	      console.log(rsp);
	  } else {
	      console.log(rsp);
	  }
	});
}
</script>
<style>
		 *{padding: 0; margin: 0; }
    ul,ol,li{ list-style: none; }
    html, body{width: 100%;}
    
    td{border: solid 1px #d6d6d6; height: 40px;}
    th{
      background-color: #edf5fc; 
      border: solid 1px #d6d6d6;
      width: 150px; height: 40px;
    }
    .root-box{
      display: flex;
      justify-content: center;
      
          }
    .input-box{
      margin: 2px 2px 2px 2px;
    }
    .order-list{
      text-align: center;
    }
    .td-left{
      text-align: left;
    }
    .payment-box{
    border: solid #d6d6d6;
    border-right:none ;
    border-left:none ;
    padding: 5px 0 5px 0;
    }
    .payment-sub-title{
      float: left;
      width: 150px;
    }
    .payment::after{
      content: '';
      display: block;
      clear: both;
    }
    .Deposit-without-bankbook{
      margin-left: 150px;
      
    }
    .input-name,.input-bank{
      display: inline-block;
      width: 100px
    }

    .pay-check{
      display: flex;
      justify-content: end;
      align-items: baseline;
      border:solid 3px #d6d6d6;
      height: 55px;
      margin-top:10px ;
      
    }
    
    .sp-pay{
      font-size: 30px;
      font-weight: bold;
      margin-left: 10px;
      margin-right: 10px;
    }
  
    .check{
      position: relative;
      left: 20%;
      
    }
    .address-num-btn{
      width: 130px; height: 35px;
      border: solid 1px #007bff;
      background-color: #007bff;
      color: white;
    } 
    .btn-box{
     display: flex;
     justify-content: center;
    }
    
    .payment-btn{
      width: 200px; height: 50px;
      border: solid 1px #007bff;
      background-color: #007bff;
      color: white;
      font-size: 25px;
      margin: 10px;
    }
    .address-num-btn:hover, .payment-btn:hover{
      border: solid 1px #0070e8;
      background-color: #0070e8;
    }

    </style>
</head>
<body>
	<div class="root-box">
		<div>
	    <div class="list-box">
	      <table class="order-list"  width="800px">
	        <tr class="order-list-heder" >
	          <th>도서명</th> 
	          <th>금액</th> 
	          <th>수량</th>
	        </tr>
	        <c:forEach items="${bookList}" var="b">
		        <tr class="order-information">
		          <td class="td-left">${b.bo_title}</td> 
		          <td>${b.bo_price}</td> 
		          <td>${b.bo_ea}</td>
		        </tr>
	        </c:forEach>
	      </table>
	      <div class="total-payment">
	        총 결재 예상 금액 :  자바스크립트 사용
	      </div>
	    </div>
	    <h5>배송지 정보</h5>
	    <div>
	      <table class="delivery-Information" width="800px">
	        <tr>
	          <th>주문인</th> 
	          <td>
	            <input type="text" class="input-box" name="or_me_name" value="${user.me_name}" >
	          </td>
	        </tr>
	        <tr>
	          <th>수령자</th> 
	          <td>
	            <input type="text" class="input-box" name="or_receiver_name" value="${user.me_name}">
	          </td>
	        </tr>
	        <tr>
	          <th>주소</th> 
	          <td>
	          	<input type="text" id="sample6_postcode" name="sample6_postcode" placeholder="우편번호">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="sample6_address" name="sample6_address" placeholder="주소"><br>
							<input type="text" id="sample6_detailAddress" placeholder="상세주소">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목">
	          </td>
	        </tr>
	        <tr>
	          <th>휴대전화번호</th> 
	          <td>
	            <input type="text" class="input-box" name="or_phone" value="${user.me_phone}">
	          </td>
	        </tr>
	        <tr>
	          <th>전화번호</th> 
	          <td>
	            <input type="text" class="input-box">
	          </td>
	        </tr>
	      </table>
	    </div>
	    <h5>결제정보</h5>
	    <div >
	      <table width="800px">
	        <tr>
	          <th>상품 합계 금액</th>
	          <td class="total-product-amount"> 자바스크립트 </td>
	        </tr>
	        <tr>
	          <th> 배송비 </th>
	          <td> 2500원 </td>
	        </tr>
	        <tr>
	          <th> 최종 결제 금액 </th>
	          <td class="final-payment-mount"> 자바스크립트 </td>
	        </tr>
	      </table>
	    </div>
	    <h5>결제수단 선택</h5>
	    <div class="payment-box">
	      <div class="payment-sub-title">
	        일반 결제 
	      </div>
	      <div class="payment">
	        <div class="payment-select">
	          <input type="radio" name="payment" id="">무통장입금
	          <input type="radio" name="payment" id="">신용카드
	        </div>
	        <div  class="Deposit-without-bankbook">
	          <span class="input-name">입금자명</span>
	          <input type="text" value="${user.me_name}"><br> 
	          <span  class="input-bank">입금은행</span>
	          국민은행 000000-00-000000 주식회사 북
	        </div>
	      </div> 
	    </div>
	    <div>
	      <div class="pay-check" width="800px">
	        <span class="sp-text">최종 결제 금액</span>
	        <span class="sp-pay" id="pay">자바스크립트</span>
	      </div>
	      <div class ="check" width="800px">
	        <input type="checkbox"  name="" id="">(필수) 구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다.
	      </div>
	    </div>
	    <div class="btn-box" width="800px">
	      <button class="payment-btn" onclick="requestPay()">결제하기</button>
	    </div>
    </div>
  </div>
  <script type="text/javascript">
	 
	  
	  // 다음주소 
	  function sample6_execDaumPostcode() {
     new daum.Postcode({
       oncomplete: function(data) {
         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

         // 각 주소의 노출 규칙에 따라 주소를 조합한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         var addr = ''; // 주소 변수
         var extraAddr = ''; // 참고항목 변수

         //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
         if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
             addr = data.roadAddress;
         } else { // 사용자가 지번 주소를 선택했을 경우(J)
             addr = data.jibunAddress;
         }

         // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
         if(data.userSelectedType === 'R'){
             // 법정동명이 있을 경우 추가한다. (법정리는 제외)
             // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
             if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                 extraAddr += data.bname;
             }
             // 건물명이 있고, 공동주택일 경우 추가한다.
             if(data.buildingName !== '' && data.apartment === 'Y'){
                 extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
             }
             // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
             if(extraAddr !== ''){
                 extraAddr = ' (' + extraAddr + ')';
             }
             // 조합된 참고항목을 해당 필드에 넣는다.
             document.getElementById("sample6_extraAddress").value = extraAddr;
         
         } else {
             document.getElementById("sample6_extraAddress").value = '';
         }

         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('sample6_postcode').value = data.zonecode;
         document.getElementById("sample6_address").value = addr;
         // 커서를 상세주소 필드로 이동한다.
         document.getElementById("sample6_detailAddress").focus();
       }
     }).open();
	  }
  
  	//금액 계산
	  $(function(){
		  let total = 0;
		  let delivery_fee = 2500;
		  $('.order-information').each(function() {
		      var price = parseInt($(this).find('td:nth-child(2)').text());
		      var quantity = parseInt($(this).find('td:nth-child(3)').text());
		      total += price * quantity;
		    });
		    $('.total-payment').text('총 결재 예상 금액: ' + total + '원');
		    $('.total-product-amount').text(total + '원');
		    $('.final-payment-mount').text(total + delivery_fee+ '원');
		    $('#pay').text(total + delivery_fee + '원');
	  })
  	//유효성 검사 모음
	  $(function(){
		  $('.payment-btn').click(function(){
			  //인풋창 값 가져오기
			  let or_me_name = $('[name=or_me_name]').val()
			  let or_receiver_name = $('[name=or_receiver_name]').val()
			  let or_phone = $('[name=or_phone]').val()
			  let sample6_postcode = $('[name=sample6_postcode]').val()
			  let sample6_address = $('[name=sample6_address]').val()
			  //주문인 유효성검사
			  if(or_me_name.trim().length == 0){
					alert('주문자를 입력해주세요');
					$('[name=or_me_name]').focus();
					return;
		  	}
				//수령인 유효성검사
			  if(or_receiver_name.trim().length == 0){
					alert('수령자를 입력해주세요');
					$('[name=or_receiver_name]').focus();
					return;
		  	}
			  // 주소 유효성검사(우편번호, 주소)
			  if(sample6_postcode.trim().length == 0 || sample6_address.trim().length == 0){
					alert('주소를 입력해주세요');
					$('[name=sample6_address]').focus();
					return;
		  	}
				//핸드폰 유효성검사 
			  if(or_phone.trim().length == 0){
					alert('핸드폰번호를 입력해주세요');
					$('[name=or_phone]').focus();
					return;
		  	}
		  })//결제 클릭 이벤트 끝
	  })// 문서의 끝
  </script>
</body>
</html>