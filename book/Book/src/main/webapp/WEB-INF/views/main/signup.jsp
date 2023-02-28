<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<style>
      *{padding: 0; margin: 0;}
      ul,ol,li{ list-style: none; }
      a{ text-decoration: none; }

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
      }
      .box {
        display: flex;
        justify-content: center ;
        align-items: center;
      }   
      .postcoide{
        width: 300px; 
        display: inline;
        border-top-right-radius: 0px;
        border-bottom-right-radius:0px ;
      }
      .btn-postcoide{
        
        width: 100px; height: 38px;
        background-color: #007bff;
        border-color: #007bff;
        color: white;
        border-radius: 5px;
        border:0px;
        border-top-left-radius: 0px;
        border-bottom-left-radius:0px ;
      }
      .postcode-box, .extend-years{
       margin-bottom: 26px;
      }
    </style>
  </head>
<body>
<form action="<%=request.getContextPath()%>/signup" method="post">
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
      <div class="form-group">
        <label for="me_pw2">비밀번호 재입력</label>
        <input type="password" class="form-control" id="me_pw2" name="me_pw2">
      </div>
      <div class="form-group">
        <label for="me_name">이름</label>
        <input type="text" class="form-control" id="me_name" name="me_name">
      </div>
      <div class="form-group">
        <label for="me_email">e-mail</label>
        <input type="text" class="form-control" id="me_email" name="me_email">
      </div>
      <div class="form-group">
        <label for="me_phone">휴대전화</label>
        <input type="text" class="form-control" id="me_phone" name="me_phone">
      </div>


      <div>개인정보 유효기간</div>
      <div class="extend-years">
        <div class="form-check-inline">
          <label class="form-check-label">
            <input type="radio" class="form-check-input" name="me_extend_years" value="1">1년
          </label>
        </div>
        <div class="form-check-inline">
          <label class="form-check-label">
            <input type="radio" class="form-check-input" name="me_extend_years" value="3">3년
          </label>
        </div>
        <div class="form-check-inline">
          <label class="form-check-label">
            <input type="radio" class="form-check-input" name="me_extend_years" value="5">5년
          </label>
        </div>
        <div class="form-check-inline">
          <label class="form-check-label">
            <input type="radio" class="form-check-input" name="me_extend_years" value="탈퇴시삭제">탈퇴 시까지
          </label>
        </div>
      </div>

      <div><h5>추가정보 입력</h5></div>
      <label for="sample3_postcode">주소</label>
      <div class="postcode-box">
      	<input type="text" class="form-control postcoide"id="sample3_postcode" placeholder="우편번호" name="me_post_code">
				<input type="button"class="btn-postcoide"  onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>
				<div id="wrap" style="display:none;border:1px solid;width:400px;height:300px;margin:5px 0;position:relative">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div><br>
				<input type="text" class="form-control" id="sample3_address" placeholder="주소" name="me_addr"><br>
				<input type="text" class="form-control" id="sample3_detailAddress" placeholder="상세주소" name="me_addr_detail"><br>
				<input type="text" class="form-control" id="sample3_extraAddress" placeholder="참고항목">
      </div>
      <div>
       <button type="submit" class="btn btn-outline-primary">회원가입</button>
      </div>
    </div>
  </div>
  <script type="text/javascript">
  // 우편번호 찾기 찾기 화면을 넣을 element
  var element_wrap = document.getElementById('wrap');

  function foldDaumPostcode() {
      // iframe을 넣은 element를 안보이게 한다.
      element_wrap.style.display = 'none';
  }

  function sample3_execDaumPostcode() {
    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
      oncomplete: function(data) {
        // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

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
          document.getElementById("sample3_extraAddress").value = extraAddr;
      
        } else {
          document.getElementById("sample3_extraAddress").value = '';
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('sample3_postcode').value = data.zonecode;
        document.getElementById("sample3_address").value = addr;
        // 커서를 상세주소 필드로 이동한다.
        document.getElementById("sample3_detailAddress").focus();

        // iframe을 넣은 element를 안보이게 한다.
        // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
        element_wrap.style.display = 'none';

        // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
        document.body.scrollTop = currentScroll;
      },
      // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
      onresize : function(size) {
          element_wrap.style.height = size.height+'px';
      },
      width : '100%',
      height : '100%'
    }).embed(element_wrap);

    // iframe을 넣은 element를 보이게 한다.
    element_wrap.style.display = 'block';
  }
 
  
  $(function(){
	  $('.btn-outline-primary').click(function(){
		  //아이디 확인
		  let idRegex = /[a-z0-9]{5,20}/
		  let me_id = $('[name=me_id]').val()
		  
		  if(!idRegex.test(me_id)){
			  alert('아이디는 5~20자의 영문 소문자, 숫자만 사용 가능합니다.')
			  $('[name=me_id]').focus();
			  return;
		  }
		  
		  //비밀번호 확인 (입력 공란, 비밀번호 정규식 ,재입력 공란, 입력과 재입력 일치)
		  let me_pw = $('[name=me_pw]').val()
		  let me_pw2 = $('[name=me_pw2]').val()
		  
		  if(me_pw.trim().length == '0'){
				alert('비밀번호를 입력해주세요')
				$('[name=me_pw]').focus()
				return;
			}
		  
		  let pwRegex = /[a-zA-Z0-9]{5,20}/
		  if(!pwRegex.test(me_pw)){
				alert('비밀번호는 5~20자의 영문 대/소문자, 숫자만 사용 가능합니다.')
				$('[name=me_pw]').focus()
				return;
			}
		  
		  if(me_pw2.trim().length == '0'){
				alert('비밀번호 재입력을 입력해주세요')
				$('[name=me_pw2]').focus()
				return;
			}
		  
			if(me_pw != me_pw2){
				alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요')
				$('[name=me_pw]').focus()
				return;
			}
		  
			//이름 입력확인
			let me_name = $('[name=me_name]').val();
			if(me_name.trim().length == '0'){
				alert('이름을 입력하세요')
				$('[name=me_name]').focus()
				return;
			}
		  
			//이메일 형식(정규식)
		  let emailRegex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i
		  let me_email = $('[name=me_email]').val()
		  if(!emailRegex.test(me_email)){
			  alert('이메일이 올바른 형식이 아닙니다.')
			  $('[name=me_email]').focus();
			  return;
		  }
		  //휴대전화 번호형식(정규식)
		  let phoneRegex =/\d{3}-\d{4}-\d{4}/
		  let me_phone = $('[name=me_phone]').val()
		  if(!phoneRegex.test(me_phone)){
			  alert('휴대전화번호가 올바른 형식이 아닙니다.')
			  $('[name=me_phone]').focus();
			  return;
		  }
			return;
	  })
  })
  
  </script>
 	</form>
</body>
</html>