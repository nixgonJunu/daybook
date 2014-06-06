<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="nixgon.daybook.model.Daybook"%>
<%@page import="com.google.appengine.api.datastore.Key"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<%
	String logout_url = (String) request.getAttribute( "logout_url" );
	String nickname = (String) request.getAttribute( "nickname" );
	String author = (String) request.getAttribute( "author" );

	List < Daybook > Daybooks = ( List < Daybook > ) request.getAttribute( "Daybooks" );
	int daybookSize = 0;
	
	if ( Daybooks != null ) {
		daybookSize = Integer.parseInt( (String) request.getAttribute( "DaybookSize" ) );
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

function resize(obj) {
	obj.style.height = "1px";
	obj.style.height = (20+obj.scrollHeight)+"px";
}

window.onload = function() {
	$("textarea#yesterdayContent").each(function() {
		resize($(this).get(0));
	});
}
// -->
</script>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="/day_page"><%=nickname%> 의 일기</a>
        </div> 
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="/day_page">오늘 일기</a></li>
            <li class="active"><a href="#">지난 일기</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=nickname%><b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#"><%=author%></a></li>
                <li class="divider"></li>
                <li><a href="<%=logout_url%>">로그아웃</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <div class="container">
	<div class="main_container">
		<%
		if ( Daybooks != null ) {
			for (Daybook d : Daybooks) {
				String year = d.getDate().substring( 0, 4 );
				String month = d.getDate().substring( 4, 6 );
				String day = d.getDate().substring( 6, 8 );
		%>
          		<form method="post" class="button_container" name="eraseForm" action="erase/<%= KeyFactory.keyToString( d.getKey() ) %>">
				<input type="button" class="btn btn-danger" onclick="confirmErase()" value="지우기" />
				<input type="submit" class="btn btn-success" formaction="day_modify" value="수정하기" />
				<input type="hidden" name="nickname" id="nickname" value="<%= nickname %>" />
				<input type="hidden" name="date" id="today" value="<%= d.getDate() %>" />
				<input type="hidden" name="author" id="author" value="<%= d.getAuthor() %>" />
				<input type="hidden" name="redirect_url" value="last_page" />
				<div class="yesterday_container">
				<div class="content" id="date"><h3><%= year %> / <%= month %> / <%= day %></h3></div>
				<div class="content" id="weather"><h3><%= d.getWeather() %></h3></div>
				<div class="content" id="subject"><h3><%= d.getSubject() %></h3></div>
				<div class="content"><textarea id="yesterdayContent" disabled="disabled"><%= d.getContent() %></textarea></div>
				</div>
				</form>
		<%
			}
		}
		%>
	</div>
    </div>
    
    <script src="./js/jquery.js"></script>
    <script src="./js/bootstrap.min.js"></script>
</body>
</html>