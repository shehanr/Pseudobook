<%@page import="cpsc.ooad.team.awesome.*"%>

<%
	Integer id = Integer.parseInt(request.getParameter("id"));
	String groupName = request.getParameter("groupName");
	String groupDesc = request.getParameter("groupDesc");
	String website = request.getParameter("groupWeb");
	UserRepository allGroups = UserRepository.instance();
	Group groupPage = allGroups.getGroup(id);

	groupPage.setGroupName(groupName);
	groupPage.setGroupDescription(groupDesc);
	groupPage.getModerator().getBasicInformation().setEmail(website);

	response.sendRedirect("group.jsp?id=" + id);
%>
