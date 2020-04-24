<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>    
<meta name="viewport" content="width=device-width, initial-scale=1">
 
 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
 
<script>


// html dom 이 다 로딩된 후 실행된다.
$(document).ready(function(){

    // memu 클래스 바로 하위에 있는 a 태그를 클릭했을때
    $(".menu>a").click(function(){
        // 현재 클릭한 태그가 a 이기 때문에
        // a 옆의 태그중 ul 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
        $(this).next("a").next("ul").toggleClass("hide");
        
        $(this).next("a").next("ul").next("ul").toggleClass("hide");
    
         	 if($(this).next("a").next("ul").css("display") == "none"){
		 
         		 if($(this).next("a").next("ul").children(".menu").children("ul").css("display") != "none"){
         			 
         			 
         			$(this).next("a").next("ul").children(".menu").children("ul").toggleClass("hide");
         		 }
         		 
         		 if($(this).next("a").next("ul").children(".menu").next("li").children("ul").css("display") != "none"){
         			 
         			 
         			$(this).next("a").next("ul").children(".menu").next("li").children("ul").toggleClass("hide");


         		 }

        	}
 
    });
    
    
})
</script>   
 
 <style>

.menu a{cursor:pointer;}
  
.menu .hide{display:none;}

</style>
 

</head>
<body>


	<c:if test="${sessionScope.user_id!=null}">
		<span style="color: black; font-weight: bold;">${sessionScope.user_id}님이<br>
			로그인 하셨습니다.
		</span>
		<br>
		<br>
		<form action="./memberlogout.ino" method="post">
			<button type="submit" name="submit" class="btn btn-primary">로그아웃</button>
		</form>
		<br>
		<br>


<!-- //변수를 활용해서 if문을 한번만 실행하게 함-->

		<!--  //로그인을 했을 경우 출력 되는 부분 -->
		<!-- OBJECTID값에 따라 출력하는 부분들이 다름 -->
		<div>
			<ul>
			<li class="menu">
			<a>메인</a><a href="./main.ino">(이동)</a>	
			<ul>
				<c:forEach var="nRow1" items="${sessionScope.id_authoritylist}">
					<c:forEach var="nRow2" items="${sessionScope.id_authoritylist}">							 
							<c:if test="${nRow1.DEPT == '2' and nRow1.OBJECTID==nRow2.OBJECTID}">	
										<li class="menu">
										<a>${nRow1.OBJECTNM }</a><a href="${nRow1.OBJECTID}.ino">(이동)</a>
										<c:forEach var="nRow3" items="${sessionScope.id_authoritylist}">
											<c:if test="${nRow3.DEPT == '3' and nRow3.HIGH_OBJ==nRow1.OBJECTID}">
												
												<c:choose>
												<c:when test="${nRow3.HIGH_OBJ == 'OBJ110'}">
												<ul>
												
												<li value = "${nRow3.OBJECTID }"><a value = "${nRow3.OBJECTID }">${nRow3.OBJECTNM }</a><a href="${nRow3.OBJECTID }.ino">(이동)</a></li>
												
												</ul>
												
												</c:when>
												
												<c:otherwise>	
												<ul class="hide">
												
												<li value = "${nRow3.OBJECTID }"><a value = "${nRow3.OBJECTID }">${nRow3.OBJECTNM }</a><a href="${nRow3.OBJECTID }.ino">(이동)</a></li>
												
												</ul>
												</c:otherwise>
												</c:choose>					

											</c:if>
										</c:forEach>
									</li>
								</c:if>
						</c:forEach>
					</c:forEach>
					</ul>
				</li>
			</ul>
		</div>
		
		
		
	</c:if>

	<br><br><br><br>

	<c:if test="${sessionScope.user_id==null}">
	<ul>
		<li><a href="memberloginpage.ino">로그인</a></li>
	</ul>
	
</c:if>


</body>


</html>