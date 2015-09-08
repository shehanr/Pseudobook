<%@ page import="cpsc.ooad.team.awesome.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%
	User currentUser = (User) session.getAttribute("logged");
	UserRepository allUsers = UserRepository.instance();
        String id = String.valueOf(allUsers.getID(currentUser.getUsername()));
	MultipartRequest mpr = new MultipartRequest(request, "/home/bholster/public_html/profpics");

	String path = mpr.getOriginalFileName("file");
	currentUser.setProfilePicture(path, id);
	currentUser.addWallPost(currentUser,"<div style='text-align:center;position:relative;'>Uploaded a new profile picture!<br/><img src='http://rosemary.umw.edu/~bholster/profpics/"+id+"_pic.jpg' style='width:120px;height:125px;'></div>");	
	response.sendRedirect("profile.jsp?id=" + id);
%>
