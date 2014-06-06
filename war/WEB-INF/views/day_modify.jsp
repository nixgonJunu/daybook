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
	String redirect_url = (String) request.getAttribute( "redirect_url" );

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
<link type="text/css" rel="stylesheet" href="./css/day_write.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
<title><%=nickname %>'s Daybook - Day Modifying</title>
<script type="text/javascript">
<!--
function confirmModify() {
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
	
	document.modifyForm.submit();
}

function confirmCancel() {
	var r = window.confirm("수정을 취소하시겠습니까?");
	if ( r == true ) {
		document.modifyForm.action = "../<%= redirect_url %>";
		document.modifyForm.submit();
	}
}

function resize(obj) {
	obj.style.height = "1px";
	obj.style.height = (20+obj.scrollHeight)+"px";
}

window.onload = function() {
	resize($("textarea#content").get(0));
	document.getElementById('weather'.concat('<%= englishWeather %>')).checked = true;
}
//-->
</script>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">일기 수정하기</a>
        </div> 
        <div class="collapse navbar-collapse navbar-right">
		<form method="post" name="modifyForm" action="day_modify/<%= date %>" class="navbar-form">
		  <input type="hidden" name="author" id="author" value="<%= daybook.getAuthor() %>" />
		  <input type="hidden" name="key" id="key" value="<%= KeyFactory.keyToString( daybook.getKey() ) %>" />
		  <input type="button" class="btn btn-danger" title="Cancel" onclick="confirmCancel()" value="취소하기" />
		  <input type="button" class="btn btn-success" title="Modify" onclick="confirmModify()" value="수정하기" />
		  <input type="hidden" id="weather" name="weather" value="<%= daybook.getWeather() %>" />
		  <input type="hidden" id="subject" name="subject" value="<%= daybook.getSubject() %>" />
		  <input type="hidden" id="content" name="content" value="<%= daybook.getContent() %>" />
		  <input type="hidden" name="redirect_url" value="<%= redirect_url %>" />
   		</form>
        </div>
      </div>
    </div>

    <div class="container">
	<div class="main_container">
		<h1><%= year %> / <%= month %> / <%= day %></h1>
		<div class="weather">
			<h3>
			<input type="radio" class="weather_radio" id="weatherForgot" name="weather" value="기억 안남" />
			<label for="weather">기억 안남</label>
			<input type="radio" class="weather_radio" id="weatherSunny" name="weather" value="맑았음" />
			<label for="weather">맑았음</label>
			<input type="radio" class="weather_radio" id="weatherRainy" name="weather" value="비가 내렸음" />
			<label for="weather">비가 내렸음</label>
			<input type="radio" class="weather_radio" id="weatherCloudy" name="weather" value="흐렸음" />
			<label for="weather">흐렸음</label>
			<input type="radio" class="weather_radio" id="weatherSnowy" name="weather" value="눈이 내렸음" />
			<label for="weather">눈이 내렸음</label>
			</h3>
		</div>
		<textarea class="subject" name="subject" id="subject" rows="1" maxlength="80" ><%= daybook.getSubject() %></textarea><br>
		<textarea class="content" name="content" id="content" maxlength="2000" onkeyup="resize(this)"><%= daybook.getContent() %></textarea>
	</div>
	</div>
    
    <script src="./js/jquery.js"></script>
    <script src="./js/bootstrap.min.js"></script>
</body>
</html>