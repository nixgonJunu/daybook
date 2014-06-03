<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="nixgon.daybook.model.Daybook"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<!DOCTYPE html>
<%
	String nickname = (String) request.getAttribute( "nickname" );
	String date = (String) request.getAttribute( "date" );
	String year = date.substring( 0, 4 );
	String month = date.substring( 4, 6 );
	String day = date.substring( 6, 8 );

	Daybook daybook = (Daybook) request.getAttribute( "Daybook" );	
	
	String weather = daybook.getWeather();
	
	String englishWeather = "";
	
	if (weather.equals( "맑았음" )) {
		englishWeather = "Sunny";
	} else if (weather.equals( "비가 내렸음" )) {
		englishWeather = "Rainy";
	} else if (weather.equals( "흐렸음" )) {
		englishWeather = "Cloudy";
	} else if (weather.equals( "눈이 내렸음" )) {
		englishWeather = "Snowy";
	} else {
		englishWeather = "Forgot";
	}
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="../css/day_write.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
<title><%=nickname %>'s Daybook - Day Modifying</title>
<script type="text/javascript">
<!--
function confirmModify() {
	if ( $("textarea#subject").val() == "" ) {
		alert("제목을 입력해주세요.");
		
		return;
	}

	if ( $("textarea#content").val() == "" ) {
		alert("내용을 입력해주세요.");
		
		return;
	}
	
	document.modifyForm.submit();
}

function confirmCancel() {
	var r = window.confirm("수정을 취소하시겠습니까?");
	if ( r == true ) {
		document.modifyForm.action = "../day_page";
		document.modifyForm.submit();
	}
}
//-->
</script>
</head>
<body onload="javascript: document.getElementById('weather'.concat('<%= englishWeather %>')).checked = true;">
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">일기 수정하기</a>
        </div> 
        <div class="collapse navbar-collapse navbar-right">
		<form method="post" name="modifyForm" action="./<%= date %>" class="navbar-form">
		  <input type="hidden" name="author" id="author" value="<%= daybook.getAuthor() %>" />
		  <input type="hidden" name="key" id="key" value="<%= KeyFactory.keyToString( daybook.getKey() ) %>" />
		  <input type="button" class="btn btn-danger" title="Cancel" onclick="confirmCancel()" value="취소하기" />
		  <input type="button" class="btn btn-success" title="Modify" onclick="confirmModify()" value="수정하기" />
   		</form>
        </div>
      </div>
    </div>

    <div class="container">
	<div class="main_container">
		<h1><%= year %> / <%= month %> / <%= day %></h1>
		<div class="weather">
			<input type="radio" class="weather_radio" id="weatherForgot" name="weather" value="기억 안남" />기억 안남
			<input type="radio" class="weather_radio" id="weatherSunny" name="weather" value="맑았음" />맑았음
			<input type="radio" class="weather_radio" id="weatherRainy" name="weather" value="비가 내렸음" />비가 내렸음
			<input type="radio" class="weather_radio" id="weatherCloudy" name="weather" value="흐렸음" />흐렸음
			<input type="radio" class="weather_radio" id="weatherSnowy" name="weather" value="눈이 내렸음" />눈이 내렸음
		</div>
		<textarea class="subject" name="subject" id="subject" rows="1" maxlength="80" ><%= daybook.getSubject() %></textarea><br>
		<textarea class="content" name="content" id="content" maxlength="2000" ><%= daybook.getContent() %></textarea>
	</div>
	</div>
    
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</body>
</html>