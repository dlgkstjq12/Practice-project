<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<!-- script 영역 -->
<script type="text/javascript">
	//그룹아이디 눌렀을때 실행
	function checkRow(event) {

		var groupid = event;

		$
				.ajax({

					url : "./authorityCodeSearch.ino?groupid=" + groupid,

					traditional : true,

					dataType : "json",

					contentType : "application/json; charset=utf-8;",

					success : function(data) {

						$('#search_info').empty();

						datalength = data.searchlist.length;

						$
								.each(
										data.searchlist,
										function(i) {

											if (data.searchlist[i].JUDGMENT != null) {

												$("#search_info")
														.append(
																"<div style=\"width: 100px; float: left;\"><input type='checkbox' name='ckbox"+i+"' value = '"+ data.searchlist[i].OBJECTID +"' checked></div>");

												$("#search_info")
														.append(
																"<div style=\"width: 90px; float: left;\">사용중</div>");

												$("#search_info")
														.append(
																"<input type='hidden' name='ck"+i+"' value = 'check' \>");

											} else {

												$("#search_info")
														.append(
																"<div style=\"width: 100px; float: left;\"><input type='checkbox' name='ckbox"+i+"' value = '"+ data.searchlist[i].OBJECTID +"' ></div>");

												$("#search_info")
														.append(
																"<div style=\"width: 90px; float: left;\">미사용</div>");

											}

											$("#search_info")
													.append(
															"<div style=\"width: 120px; float: left;\">"
																	+ data.searchlist[i].OBJECTID
																	+ "</div>");

											$("#search_info")
													.append(
															"<div style=\"width: 120px; float: left;\">"
																	+ data.searchlist[i].HIGH_OBJ
																	+ "<input type='hidden' name='high_obj"+i+"' value = '"+data.searchlist[i].HIGH_OBJ+"' \></div>");

											$("#search_info")
													.append(
															"<div style=\"width: 70px; float: left;\">"
																	+ data.searchlist[i].OBJECTNM
																	+ "<input type='hidden' name='objectnm"+i+"' value = '"+data.searchlist[i].OBJECTNM+"' \></div>");

											$("#search_info")
													.append(
															"<div style=\"width: 110px; float: left;\">"
																	+ data.searchlist[i].DEPT
																	+ "<input type='hidden' name='dept"+i+"' value = '"+data.searchlist[i].DEPT+"' \></div>");

											$("#search_info")
													.append(
															"<input type='hidden' id = 'groupid' name='groupid' value = '"+ data.searchlist[i].GROUPID +"' \></div>");

											$("#search_info")
													.append(
															"<input type='hidden' name='dataLength' value = '"+ datalength +"' \></div>");

											$("#search_info")
													.append(
															"<hr style=\"width: 600px;\">");

										});

					}

				});

	};

	//저장 버튼 눌렀을때 실행
	function insertRow(event) {

		//m이 앞에 붙은건 매핑 테이블
		//o가 앞에 붙은건 오브젝트 테이블에서 가져온 값들

		var groupid = event; //그룹아이디

		var datalength = $("input[name=dataLength]").val(); //체크박스의 번호를 동적생성해야하므로 가져온 데이터의 개수만큼의 값을 설정한 변수

		var data = new Array(); //컨트롤러로 넘겨줄 data 배열

		//컨트롤러로 넘길 아이디와 이름, high_obj와 dept
		var checkid = new Array();

		var objectnm = new Array();

		var high_obj = new Array();

		var dept = new Array();

		//체크됬는지 안됬는지 판단하는 변수
		var judgment = new Array();

		for (var i = 0; i < datalength; i++) {

			//저장버튼 눌렀을때 data보내는 구문

			if ($('input:checkbox[name=ckbox' + i + ']').is(":checked") == true) {

				checkid[i] = $('input:checkbox[name=ckbox' + i + ']:checked')
						.val();

				objectnm[i] = $('input[name=objectnm' + i + ']').val();

				high_obj[i] = $('input[name=high_obj' + i + ']').val();

				dept[i] = $('input[name=dept' + i + ']').val();

				data[i] = {
					"groupid" : groupid,
					"checkid" : checkid[i],
					"objectnm" : objectnm[i],
					"high_obj" : high_obj[i],
					"dept" : dept[i]
				};

			} else {

				checkid[i] = "n";

				objectnm[i] = $('input[name=objectnm' + i + ']').val();

				high_obj[i] = $('input[name=high_obj' + i + ']').val();

				dept[i] = $('input[name=dept' + i + ']').val();

				data[i] = {
					"groupid" : groupid,
					"checkid" : checkid[i],
					"objectnm" : objectnm[i],
					"high_obj" : high_obj[i],
					"dept" : dept[i]
				};

			}
		}

		var savedata = JSON.stringify(data);

		//배열을 넘겨주기위해 세팅값 변경
		jQuery.ajaxSettings.traditional = true;

		$
				.ajax({

					url : "./authorityCodeSearchlistsave.ino",

					type : "POST",

					traditional : true,

					dataType : "json",

					contentType : "application/json;",

					data : savedata,

					success : function(data) {

						$('#search_info').empty();

						datalength = data.searchlist.length;

						alert(data.message); //컨트롤러에서 받은 message를 출력함

						$
								.each(
										data.searchlist,
										function(i) {

											if (data.searchlist[i].JUDGMENT != null) {

												$("#search_info")
														.append(
																"<div style=\"width: 100px; float: left;\"><input type='checkbox' name='ckbox"+i+"' value = '"+ data.searchlist[i].OBJECTID +"' checked></div>");

												$("#search_info")
														.append(
																"<div style=\"width: 90px; float: left;\">사용중</div>");

												$("#search_info")
														.append(
																"<input type='hidden' name='ck"+i+"' value = 'check' \>");

											} else {

												$("#search_info")
														.append(
																"<div style=\"width: 100px; float: left;\"><input type='checkbox' name='ckbox"+i+"' value = '"+ data.searchlist[i].OBJECTID +"' ></div>");

												$("#search_info")
														.append(
																"<div style=\"width: 90px; float: left;\">미사용</div>");

											}

											$("#search_info")
													.append(
															"<div style=\"width: 120px; float: left;\">"
																	+ data.searchlist[i].OBJECTID
																	+ "</div>");

											$("#search_info")
													.append(
															"<div style=\"width: 120px; float: left;\">"
																	+ data.searchlist[i].HIGH_OBJ
																	+ "<input type='hidden' name='high_obj"+i+"' value = '"+data.searchlist[i].HIGH_OBJ+"' \></div>");

											$("#search_info")
													.append(
															"<div style=\"width: 70px; float: left;\">"
																	+ data.searchlist[i].OBJECTNM
																	+ "<input type='hidden' name='objectnm"+i+"' value = '"+data.searchlist[i].OBJECTNM+"' \></div>");

											$("#search_info")
													.append(
															"<div style=\"width: 110px; float: left;\">"
																	+ data.searchlist[i].DEPT
																	+ "<input type='hidden' name='dept"+i+"' value = '"+data.searchlist[i].DEPT+"' \></div>");

											$("#search_info")
													.append(
															"<input type='hidden' id = 'groupid' name='groupid' value = '"+ data.searchlist[i].GROUPID +"' \></div>");

											$("#search_info")
													.append(
															"<input type='hidden' name='dataLength' value = '"+ datalength +"' \></div>");

											$("#search_info")
													.append(
															"<hr style=\"width: 600px;\">");

										});
					}
				});

	};
