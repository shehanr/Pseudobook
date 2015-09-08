<%@page import="cpsc.ooad.team.awesome.*" %>

<%
	String groupName = request.getParameter("groupName");
	String groupDesc = request.getParameter("groupDesc");
	User currentUser = (User) session.getAttribute("logged");
	UserRepository allGroups = UserRepository.instance();

	allGroups.createNewGroup(currentUser, groupDesc, groupName);
	currentUser.addGroup(allGroups.getGroup(allGroups.getID(groupName)));
	response.sendRedirect("group.jsp?id=" + allGroups.getID(groupName));
%>
