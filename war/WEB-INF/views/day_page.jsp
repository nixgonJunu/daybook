<%@page import="nixgon.daybook.model.Daybook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String logout_url = (String) request.getAttribute( "logout_url" );
	String nickname = (String) request.getAttribute( "nickname" );
	String today = (String) request.getAttribute( "today" );
	String yesterday = (String) request.getAttribute( "yesterday" );

	String todayYear = today.substring( 0, 4 );
	String todayMonth = today.substring( 4, 6 );
	String todayDay = today.substring( 6, 8 );

	String yesterdayYear = yesterday.substring( 0, 4 );
	String yesterdayMonth = yesterday.substring( 4, 6 );
	String yesterdayDay = yesterday.substring( 6, 8 );

	Daybook todayDaybook = (Daybook) request.getAttribute( "todayDaybook" );
	Daybook yesterdayDaybook = (Daybook) request.getAttribute( "yesterdayDaybook" );
	
	String todayWeather = "";
	String todaySubject = "";
	String todayContent = "";

	String yesterdayWeather = "";
	String yesterdaySubject = "";
	String yesterdayContent = "";
	
	if (todayDaybook != null) {
		todayWeather = todayDaybook.getWeather();
		todaySubject = todayDaybook.getSubject();
		todayContent = todayDaybook.getContent();
	}
	
	if (yesterdayDaybook != null) {
		yesterdayWeather = yesterdayDaybook.getWeather();
		yesterdaySubject = yesterdayDaybook.getSubject();
		yesterdayContent = yesterdayDaybook.getContent();
	}
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/day_page.css">
<title><%=nickname%>'s Daybook - Day page</title>
</head>
<body>
	Welcome,
	<%=nickname%>
	<a href='<%=logout_url%>'> LogOut </a><br>
	<div class="main_container">
		<form method="get">
		<div class="left_page">
			<input type="submit" formaction="day_write/<%= yesterday %>" value="Go to post" />
			<div class="content" id="date"><h3>Date, <%= yesterdayYear %> / <%= yesterdayMonth %> / <%= yesterdayDay %></h3></div>
			<div class="content" id="weather"><h3>Weather, <%= yesterdayWeather %></h3></div>
			<div class="content" id="subject"><h3>Subject, <%= yesterdaySubject %></h3></div>
			<div class="content" id="content"> <%= yesterdayContent %></div>
		</div>
		<div class="right_page">
			<input type="submit" formaction="day_write/<%= today %>" value="Go to post" />
			<div class="content" id="date"><h3>Date, <%= todayYear %> / <%= todayMonth %> / <%= todayDay %></h3></div>
			<div class="content" id="weather"><h3>Weather, <%= todayWeather %></h3></div>
			<div class="content" id="subject"><h3>Subject, <%= todaySubject %></h3></div>
			<div class="content" id="content"><%= todayContent %></div>
		</div>
		</form>
	</div>
</body>
</html>