<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

 <script type="text/javascript">
 
 document.addEventListener('keydown', function(event) {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	}, true);
 
 
 function auto_date_format( e, oThis ){
     
     var num_arr = [ 
         97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
         48, 49, 50, 51, 52, 53, 54, 55, 56, 57
     ]
     
     var key_code = ( e.which ) ? e.which : e.keyCode;
     if( num_arr.indexOf( Number( key_code ) ) != -1 ){
     
         var len = oThis.value.length;
         if( len == 4 ) oThis.value += "-";
         if( len == 7 ) oThis.value += "-";
     
     }
     
 }
 
 function list(page){
	 
	 var keyword = $("#keyword").val();
	 
	 if(keyword == ""){
		 
	var search_option = "";
	 
	 }else if(keyword != ""){
	 
	 var search_option = $("#search_option").val();
		
	 }
	 
	 var startDateFirst = $("#startDateFirst").val();
	 
	 var endDateFirst = $("#endDateFirst").val();
	 
	 
	
	 
	 
	 var startDateH = $("#startDate").val();
		
	 var endDateH = $("#endDate").val();
	 
	 
	 
	var startDate = startDateH.replace(/\-/g,""); //날짜 검색시 하이픈 제거
		 
	var endDate = endDateH.replace(/\-/g,"");
	
	

	 
	 	console.log("페이지를 이동합니다.");
	 	
	 	location.href="./main.ino?curPage="+page+"&keyword="+keyword+"&search_option="+search_option+"&startDate="+startDate+"&endDate="+endDate+"&startDateFirst="+startDateH+"&endDateFirst="+endDateH; 
	 	
	 };
	 
	 
	 
