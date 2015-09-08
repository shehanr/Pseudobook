<%@page import="cpsc.ooad.team.awesome.*"%>

<%
	Integer id = Integer.parseInt(request.getParameter("id"));
	UserRepository allUsers = UserRepository.instance();
	User currentUser = (User) session.getAttribute("logged");
	String time = request.getParameter("time");

	allUsers.getUser(id).deleteWallPost(time);
	
	response.sendRedirect("profile.jsp?id="+id);
%>
