<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="nixgon.daybook.model.Daybook"%>
<%@page import="com.google.appengine.api.datastore.Key"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
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
	Key todayKey = null;

	String yesterdayWeather = "";
	String yesterdaySubject = "";
	String yesterdayContent = "";
	Key yesterdayKey = null;
	
	String todayBtnMsg = "Write";
	String yesterdayBtnMsg = "Write";

	String redirectTodayURL = "day_write";
	String redirectYesterdayURL = "day_write";
	
	if (todayDaybook != null) {
		todayBtnMsg = "Modify";
		redirectTodayURL = "day_modify";
		
		todayWeather = todayDaybook.getWeather();
		todaySubject = todayDaybook.getSubject();
		todayContent = todayDaybook.getContent();
		todayKey = todayDaybook.getKey();
	}
	
	if (yesterdayDaybook != null) {
		yesterdayBtnMsg = "Modify";
		redirectYesterdayURL = "day_modify";
		
		yesterdayWeather = yesterdayDaybook.getWeather();
		yesterdaySubject = yesterdayDaybook.getSubject();
		yesterdayContent = yesterdayDaybook.getContent();
		yesterdayKey = yesterdayDaybook.getKey();
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
			<%
				if (yesterdayDaybook != null) {
			%>
			<input type="submit" formaction="erase/<%= KeyFactory.keyToString( yesterdayKey ) %>" formmethod="post" value="Erase" />
			<%
				}
			%>
			<input type="submit" formaction="<%= redirectYesterdayURL %>/<%= yesterday %>" value="<%= yesterdayBtnMsg %>" />
			<div class="content" id="date"><h3>Date, <%= yesterdayYear %> / <%= yesterdayMonth %> / <%= yesterdayDay %></h3></div>
			<div class="content" id="weather"><h3>Weather, <%= yesterdayWeather %></h3></div>
			<div class="content" id="subject"><h3>Subject, <%= yesterdaySubject %></h3></div>
			<div class="content" id="content"> <%= yesterdayContent %></div>
		</div>
		<div class="right_page">
			<%
				if (todayDaybook != null) {
			%>
			<input type="submit" formaction="erase/<%= KeyFactory.keyToString( todayKey ) %>" formmethod="post" value="Erase" />
			<%
				}
			%>
			<input type="submit" formaction="<%= redirectTodayURL %>/<%= today %>" value="<%= todayBtnMsg %>" />
			<div class="content" id="date"><h3>Date, <%= todayYear %> / <%= todayMonth %> / <%= todayDay %></h3></div>
			<div class="content" id="weather"><h3>Weather, <%= todayWeather %></h3></div>
			<div class="content" id="subject"><h3>Subject, <%= todaySubject %></h3></div>
			<div class="content" id="content"><%= todayContent %></div>
		</div>
		</form>
	</div>
</body>
</html>