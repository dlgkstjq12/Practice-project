<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script type="text/javascript">


var amount = 0;


var InsertCode = new Array();


$(function () {
	
	//수정 (코드번호로)
    $('.btnUpdate').click (function () {
    	
    	
    	var num = "${map.num}";

    	var updateCode = new Array();
    	
    	var $checkbox = $("input[name=size]:checked").parent('.decode').parent('.detail_info_H')find('.decode'));
    	
    	alert($checkbox);
    	
    	console.log($checkbox);
    	
 		
    	/* input[name=size]:checked */
    	
    	$("input[name=size]:checked").each(function(i){
    		
    		var decodeH = $(this).val();
    		
    		var decode = decodeH.replace("/",""); //쓰레기값 제거
    		
    		   		
    	/* 	$("input[name=size]:checked").remove();  */
    		

     		/* $("input[name=size]:checked").replaceWith($('<div style=\"width: 110px; float: left;\"><input type = checkbox , name=size , value= ${nRow.DECODE }/></div>'));   */ 
    			    		
     		
    		$checkbox.replaceWith($('<input type = text , name = decode , style=\"width: 100px; float: left;\">')); 
     		
    		$("input[name=size]:checked [name=decode_name]").replaceWith($('<input type = text , name = decode_name , style=\"width: 70px; float: left;\">'));
    		
    		$("input[name=size]:checked[name=use_yn]").replaceWith($('<input type= radio , name = use_yn , value = Y , checked = checked /> <span class = Y >Y</span>&nbsp;&nbsp; <input type = radio , name = use_yn , value = N /> <span class = N >N</span>'));
    		
    		var decode_nameH = $("#decode_name").val();
    			
    		var use_ynH = $("#use_yn").val();
    		
    		i++;
    		
    		return i;
    		
    		
    		});
     	
    	
	
    });
	
	
	
	
	
	
	

	
	//삭제 (코드번호로)
    $('.btnDelete').click (function () { 
    	
    	var num = "${map.num}";

    	var deleteCode = new Array();
 		
    	$("input[name=size]:checked").each(function(i){
    		
    		var decodeH = $(this).val();
    		
    		var decode = decodeH.replace("/",""); //쓰레기값 제거
    		
    		deleteCode[i] = {"decode" : decode};
    		
    		})
     	
    		var deleteTotalCode = JSON.stringify(deleteCode);
    		
    		
    		//배열을 넘겨주기위해 세팅값 변경
    	 	jQuery.ajaxSettings.traditional = true;
    		
    	 	
    	 	$.ajax({ 

    	    			   url : "./commonCodeDelete.ino?num="+num,
    						
    	    			  type: "POST",   
    	    			  
    	    			   data : deleteTotalCode,
    	    	
    	    			  traditional : true, 

    	    				dataType : "json",  
    	    			  
    	    			  contentType: "application/json; charset=utf-8;",

    	    			   success : function(data){
    	    				         				   
    	    				   console.log(data);
    	    				   
    	    				   $('#detail_info').empty(); 
    	    				   
    	    				   $('#detail').empty();
    	    				   
    	    				   $.each(data, function(i) {
    	    					   
    	    					    $('#detail').append("<div style=\"width: 110px; float: left;\"><input type='checkbox' id = 'size' name='size' value= data[i].DECODE /></div>");

    				        		$('#detail').append("<div style=\"width: 100px; float: left;\">" + data[i].CODE + "</div>");
    	   					     
    				        		$('#detail').append("<div style=\"width: 170px; float: left;\">" + data[i].DECODE + "</div>");
    	    					     
    				        		$('#detail').append("<div style=\"width: 110px; float: left;\">" + data[i].DECODE_NAME + "</div>");
    	    					     
    				        		$('#detail').append("<div style=\"width: 130px; float: right;\">" + data[i].USE_YN + "</div>");
    	    					     
    				        		$('#detail').append("<hr style=\"width: 600px; float:center;\">"); 
    	    				   
    	    				   });
    	    				   
    	    				   
    	    			   }

    		});
	
    });
	
	//추가
    $('.btnAdd').click (function () {   
    	
    	/* var InsertCodeForm = ""; */
    	
    	var num = "${map.num}";
    	
    	 var $form = $('<form name = "InsertCode'+amount+'", id = "InsertCode'+amount+'"></form>');
    	 var num = $('<div style=\"width: 250px; float: left;\"><input type = hidden , name = num , value = ${map.num} >${map.num}</div>');
         var decode = $('<div style=\"width: 150px; float: left;\"><input type = text , name = decode , style=\"width: 100px; float: left;\"></div>');
         var decode_name = $('<div style=\"width: 100px; float: left;\"><input type = text , name = decode_name , style=\"width: 70px; float: left;\"></div>');
         var use_yn = $('<div style=\"width: 100px; float: left;\"><input type= radio , name = use_yn , value = Y , checked=checked /> <span class = Y >Y</span>&nbsp;&nbsp; <input type = radio , name= use_yn , value = N /> <span class = N >N</span></div>');
         var hr = $('<hr style=\"width: 600px; float:center;\">');
    	   
    	$form.appendTo('#detail');
    	
    	$form.append(num).append(decode).append(decode_name).append(use_yn).append(hr); 

    	amount++;
	    		 
	    		
    	return amount;
	    		
    	});
    
    
    //저장
 	$('.btnInsert').click (function () {
 		
 		var totalInsert = new Array();
 		
 	for(var i = 0; i < amount; i++){
 		
 			var num = $('#InsertCode'+i+' input[name=num]').val();
		 
			var decode = $('#InsertCode'+i+' input[name=decode]').val();
			
			var decode_name = $('#InsertCode'+i+' input[name=decode_name]').val();
			
			var use_yn = $('#InsertCode'+i+' input[name=use_yn]').val();
		
 			totalInsert[i] = {"num" : num, "decode" : decode, "decode_name" : decode_name, "use_yn" : use_yn};		
 	}
 	
 	var String = new Array();
 	
 	var String = JSON.stringify(totalInsert); 
 	
 	console.log("String" +String);
 	
 	

 	//배열을 넘겨주기위해 세팅값 변경
 	jQuery.ajaxSettings.traditional = true;
 	
 	$.ajax({ 

    			   url : "./commonCodeInsert.ino",
					
    			  type: "POST",   
    			  
    			   data : String,
    	
    			  traditional : true, 

    				dataType : "json",  
    			  
    			  contentType: "application/json; charset=utf-8;",
    			   
    		/* 	   contentType : false,
    			  
    			   processData : false,  */

    			   success : function(data){
    				     				 	
			        		$('#detail').empty(); 
	  
			        $.each(data, function(i) {
			        	
			        		$('#detail').append("<div style=\"width: 110px; float: left;\"><input type='checkbox' id = 'size' name='size' value= ${nRow.DECODE }/></div>");
			        
			        		$('#detail').append("<div style=\"width: 100px; float: left;\">" + data[i].num + "</div>");
   					     
			        		$('#detail').append("<div style=\"width: 170px; float: left;\">" + data[i].decode + "</div>");
    					     
			        		$('#detail').append("<div style=\"width: 110px; float: left;\">" + data[i].decode_name + "</div>");
    					     
			        		$('#detail').append("<div style=\"width: 130px; float: left;\">" + data[i].use_yn + "</div>");
    					     
			        		$('#detail').append("<hr style=\"width: 600px; float:center;\">"); 
			        		
			        		
							amount = 0;
					        
					        return amount;
			        		
			        	})
			        	
			     
			        	/* i = 0; */
			        		

    			   }

    			}); 
 	

 	
    	});
    

});

	</script>


