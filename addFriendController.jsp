<%@page import="cpsc.ooad.team.awesome.*" %>

<%
	User currentUser = (User) session.getAttribute("logged");
	Integer userID = Integer.parseInt(request.getParameter("id"));
	UserRepository allUsers = UserRepository.instance();

	allUsers.getUser(userID).addPendingFriend(currentUser);

	response.sendRedirect("profile.jsp?id=" + userID);
%>


