<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
	SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
	String time = request.getParameter("time");
	String which = request.getParameter("submit");
	Integer id = Integer.parseInt(request.getParameter("id"));
	UserRepository allUsers = UserRepository.instance();
	User currentUser = (User) session.getAttribute("logged");
	User wallOwner = allUsers.getUser(id);
	ArrayList<WallPost> wallposts = wallOwner.getAllWallPost();

        for(int i=0;i<wallposts.size();i++){
                if(formatter.format(wallposts.get(i).getDate()).equals(time)){
                       if(which.equals("like")){
				wallposts.get(i).like(currentUser);
			}if(which.equals("dislike")){
				wallposts.get(i).dislike(currentUser);
			}
                }
	}
	wallOwner.wallPostSave();
	response.sendRedirect("profile.jsp?id="+ id);
%>
