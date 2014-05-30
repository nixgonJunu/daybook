<%@page import="nixgon.daybook.model.Daybook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String logout_url = (String) request.getAttribute( "logout_url" );
	String nickname = (String) request.getAttribute( "nickname" );
	String today = (String) request.getAttribute( "today" );
	String yesterday = (String) request.getAttribute( "yesterday" );

	String today_year = today.substring( 0, 4 );
	String today_month = today.substring( 4, 6 );
	String today_day = today.substring( 6, 8 );

	String yesterday_year = yesterday.substring( 0, 4 );
	String yesterday_month = yesterday.substring( 4, 6 );
	String yesterday_day = yesterday.substring( 6, 8 );

	Daybook todayDaybook = (Daybook) request.getAttribute( "todayDaybook" );
	//Daybook yesterdayDaybook = (Daybook) request.getAttribute( "yesterdayDaybook" );
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
			<div class="content" id="date"><h3>Date, <%= today_year %> / <%= today_month %> / <%= today_day %></h3></div>
			<div class="content" id="weather"><h3>Weather, <%= yesterdayDaybook.getWeather() %></h3></div>
			<div class="content" id="title"><h3>Subject, <%= yesterdayDaybook.getSubject() %></h3></div>
			<div class="content" id="content"> <%= yesterdayDaybook.getContent() %></div>
		</div>
		<div class="right_page">
			<input type="submit" formaction="day_write/<%= today %>" value="Go to post" />
			<div class="content" id="date"><h3>Date, <%= yesterday_year %> / <%= yesterday_month %> / <%= yesterday_day %></h3></div>
			<div class="content" id="weather"><h3>Weather, <%= todayDaybook.getWeather() %></h3></div>
			<div class="content" id="title"><h3>Subject, <%= todayDaybook.getSubject() %></h3></div>
			<div class="content" id="content"><%= todayDaybook.getContent() %></div>
		</div>
		</form>
	</div>
</body>
</html>