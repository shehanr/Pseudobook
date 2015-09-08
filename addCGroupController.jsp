<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
	SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
	String time = request.getParameter("wptime");
	Integer id = Integer.parseInt(request.getParameter("id"));
	UserRepository allGroups = UserRepository.instance();
	User currentUser = (User) session.getAttribute("logged");
	Group wallOwner = allGroups.getGroup(id);
	ArrayList<WallPost> wallposts = wallOwner.getWallPosts();
	String comment = request.getParameter("comment");

        for(int i=0;i<wallposts.size();i++){
                if(formatter.format(wallposts.get(i).getDate()).equals(time)){
                       wallposts.get(i).addComment(currentUser, comment);
                }
	}
	wallOwner.wallPostSave();
	response.sendRedirect("group.jsp?id="+ id);
%>
