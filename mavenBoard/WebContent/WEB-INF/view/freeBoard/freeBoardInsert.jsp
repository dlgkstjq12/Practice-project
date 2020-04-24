<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

 <script type="text/javascript">

 $(function (){
		
	 $("#btnInsert").click(function(){
		 
		 if(confirm("글을 작성하시겠습니까?")){
			 
			 
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
						 url: "./freeBoardInsertPro.ino", //데이터를 보낼 url
						 type: "POST",
						 dataType:"json",
						 //contentType: "application/x-www-form-urlencoded; charset=MS949",
						 data: data, //보낼 데이터
					
					        
					        success : function(data){//데이터를 보내는 것이 성공했을 시 출력되는 메시지
					        
					        	if(data.result == "succes"){
					        		
					        		alert("글을 작성하였습니다.");
					        		
					        		location.href = "./main.ino";
									
					        		
					        	}else if(data.result == 'fail'){
					        		
					        		alert("글을 다시 작성해주시기 바랍니다.");

					        	}	        	
					        

					                }, error: function(errorThrown) {
					                	
					                    alert("통신이 실패했습니다.");
					                    
					                }
					                   
					
						});
				
			 		}
				
			 	}
	 		});
	 	
	 });
	  
	 	
	 </script>

<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">
	
	<form id="insertForm" name="insertForm" method="POST"  accept-charset="utf-8">
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id = "name" name="name"/></div>
		
		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id = "title" name="title"/></div>
	
		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea id = "content" name="content" rows="25" cols="65"  ></textarea></div>
		<div align="right">
		<button type="button" value="글쓰기" id = "btnInsert">글쓰기</button>
		<input type="button" value="다시쓰기" onclick="reset()">
		<input type="button" value="취소" onclick="">
		&nbsp;&nbsp;&nbsp;
		</div>
	
	</form>
	
	
	
</body>
</html>