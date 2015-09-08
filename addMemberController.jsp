<%@page import="cpsc.ooad.team.awesome.*" %>

<%
	String[] memIDs = request.getParameterValues("members");
	Integer id = Integer.parseInt(request.getParameter("id"));
	UserRepository allGroups = UserRepository.instance();
	Group groupPage = allGroups.getGroup(id);

	for(int i=0;i<memIDs.length;i++){
		groupPage.addMember(allGroups.getUser(Integer.parseInt(memIDs[i])));
		allGroups.getUser(Integer.parseInt(memIDs[i])).addGroup(groupPage);
	}
	response.sendRedirect("group.jsp?id="+id);	
%>