</script>


</head>
<body>
	<div>
		<h1>권한코드 Main</h1>
	</div>

	<br>
	<br>

	<div style="width: 400px; float: center;">
		<table id="tableId" style="width: 400px" align="center">
			<tr>
				<th>그룹ID</th>
				<th>그룹이름</th>
				<th>사용여부</th>

			</tr>
		</table>

		<c:forEach var="nRow" items="${map.grouplist}" varStatus="status">
			<form name="SearchForm">

				<div style="width: 400:px;" class="grouplist${status.count}"
					id="grouplist${status.count}" name="grouplist${status.count}">
					<div>
						<input type="button" value="${nRow.GROUPID }" name="btnSearch"
							style="width: 100px; float: left;"
							onClick="checkRow(this.form.btnSearch.value)"> <input
							type="hidden" name="groupid" value="${nRow.GROUPID }" /> <input
							type="hidden" name="count" value="${status.current}" />
					</div>
					<div style="width: 170px; float: left;">${nRow.GROUPNM }</div>
					<div style="width: 100px; float: left;">${nRow.USE_YN }</div>

				</div>
			</form>
		</c:forEach>

	</div>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<form name="save">
		<div style="width: 600px;" align="right">
			<div>
				<input type="button" value="저장" name="btninsert"
					style="width: 100px; float: right;"
					onClick="insertRow(document.getElementById('groupid').value)" />
			</div>
		</div>

		<table style="width: 600px" align="left">
			<tr>
				<th>체크박스</th>
				<th>사용여부</th>
				<th>객체ID</th>
				<th>상위객체ID</th>
				<th>객체이름</th>
				<th>DEPT</th>
			</tr>
		</table>

		<!-- 검색한 후에 가져올 값 -->
		<div style="width: 600:px;" class="search_info" id="search_info"
			name="search_info"></div>

	</form>

</body>
</html>