<body>


	<div>
		<h1>공통코드 Detail ( ${map.num} ) </h1>
	</div>
	
	
	<div style="width:600px;" align="right">
	
	 <input type = "button" class = "btnAdd" name = "btnAdd" id = "btnAdd" value = "추가"  />
	 
	 <button type="button" class = "btnDelete" name = "btnDelete" id = "btnDelete" value = "btnDelete" >삭제</button>
	 
	 <button type="button" class = "btnUpdate" name = "btnUpdate" id = "btnUpdate" value = "btnUpdate" >수정</button>
		
	 <button type="button" class = "btnInsert" name = "btnInsert" id = "btnInsert" value = "btnInsert" >저장</button>
	 
	 
	 
	 
	</div>

	<hr style="width: 600px">
	<table style="width: 600px">
		<tr>
			<th style = "width: 50px" align="center">분류 </th>
			<th align="center" style = "width: 150px">master 코드</th>
			<th style = " width: 150px" align="center">코드</th>
			<th style = "width: 150px" align="left">코드명</th>
			<th style = "width: 70px" align="left">사용유무 </th>
			
		</tr>

	</table>
	
	<div style = "width: 600:px;" class = "detail_info" id = "detail_info" name = "detail_info" >
	<c:forEach var="nRow" items="${map.list}">
	<div class = "detail_info_H" id = "detail_info_H" name = "detail_info_H" >
		<div style="width: 110px; float: left;"><input type='checkbox' id = "size" name='size' value= ${nRow.DECODE }/></div>
		<div style="width: 100px; float: left;"><input type='hidden'  name='num' value = ${map.num} />${map.num}</div>
		<div class = "decode" style="width: 170px; float: left;">asdasdz<input type='hidden'  name='decode' value = ${nRow.DECODE } />${nRow.DECODE }</div>
			<div class = "decode_name" style="width: 110px; float: left;"><input type='hidden'  name='decode_name' value = ${nRow.DECODE_NAME } />${nRow.DECODE_NAME }</div>
			<div class = "use_yn" style="width: 130px; float: left;"><input type='hidden'  name='use_yn' value = ${nRow.USE_YN } />${nRow.USE_YN }</div>
		<hr style="width: 600px">
		</div>
	</c:forEach>
	</div>
	
	
	<div style = "width: 600:px;" id = "detail" name = "detail" ></div>


</body>

</html>