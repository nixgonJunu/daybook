<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="nixgon.daybook.model.Daybook"%>
<%@page import="com.google.appengine.api.datastore.Key"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<!DOCTYPE html>
<%
	String logout_url = (String) request.getAttribute( "logout_url" );
	String nickname = (String) request.getAttribute( "nickname" );
	String author = (String) request.getAttribute( "author" );
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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="./css/bootstrap.min.css" rel="stylesheet" media="screen">
<title><%=nickname%>'s Daybook - Day page</title>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#"><%=nickname%> 의 일기</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#todayDaybook">오늘 일기</a></li>
            <li><a href="#yesterdayDaybook">지난 일기</a></li>
            <li><a href="<%=logout_url%>">로그아웃</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <div class="form-group">
            </div>
            <div class="form-group">
            </div>
			<input type="submit" formaction="<%= redirectTodayURL %>/today" value="<%= todayBtnMsg %>" />
          </form>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">
	<div class="main_container">
		<form method="post">
		<input type="hidden" name="nickname" id="nickname" value="<%= nickname %>" />
		<input type="hidden" name="author" id="author" value="<%= author %>" />
		<div class="todayDaybook" id="todayDaybook">
			<%
				if (todayDaybook != null) {
			%>
			<input type="submit" formaction="erase/<%= KeyFactory.keyToString( todayKey ) %>" value="Erase" />
			<%
				}
			%>
			<input type="hidden" name="today" id="today" value="<%= today %>" />
			<div class="content" id="date"><h3><%= todayYear %> / <%= todayMonth %> / <%= todayDay %></h3></div>
			<div class="content" id="weather"><h3><%= todayWeather %></h3></div>
			<div class="content" id="subject"><h3><%= todaySubject %></h3></div>
			<div class="content"><textarea id="todayContent" disabled="disabled"><%= todayContent %></textarea></div>
		</div>
		<div class="yesterdayDaybook" id="yesterdayDaybook">
			<%
				if (yesterdayDaybook != null) {
			%>
			<input type="submit" formaction="erase/<%= KeyFactory.keyToString( yesterdayKey ) %>" value="Erase" />
			<%
				}
			%>
			<input type="submit" formaction="<%= redirectYesterdayURL %>/yesterday" value="<%= yesterdayBtnMsg %>" />
			<input type="hidden" name="yesterday" id="yesterday" value="<%= yesterday %>" />
			<div class="content" id="date"><h3><%= yesterdayYear %> / <%= yesterdayMonth %> / <%= yesterdayDay %></h3></div>
			<div class="content" id="weather"><h3><%= yesterdayWeather %></h3></div>
			<div class="content" id="subject"><h3><%= yesterdaySubject %></h3></div>
			<div class="content"><textarea id="yesterdayContent" disabled="disabled"><%= yesterdayContent %></textarea></div>
		</div>
		</form>
	</div>
    </div><!-- /.container -->
    
    <script src="./js/jquery.js"></script>
    <script src="./js/bootstrap.min.js"></script>
</body>
</html>