function searchlist(page){
	
		 	console.log("페이지를 이동합니다.");
		 		
			 var keyword = $("#keyword").val();
			 			 		 
			 if(keyword == ""){
				 
				 var search_option = "";
				 
			 }else if(keyword != ""){

			var search_option = $("#search_option").val();
	
			}
			 
			 var startDateFirst = $("#startDateFirst").val();
			 
			 var endDateFirst = $("#endDateFirst").val();
			 
	 
			 var startDateH = $("#startDate").val();
				
			 var endDateH = $("#endDate").val();
			 
			
			 
			var startDate = startDateH.replace(/\-/g,""); //날짜 검색시 하이픈 제거
				 
			var endDate = endDateH.replace(/\-/g,"");

			
		
			 

		 	location.href="./main.ino?curPage="+page+"&keyword="+keyword+"&search_option="+search_option+"&startDate="+startDate+"&endDate="+endDate+"&startDateFirst="+startDateH+"&endDateFirst="+endDateH; 
		 	 	
		 	
 		
		 };
 
 
		 
 $(function (){
	 
	 //게시판 목록 페이지로 이동하게 하는 함수
	 
	 $("#btnSearch").click(function(){
		 
		 var keyword = $("#keyword").val();
		 
		 if(keyword == ""){
			 
			 var search_option = "";
		 
		 }  else  {
			 
		 var search_option = $("#search_option").val();
			 
		 }
		 
		 
		 var startDateFirst = $("#startDate").val();
			
		 var endDateFirst = $("#endDate").val(); 		
		
		
		 
		 var startDateArray =  startDateFirst.split('-');    //하이픈 기준으로 년도, 달, 일을 구분한다.
		 
		 var startDateYear = startDateArray[0]; 			 //년도 
		 
		 var startDateMonth = startDateArray[1];			 //달, 12월까지만 저장되게
		 
		 var startDateDay = startDateArray[2];				 //일
		 
		 
		 
		 var endDateFirstArray =  endDateFirst.split('-');   //하이픈 기준으로 년도, 달, 일을 구분한다.
		 
		 var endDateYear = endDateFirstArray[0]; 			 //년도 
		 
		 var endDateMonth = endDateFirstArray[1];			 //달, 12월까지만 저장되게
		 
		 var endDateDay = endDateFirstArray[2];		         //일
		 
		 
		 
 		 var startDate = startDateFirst.replace(/\-/g,""); //날짜 검색시 하이픈 제거
		 
		 var endDate = endDateFirst.replace(/\-/g,"");
 		 
 		 
 		 
		 var search_boolean = keyword.replace(/[0-9]/g,""); //검색어 숫자 판별
		 
		 
		 var searchStartDate = startDate.replace(/[0-9]/g,""); //날짜 검색시 한글 및 영어 판별
		 
		 
		 var searchEndDate = endDate.replace(/[0-9]/g,"");
		
		 
		 console.log(search_boolean);
		 
		 
		 console.log(data);
		 
		 
		
		 
		
		 // form 을 json 화 시키기 
		 // select ->> CUD 
		 // 글 작성시 분기를 줘서 서버에 완전히 입력됬을때에만 성공 메시지 출력되게 하기
		 
		 if (search_option == "num" && search_boolean != ""){
				
				alert("숫자만 입력해주세요.");
				
			}
		
		 
		if (startDateFirst == "" || endDateFirst == ""){
			 
			 alert("시작날짜나 종료날짜를 입력해주시기 바랍니다.");
			 
		 	}
		
		
		 if (searchStartDate != "" || searchEndDate != "" ){
			 
			 alert("다음과 같은 형식으로 검색해주시기 바랍니다. YYYY-MM-DD");
			 
	
		 }
		 
		 
		 else if(startDateYear > 2021 || startDateYear == 00 || startDateYear < 2020){
				 
				 alert("아직 지나지 않은 년도라 검색할 수 없습니다.");
				 
			 	}
			 
		 else if(startDateMonth > 12 || startDateMonth == 00){
				 
				 alert("시작날짜는 12월까지만 검색이 가능합니다.");
				 
			 	}

				
		 else if(startDateDay > 30 || startDateDay == 00){

				alert("시작날짜는 31일까지만 검색할 수 있습니다.");

				
					}
				
		 else if(endDateYear > 2021 || endDateYear == 00){
				 
				 alert("아직 지나지 않은 년도라 검색할 수 없습니다.");
				 
			 	}
			 
		 else if(endDateMonth > 12 || endDateMonth == 00){
				 
				 alert("종료날짜는 12월까지만 검색이 가능합니다.");
				 
			 	}

				
		 else if(endDateDay > 31 || endDateMonth == 00){

				alert("종료날짜는 31일까지만 검색할 수 있습니다.");

				
					}
	 
			else{
				
				 var params = {"startDate" : startDate , "endDate" : endDate , "keyword" : keyword , "search_option" : search_option, "startDateFirst" : startDateFirst, "endDateFirst" : endDateFirst}

				 var data = params;
				 
					
					$.ajax({
						 url: "./search.result.ino", //데이터를 보낼 url
					//	type: "POST", //데이터를 보낼 방식  
						dataType:"json",
						contentType: "application/json; charset=utf-8;",
						 data: data, //보낼 데이터
					
					        
					        success : function(data){//데이터를 보내는 것이 성공했을 시 출력되는 메시지
					        	
					 			
					        	
					        	alert("검색이 완료되었습니다.");
					        	
					        	//비우기
					        	$(".listContent").empty();
					        	
					        	//페이징 초기화
						        $(".listSearch").empty();
					        	
					        	var startDateFirst = data.startDateFirst;
					        	
					        	var endDateFirst = data.endDateFirst;
					        		
					        	
						       	 var startDate = startDateFirst.replace(/\-/g,""); //날짜 검색시 하이픈 제거
								 
								 var endDate = endDateFirst.replace(/\-/g,"");
					        						        	
					        
						    	$.each(data.list, function(index, arrjson) {
						    		
						    		$('.listContent').append("<div style=\"width: 50px; float: left;\">" + arrjson.NUM + "</div>");
						    		
						    		$('.listContent').append("<div style=\"width: 300px; float: left;\"><a href=\"./freeBoardDetail.ino?num="+ arrjson.NUM +"&startDate="+ startDate +"&endDate="+ endDate +"&keyword="+ data.keyword +"&search_option="+ data.search_option +"&startDateFirst="+ data.startDateFirst +"&endDateFirst="+ data.endDateFirst +"\">" + arrjson.TITLE + "</a></div>");
						    		
						    		$('.listContent').append("<div style=\"width: 150px; float: left;\">" + arrjson.NAME + "</div>");
						    		
						    		$('.listContent').append("<div style=\"width: 150px; float: left;\">" + arrjson.REGDATE + "</div>");
						    		
						    		$('.listContent').append("<hr style=\"width: 600px\">");
						    		
						    	})
						    	
						    	
						    
						    		
						    		var curPage = data.pager.curPage;
						    		
						    		var prevPage = data.pager.prevPage;
						    		
						    		var nextPage = data.pager.nextPage;
						    		
						    		var totPage = data.pager.totPage;
						    		
						    		var totBlock = data.pager.totBlock;
						    		
						    		var curBlock = data.pager.curBlock;
						    		
						    		var prevBlock = data.pager.prevBlock;
						    		
						    		var nextBlock = data.pager.nextBlock;
						    		
						    		var pageBegin = data.pager.pageBegin;
						    		
						    		var pageEnd = data.pager.pageEnd;
						    		
						    		var blockBegin = data.pager.blockBegin;
						    		
						    		var blockEnd = data.pager.blockEnd;
						    		
						    		var blockEnd = data.pager.blockEnd;
						    		
						    		var search_option = data.search_option;
						    		
						    		var keyword = data.keyword;
						    		
	
						    		console.log(curPage);
						    		console.log(nextPage);
						    		console.log(totPage);
						    		console.log(totBlock);
						    		console.log(curBlock);
						    		console.log(prevBlock);
						    		console.log(nextBlock);
						    		console.log(pageBegin);
						    		console.log(pageEnd);
						    		console.log(blockBegin);
						    		console.log(blockEnd);
						    		
						    		console.log(search_option);
						    		
						    		console.log(keyword);
						    		
						    		
						    		if(curBlock > 1){
						    			
						    		$('.listSearch').append("<a href='#' onclick='searchlist("+1+")'>"+" [처음] "+"</a>");
						    		
						    		
						    		}
						    		
						    		
						    		if(curBlock > 1){
						    			
							    		$('.listSearch').append("<a href='javascript:'searchlist("+prevPage+")'>"+" [이전] "+"</a>");
							    		
							    		
							    	}
						    		
						    		
						    		
						    		for(var page = 1; page <= blockEnd; page++){
						    			
						    			if(page == curPage) {
						    				
						    				$('.listSearch').append("<span style='color:red;'>"+" "+ page +" "+"</span>");
						    				
						    			}else {
						    				
						    					$('.listSearch').append("<a href='#' onclick='searchlist("+page+")'>"+" "+ page +" "+"</a>");
						    				
						    				
						    				}
						    			
		
						    			}
						    		
						    		
						    		if(curBlock <= totBlock && curPage  != totPage){
						    			
						    				
						    				$('.listSearch').append("<a href='#' onclick='searchlist("+nextPage+")'>"+" [다음] "+"</a>");
						    			
						    			}
						    		
						    		
						    		if(curPage <= totPage && curPage != totPage) {
						    			
						    				
						    				$('.listSearch').append("<a href='#' onclick='searchlist("+totPage+")'>"+" [끝] "+"</a>");
						    			
						    			
						    			}
						    		

					       
					                }, error: function(errorThrown) {
					                    alert(errorThrown.statusText);
					                }
					                   
					
					});
					
					
				}
		 
		 	
	 		});
	 	
	 });

 </script>


