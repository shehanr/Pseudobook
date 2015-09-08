<%@page import="cpsc.ooad.team.awesome.*" %>
<%
	User currentUser = (User) session.getAttribute("logged");
	UserRepository allUsers = UserRepository.instance();
	String decision = request.getParameter("submit");
	String id = request.getParameter("id");
	Integer pendid = Integer.parseInt(request.getParameter("pendid"));
	String myMess = "	I am now friends with <a href='profile.jsp?id=" + pendid + "'>" + allUsers.getUser(pendid).getBasicInformation().getFirstName() + " " +allUsers.getUser(pendid).getBasicInformation().getLastName() + "</a>";
	String uMess = "	I am now friends with <a href='profile.jsp?id=" + id + "'>" + currentUser.getBasicInformation().getFirstName() + " " +currentUser.getBasicInformation().getLastName() + "</a>";

	if(decision.equals("add")){
		currentUser.addFriend(allUsers.getUser(pendid));
		currentUser.removePendingFriend(allUsers.getUser(pendid));
		allUsers.getUser(pendid).addFriend(currentUser);
		currentUser.addWallPost(currentUser, myMess);
		allUsers.getUser(pendid).addWallPost(allUsers.getUser(pendid), uMess);
	}
	if(decision.equals("remove")){
		currentUser.removePendingFriend(allUsers.getUser(pendid));
	}

	response.sendRedirect("profile.jsp?id="+id);
%>
