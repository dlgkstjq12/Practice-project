<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<!-- function modify(){
	var form = document.insertForm;
	form.action = "./freeBoardModify.ino";
	form.method="POST";
	form.submit();
} -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script type="text/javascript">


 
$(function (){
	
	/* var startDateFirst = ${map.startDateFirst};
	
	var endDateFirst = ${map.endDateFirst};
	
	var startDate = startDateFirst.replace(/\-/g,"");
	 
	var endDate = endDateFirst.replace(/\-/g,""); */
	
	$("#btnSubmit").click(function(){
		
		
		location.href="./main.ino?keyword=${map.keyword}&search_option=${map.search_option}&startDateFirst=${map.startDateFirst}&endDateFirst=${map.endDateFirst}&startDate=${map.startDate}&endDate=${map.endDate}&curPage=${map.curPage}";
		
		
	});
	


	
$("#btnUpdate").click(function(){

	 if(confirm("수정하시겠습니까?")){
		  
	if(document.all.insertForm.title.value == null && document.all.insertForm.content.value == null){
		
		alert("제목과 내용이 입력되지 않았습니다.");
		
	}
		 
	if(document.all.insertForm.title.value == null || document.all.insertForm.title.value == ""){
		
		alert("제목이 입력되지 않았습니다.");
		
	}else if(document.all.insertForm.content.value == null || document.all.insertForm.content.value == ""){
		
		alert("내용이 입력되지 않았습니다.");
		
	}else if (document.all.insertForm.content.value != null 
			&& document.all.insertForm.content.value != ""
			&& document.all.insertForm.title.value != "" 
			&& document.all.insertForm.title.value != null){
		
		
		var data = $("#insertForm").serialize();
		
		console.log("data"+data);
		
		$.ajax({
			url: "./freeBoardModify.ino", //데이터를 보낼 url
			type: "POST",
			dataType:"json",
			 contentType: "application/x-www-form-urlencoded; charset=MS949",
			 data: data, //보낼 데이터
		
		        
		        success : function(data){//데이터를 보내는 것이 성공했을 시 출력되는 메시지
				
		        	if(data.modifyResult == true){
		        		
		        		alert("글이 수정되었습니다.");
		        		
		        		location.href = "./main.ino";
		        		
		        	}else if(data.modifyResult == false){
		        		
		        		alert("글을 다시 작성해주시기 바랍니다.");
		        		
		        	}

		                }, error: function(errorThrown) {
		                	
		                    alert("통신이 실패했습니다.");
		                    
		                }
		                   
		
					});
		
			}
	
		 }
	
	});
	
/* url: "./freeBoardDelete.ino?num="+data, //데이터를 보낼 url */
	
	
$("#btnDelte").click(function(){
	 
	 if(confirm("글을 삭제하시겠습니까?")){
			 
		 var data = $("#num").val();
		 
		 console.log("data"+data);
 
			$.ajax({
					url: "./freeBoardDelete.ino?num="+data, //데이터를 보낼 url
					dataType:"json",
					 contentType: "application/json; charset=utf-8;",
					 data: data, //보낼 데이터
				
				        
				        success : function(data){//데이터를 보내는 것이 성공했을 시 출력되는 메시지
						
				        		alert("글을 삭제하였습니다.");
				        		
				        		location.href = "./main.ino";
	
				                }, error: function(errorThrown) {
				                	
				                    alert("통신이 실패했습니다.");
				                    
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
	<div style="width: 650px;" align="right">
	<button type="button" value="리스트로" name="btnSubmit" id="btnSubmit">리스트로</button>
	</div>
	<hr style="width: 600px">
	


	<form id="insertForm" name="insertForm" method="POST" accept-charset="utf-8">

		<c:forEach items="${map.list }" var="row">
		<input type="hidden" id="num" name="num" value="${row.NUM }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" id="name" name="name" value="${row.NAME }"
				readonly />
		</div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" id="title" name="title" value="${row.TITLE }" />
		</div>

		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" id="regdate" name="regdate"
				value="${row.REGDATE }" />
		</div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left">
			<textarea id="content" name="content" rows="25" cols="65">${row.CONTENT }</textarea>
		</div>
		
		<div align="right">

			<button type="button" value="삭제" name="btnDelte" id="btnDelte"
				value="${row.NUM }">삭제</button>
			
			<button type="button" value="수정" name="btnUpdate" id="btnUpdate">수정</button>

			<input type="button" value="취소" onclick="location.href='./main.ino'">

			&nbsp;&nbsp;&nbsp;
		</div>
		</c:forEach>
	</form>

</body>
</html>