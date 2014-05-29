<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<!DOCTYPE html>
<%
	UserService userService = UserServiceFactory.getUserService();
	String nickname = (String) request.getAttribute( "nickname" );
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=nickname%>'s Daybook - Day page</title>
</head>
<body>
	Welcome,
	<%=nickname%>
	<a href="<%=userService.createLogoutURL( "../login" )%>"> LogOut </a>
</body>
</html>