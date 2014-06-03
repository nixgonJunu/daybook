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
	String subject = daybook.getSubject();
	String content = daybook.getContent();
	
	String chkForgot = "";
	String chkSunny = "";
	String chkRainy = "";
	String chkCloudy = "";
	String chkSnowy = "";
	
	if (weather.equals( "Sunny" )) {
		chkSunny = "checked='checked'";
	} else if (weather.equals( "Rainy" )) {
		chkRainy = "checked";
	} else if (weather.equals( "Cloudy" )) {
		chkCloudy = "checked";
	} else if (weather.equals( "Snowy" )) {
		chkSnowy = "checked";
	} else {
		chkForgot = "checked";
	}
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="../css/day_write.css">
<title><%=nickname %>'s Daybook - Day Modifying</title>
<script type="text/javascript">
<!--
function checkRadio() {
	document.getElementById('weather'.concat('<%= weather %>')).checked = true;
}
//-->
</script>
</head>
<body onload="checkRadio()">
	<div class="main_container">
	<form method="post" action="./<%= date %>">
		<h1><%= year %> / <%= month %> / <%= day %></h1>
		<input type="hidden" name="author" id="author" value="<%= daybook.getAuthor() %>" />
		<input type="hidden" name="key" id="key" value="<%= KeyFactory.keyToString( daybook.getKey() ) %>" />
		<input type="submit" title="Modify" value="Modify" />
		<input type="submit" formaction="../day_page" title="Cancel" value="Cancel" /><br>
		<div class="weather">
			<input type="radio" class="weather_radio" id="weatherForgot" name="weather" value="Don't Remember" />Don't Remember
			<input type="radio" class="weather_radio" id="weatherSunny" name="weather" value="Sunny" />Sunny
			<input type="radio" class="weather_radio" id="weatherRainy" name="weather" value="Rainy" />Rainy
			<input type="radio" class="weather_radio" id="weatherCloudy" name="weather" value="Cloudy" />Cloudy
			<input type="radio" class="weather_radio" id="weatherSnowy" name="weather" value="Snowy" />Snowy
		</div>
		<textarea class="subject" name="subject" id="subject" rows="1" maxlength="80" ><%= subject %></textarea><br>
		<textarea class="content" name="content" id="content" maxlength="2000" ><%= content %></textarea>
	</form>
	</div>
</body>
</html>