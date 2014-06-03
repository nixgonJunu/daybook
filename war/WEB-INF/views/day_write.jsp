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
<title><%=nickname %>'s Daybook - Day Writing</title>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="main_container">
	<form method="post" action="./<%= date %>">
		<h1><%= year %> / <%= month %> / <%= day %></h1>
		<input type="hidden" name="author" id="author" value="<%= author %>" />
		<input type="submit" title="Write" value="Write" />
		<input type="submit" formaction="../day_page" title="Cancel" value="Cancel" /><br>
		<div class="weather">
			<input type="radio" class="weather_radio" name="weather" value="Don't Remember" checked="checked"/>Don't Remember
			<input type="radio" class="weather_radio" name="weather" value="Sunny" />Sunny
			<input type="radio" class="weather_radio" name="weather" value="Rainy" />Rainy
			<input type="radio" class="weather_radio" name="weather" value="Cloudy" />Cloudy
			<input type="radio" class="weather_radio" name="weather" value="Snowy" />Snowy
		</div>
		<textarea class="subject" name="subject" id="subject" rows="1" maxlength="80" placeholder="Subject"></textarea><br>
		<textarea class="content" name="content" id="content" maxlength="2000" placeholder="Content"></textarea>
	</form>
	</div>
</body>
</html>