<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	
	
	<form name="form1" id="form1">
    	<select name = "search_option" id="search_option" value = "${map.listComon}">
    		<option value="">전체</option>
        	<c:forEach items="${map.listComon}" var = "Comon" >
        		<option value="${Comon.DECODE}">${Comon.DECODE_NAME}</option>
        		</c:forEach>
    	</select>
    
    
    
    
    
    
	    <input id="keyword" name="keyword" value="${map.keyword}">
	    
	    <button type="button" value="조회" id ="btnSearch" name="btnSearch">조회</button><br>
	    
	    <input name="startDate" id="startDate" name="startDate" value="${map.startDate}" onkeyup="auto_date_format(event, this)" onkeypress="auto_date_format(event, this)" maxlength="10" />    ~    <input name="endDate" id="endDate" name="endDate" value="${map.endDate}" onkeyup="auto_date_format(event, this)" onkeypress="auto_date_format(event, this)" maxlength="10" />
	    
	    <input type = "hidden" id="startDateFirst" name = "startDateFirst" value="${map.startDateFirst }">
	    
	    <input type = "hidden" id="endDateFirst" name = "endDateFirst" value="${map.endDateFirst }">
    
	 	</form>
	
	
<hr style="width: 600px">	
<div class = "listContent">
<c:forEach items="${map.list }" var="row">
			<div style="width: 50px; float: left;">${row.NUM }</div>	
			<div style="width: 300px; float: left;"><a href="./freeBoardDetail.ino?num=${row.NUM }
