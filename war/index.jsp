<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<!DOCTYPE HTML>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String logout_url = userService.createLogoutURL( "/" );
	String nickname = "";

	if ( user != null ) {
		nickname = user.getNickname();
		if ( nickname.indexOf( "@" ) > 0 ) {
			nickname = nickname.substring( 0, nickname.indexOf( "@" ) );
		}
	}
%>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Daybook</title>
  </head>
  <body style="text-align: center;">
    <h1>Daybook</h1>
    		<%
    			if ( user != null ) {
    		%>
		Welcome,
		<%= nickname %>
		<a href='<%= logout_url %>'> LogOut </a><br>
		<%
    			}
		%>
        <a href="login">시작하기</a>
  </body>
</html>
