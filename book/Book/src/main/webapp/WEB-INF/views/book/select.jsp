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

 .app{
  	display: flex;  /*이것떄문에 푸터 사이드로 이동함. 바디에 넣지 말고, 최상위 div를 만들어서 넣기.설정하기*/
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
  .rv_content, .btn-insert{
  	display:block;
  }
</style>
</head>
<body>
<div class="app">
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
			  <input type="hidden" name="or_bo_isbn" value="${b.bo_isbn}" >
			  <input type="hidden" name="or_ea" value="1">
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
	  <!-- 댓글리스트 -->
	  <div class="list-comment">
	  	<div class="item-comment">
	  		<div class="rv_me_id">작성자</div>
	  		<div class="rv_review">내용</div>
	  		<div class="rv_date">작성일</div>
	  		<input value="1"><!-- 댓글 수정할떄 사용 -->
	  	</div>
	  </div>
	  <!-- 페이지네이션 위치 -->
	  <ul class="pagination justify-content-center"></ul>
	  <!-- 댓글 입력창 -->
	  <div="form-group mt-5">
	  	<textarea class="form-control" name="rv_review"></textarea>
	  </div>
	  <div>
	  	<button class="btn btn-outline-primary col-12 btn-insert">댓글등록</button>
	  </div>
  </div>
</div>
</div>
<script type="text/javascript">
	let criteria = {
		page       : 1,
		perPageNum : 5 //한페이지에 댓글 5개씩 보여줌
	}
	let bo_isbn='${b.bo_isbn}'
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
	$(function(){
		$('.btn-insert').click(function(){
			let rv_review = $('[name=rv_review]').val();
			let rv_bo_isbn ='${b.bo_isbn}';
			let obj={
					rv_review:rv_review,
					rv_bo_isbn:rv_bo_isbn
			}
			//리뷰 등록
			$.ajax({
	      async:true,
	      type:'POST',
	      data:JSON.stringify(obj),
	      url:'<%=request.getContextPath()%>/ajax/review/insert',
	      dataType:'json',
	      contentType:'application/json; charset=UTF-8',
	      success: function(data){
	    	  alert(data.res);
	    	  getReviewList(criteria, bo_isbn)
	      }
		  });	
		})
	})

 //리뷰 리스트 
	function getReviewList(cri,bo_isbn){
		$.ajax({
      async:true,
      type:'POST',
      data:JSON.stringify(cri),
      url:'<%=request.getContextPath()%>/ajax/review/list/'+bo_isbn,
      dataType:'json',
      contentType:'application/json; charset=UTF-8',
      success: function(data){
    	  console.log(data);
    	  let str='';
    	  
    	  for(rv of data.list){
	    	  str+=
	    		'<div class="item-comment">'+
			  		'<div class="rv_me_id"><b>'+rv.rv_me_id+'</b></div>'+
			  		'<div class="rv_review">'+rv.rv_review+'</div>'+
			  		'<div class="rv_date">'+rv.rv_date_str+'</div>'+
			  		'<input value="1" type=hidden >';//이거 나중에 히든으로 바꾸기 
					//data.user &&을 추가함으로 서 로그인안해도 댓글리스트가 보임
		  		if (data.user && rv.rv_me_id === data.user.me_id) { //버튼생성 하고 데이터 보내는것까지 확인해야하고 컨트롤러에서 작업해야함
		  			str +=
		  			'<div class="button-box" >'+
		          '<button class="btn btn-outline-danger rv_modifiy">수정</button>'+
		          '<button data-target="'+ rv.rv_num +'" class="btn btn-outline-success rv_delete">삭제</button>'+
		      	'</div>';
	  			}	
		  		str += '</div>';
    	  }
    	  //댓글 삭제
    	  //작동안함
   	    $('.rv_delete').click(function(e){
   	    	let rv_num = $(this).data('target');
   	    	let comment ={
   	    			co_num : rv_num
   	    	}
   	    }
		   	// 상위 요소에 이벤트 위임 사용
	   	 $(document).on('click', '.rv_delete', function(e) {
	   	     e.preventDefault(); // 기본 동작 방지 (필요한 경우)
	   	     let rv_num = $(this).attr('data-target'); 
	   	     let comment = {
	   	         co_num: rv_num
	   	     };
		   	 
   	    	console.log(comment)
   	    	ajaxPost (false, comment,'/ajax/comment/delete', commentDeleteSuccess)
   	    });
    	 
    
    	  $('.list-comment').html(str);
    	  console.log(data.pm);// 댓글 리스트 페이지네이션 작업해야함 
    	  let pm = data.pm;
    	  let pmStr = ''; 
      	if(pm.prev){
      		pmStr +=
        	'<li class="page-item">' +
        		'<a class="page-link" href="javascript:#;" onclick="criteria.page='+(pm.startPage-1)+';getReviewList(criteria, bo_isbn)">이전</a>' +
        	'</li>';
      	}
        for(let i = pm.startPage; i<=pm.endPage; i++){
      	  let active = pm.cri.page == i ? 'active' : '';
      	  pmStr +=
        	'<li class="page-item '+active+'">'+
        		'<a class="page-link" href="javascript:#;" onclick="criteria.page='+(i)+';getReviewList(criteria, bo_isbn)">'+ i +'</a>'+
        	'</li>';
        }
        if(pm.next){
      	  pmStr +=
        	'<li class="page-item">' + 
        		'<a class="page-link" href="javascript:#;" onclick="criteria.page='+(pm.endPage+1)+';getReviewList(criteria, bo_isbn)">다음</a>' + 
        	'</li>';
        }
        $('.pagination').html(pmStr);
      }
		});
	}
	getReviewList(criteria, bo_isbn)
	

	function CommentDeleteSuccess(data){
		//삭제가 성공
		if(data.res === 1){
			alert('댓글이 삭제되었습니다.');	
		//삭제가 실패
		}else{
			alert('댓글 삭제에 실패했습니다. 다시 시도해주세요.');	
		}	
	}

</script>
</body>
</html>