&curPage=${map.pager.curPage}
&search_option=${map.search_option}
&keyword=${map.keyword}
&startDateFirst=${map.startDateFirst}
&endDateFirst=${map.endDateFirst}
&startDate=${map.startDate}
&endDate=${map.endDate}	">${row.TITLE}</a></div>
			<div style="width: 150px; float: left;">${row.NAME }</div>
			<div style="width: 150px; float: left;">${row.REGDATE }</div> 
			
<hr style="width: 600px">

</c:forEach>
</div>

<div class = "listSearch">
<c:if test="${map.pager.curBlock > 1}">
  <a href="#" onclick="list('1')">[처음]</a>
            </c:if> <!-- 현재 블록이 1블록보다 크면 (뒤쪽에 있기때문에) 처음으로 갈 수 있도록 링크를 추가 -->
        
            <c:if test="${map.pager.curBlock > 1}">
                <a href="#" onclick="list('${map.pager.prevPage}')">
                [이전]</a>
            </c:if> <!-- 현재 블록이 1블록보다 크면 이전 블록으로 이동할 수 있도록 링크 추가 -->
            
            <c:forEach var="num"
                begin="${map.pager.blockBegin}"
                end="${map.pager.blockEnd}">
                <c:choose>
                    <c:when test="${num == map.pager.curPage}">
                    
                    <!-- 현재 페이지인 경우 하이퍼링크 제거 -->
                    <!-- 현재 페이지인 경우에는 링크를 빼고 빨간색으로 처리를 한다. -->
                        <span style="color:red;">${num}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="#" onclick="list('${num}')" >${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
            
            <c:if test="${map.pager.curBlock <= map.pager.totBlock && map.pager.curPage != map.pager.totPage}">
                <a href="#" onclick="list('${map.pager.nextPage}')">[다음]</a>
            </c:if> <!-- 현재 페이지블록이 총 페이지블록보다 작으면 다음으로 갈 수있도록 링크를 추가 -->
            
            
            <c:if test="${map.pager.curPage <= map.pager.totPage && map.pager.curPage != map.pager.totPage}">
                <a href="#" onclick="list('${map.pager.totPage}')">[끝]</a>
            </c:if> <!-- 현재 페이지블록이 총 페이지블록보다 작거나 같으면 끝으로 갈 수 있도록 링크를 추가함-->
</div>

	
</body>
</html>