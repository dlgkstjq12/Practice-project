<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<!-- script 영역 -->
<script type="text/javascript">

var message = "${message}";

if(message != null && message != ""){
	
	alert(message);
}


</script>


</head>
<body>




<li>로그인</li>
<form action ="./memberlogin.ino" method = "post">
<br>
<input type = "text" name="user_id" style = "width:130px;" placeholder="  ID 입력 " class="form-control"><br><br>
<input type = "password" name="member_pass" style = "width:130px;" placeholder="  비밀번호 입력 " class="form-control"><br><br>
<button type = "submit" name = "submit">로그인</button>
</form>



</body>


</html>