<%@page import="cpsc.ooad.team.awesome.*"%>

<%
	Integer id = Integer.parseInt(request.getParameter("id"));
	UserRepository allUsers = UserRepository.instance();
	User currentUser = (User) session.getAttribute("logged");
	String wallpost = request.getParameter("wallpost");

	if(wallpost != ""){
		allUsers.getUser(id).addWallPost(currentUser, wallpost);
	}
	response.sendRedirect("profile.jsp?id="+id);
%>
