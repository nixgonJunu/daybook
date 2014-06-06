<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String nickname = (String) request.getAttribute( "nickname" );
	String author = (String) request.getAttribute( "author" );
	String date = (String) request.getAttribute( "date" );
	String year = date.substring( 0, 4 );
	String month = date.substring( 4, 6 );
	String day = date.substring( 6, 8 );
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="../css/day_write.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=nickname %>'s Daybook - Day Writing</title>
<link href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
<script type="text/javascript">
<!-- 
function confirmWrite() {
	var weather = $("input[name=weather]").filter(":checked").val();
	var subject = $("textarea#subject").val();
	var content = $("textarea#content").val();
	
	if ( subject == "" ) {
		alert("제목을 입력해주세요.");
		
		return;
	}

	if ( content == "" ) {
		alert("내용을 입력해주세요.");
		
		return;
	}

	$("input#weather").val(weather);
	$("input#subject").val(subject);
	$("input#content").val(content);
	
	document.writeForm.submit();
}

function confirmCancel() {
	var r = window.confirm("일기를 지우시겠습니까?");
	if ( r == true ) {
		document.writeForm.action = "../day_page";
		document.writeForm.submit();
	}
}
// -->
</script>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">일기 수정하기</a>
        </div> 
        <div class="collapse navbar-collapse navbar-right">
		<form method="post" name="writeForm" action="./<%= date %>" class="navbar-form">
		  <input type="hidden" name="author" id="author" value="<%= author %>" />
		  <input type="button" class="btn btn-danger" title="Cancel" onclick="confirmCancel()" value="지우기" />
		  <input type="button" class="btn btn-success" title="Modify" onclick="confirmWrite()" value="쓰기" />
		  <input type="hidden" id="weather" name="weather" value="" />
		  <input type="hidden" id="subject" name="subject" value="" />
		  <input type="hidden" id="content" name="content" value="" />
   		</form>
        </div>
      </div>
    </div>
    
    <div class="container">
	<div class="main_container">
		<h1><%= year %> / <%= month %> / <%= day %></h1>
		<div class="weather">
			<input type="radio" class="weather_radio" name="weather" value="기억 안남" checked="checked"/>기억 안남
			<input type="radio" class="weather_radio" name="weather" value="맑았음" />맑았음
			<input type="radio" class="weather_radio" name="weather" value="비가 내렸음" />비가 내렸음
			<input type="radio" class="weather_radio" name="weather" value="흐렸음" />흐렸음
			<input type="radio" class="weather_radio" name="weather" value="눈이 내렸음" />눈이 내렸음
		</div>
		<textarea class="subject" name="subject" id="subject" rows="1" maxlength="80" placeholder="제목"></textarea><br>
		<textarea class="content" name="content" id="content" maxlength="2000" placeholder="내용"></textarea>
	</div>
	</div>
    
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</body>
</html>