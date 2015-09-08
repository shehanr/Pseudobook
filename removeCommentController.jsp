<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>

<%
	Integer id = Integer.parseInt(request.getParameter("id"));
	UserRepository allUsers = UserRepository.instance();
	String ctime = request.getParameter("ctime");
	String wptime = request.getParameter("wptime");
	SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
	User wallOwner = allUsers.getUser(id);
        ArrayList<WallPost> wallposts = wallOwner.getAllWallPost();

	for(int i=0;i<wallposts.size();i++){
                if(formatter.format(wallposts.get(i).getDate()).equals(wptime)){
			wallposts.get(i).removeComment(ctime);
		}
	}
	wallOwner.wallPostSave();
	response.sendRedirect("profile.jsp?id="+id);
%>
