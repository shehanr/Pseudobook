<%@page import="cpsc.ooad.team.awesome.*"%>

<%
	Integer id = Integer.parseInt(request.getParameter("id"));
	UserRepository allGroups = UserRepository.instance();
	User currentUser = (User) session.getAttribute("logged");
	String time = request.getParameter("time");

	allGroups.getGroup(id).deleteWallPost(time);
	
	response.sendRedirect("group.jsp?id="+id);
%>
