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

	String todayYear = today.substring( 0, 4 );
	String todayMonth = today.substring( 4, 6 );
	String todayDay = today.substring( 6, 8 );

	Daybook todayDaybook = (Daybook) request.getAttribute( "todayDaybook" );
	
	Key todayKey = null;

	String todayBtnMsg = "쓰기";

	String redirectTodayURL = "day_write";
	String redirectTodayErase = "";
	
	if (todayDaybook != null) {
		todayBtnMsg = "수정하기";
		redirectTodayURL = "day_modify";
		
		todayKey = todayDaybook.getKey();
		redirectTodayErase = "erase/" + KeyFactory.keyToString( todayKey );
	}
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/day_page.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="./css/bootstrap.min.css" rel="stylesheet" media="screen">
<title><%=nickname%>'s Daybook - Day page</title>
<script>
<!-- 
function confirmErase() {
	var r = window.confirm("일기를 지우시겠습니까?");
	
	if (r == true) {
		document.eraseForm.submit();
	}
}
// -->
</script>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#"><%=nickname%> 의 일기</a>
        </div> 
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">오늘 일기</a></li>
            <li><a href="/last_page">지난 일기</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=nickname%><b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#"><%=author%></a></li>
                <li class="divider"></li>
                <li><a href="<%=logout_url%>">로그아웃</a></li>
              </ul>
            </li>
          </ul>
          <form method="post" name="eraseForm" action="<%= redirectTodayErase %>" class="navbar-form navbar-right">
			<input type="hidden" name="nickname" id="nickname" value="<%= nickname %>" />
			<input type="hidden" name="author" id="author" value="<%= author %>" />
			<input type="hidden" name="today" id="today" value="<%= today %>" />
			<%
				if ( todayDaybook != null ) {
			%>
			<input type="button" class="btn btn-danger" onclick="confirmErase()" value="지우기" />
			<%
				}
			%>
			<input type="submit" class="btn btn-success" formaction="<%= redirectTodayURL %>/today" value="<%= todayBtnMsg %>" />
          </form>
        </div>
      </div>
    </div>

    <div class="container">
	<div class="main_container">
		<div class="todayDaybook" id="todayDaybook">
			<div class="content" id="date"><h3><%= todayYear %> / <%= todayMonth %> / <%= todayDay %></h3></div>
			<%
				if ( todayDaybook != null ) {
			%>
			<div class="content" id="weather"><h3><%= todayDaybook.getWeather() %></h3></div>
			<div class="content" id="subject"><h3><%= todayDaybook.getSubject() %></h3></div>
			<div class="content"><textarea id="todayContent" disabled="disabled"><%= todayDaybook.getContent() %></textarea></div>
			<%
				} else {
			%>
			<div class="content" id="empty"><h3>일기가 없어요!</h3></div>
			<%
				}
			%>
		</div>
	</div>
    </div>
    
    <script src="./js/jquery.js"></script>
    <script src="./js/bootstrap.min.js"></script>
</body>
</html>