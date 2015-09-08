<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.util.*"%>
<html>

<head>
<title>News Feed</title>
<link rel="stylesheet" type="text/css" href="layout.css">
</head>

<%
	User currentUser = (User) session.getAttribute("logged");
	UserRepository allUsers = UserRepository.instance();
	BasicInformation pageBasic = currentUser.getBasicInformation();
	ArrayList<User> friends = currentUser.getFriends();
	ArrayList<Group> groups = currentUser.getGroups();
	List<WallPost> allPosts = new ArrayList<WallPost>();
	ArrayList<Message> comments = null;
	ArrayList<WallPost> wallposts = currentUser.getAllWallPost();
	for(WallPost itr: currentUser.getAllWallPost()){
        	allPosts.add(itr);
        }
	for(int i=0;i<friends.size();i++){
		for(WallPost itr: friends.get(i).getAllWallPost()){
			allPosts.add(itr);
		}
	}
	Collections.sort(allPosts);
	Collections.reverse(allPosts);
%>

<body>
<div style="background-color:black">
<div class="container">
	<jsp:include page="news_menu.jsp"/>
	<div class="row">
  		<div class="col-md-3">
			 <ul class="list-group">
                                <%
                                out.println("<li class='list-group-item'><b>Groups <span class='badge'>"+groups.size()+"</span></b><br/>");
                                for(int i=0;i<groups.size();i++){
                                        out.println("<a href='group.jsp?id="+allUsers.getID(groups.get(i).getGroupName())+"'>");
                                        out.println("    " + groups.get(i).getGroupName() + "</a>");
                                }
                                out.println("</li>");
                                out.println("<li class='list-group-item'><b>Friends <span class='badge'>"+friends.size()+"</span></b><br/>");
                                        for(int i=0;i<friends.size();i++){
                                        out.println("<a href='profile.jsp?id=" + allUsers.getID(friends.get(i).getUsername()) + "' style='font-size:12px;'>");
                                        out.println("<img src='"+friends.get(i).getProfilePicture()+"' style='width:30px;height:30px;'>");
                                        out.println("    " + friends.get(i).getBasicInformation().getFirstName() + " " + friends.get(i).getBasicInformation().getLastName() + "</a>");
                                }%>
                                </li>
                        </ul>

  		</div>
		<div class="col-md-9">
		<%--
			<ul class="list-group">
  				<li class="list-group-item"><b>Group Information:</b>
				<%
					if(loggedPage){
				%>
                                <button class="btn btn-default btn-xs" style="position:relative;float:right;" data-toggle="modal" data-target="#editBasic">Edit Group Information</button>
				<%}%>
				</li>
				<li class="list-group-item" style="padding:5px 8px;">Moderator: <%out.println("<a href='profile.jsp?id="+ allUsers.getID(pageOwner.getUsername()) +"'>" + pageBasic.getFirstName() + " " + pageBasic.getLastName()+"</a>");%></li>
  				<li class="list-group-item" style="padding:5px 8px;">Group Name: <%out.println(groupPage.getGroupName());%></li>
  				<li class="list-group-item" style="padding:5px 8px;">Group Description: <%out.println(groupPage.getGroupDescription());%></li>
			</ul>
			<div class="modal fade" id="editBasic" tabindex="-1" role="dialog" aria-labelledby="basicLabel" aria-hidden="true">
                        <div class="modal-dialog modal-sm">
                                <div class="modal-content">
                                        <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                <h4 class="modal-title" id="basicLabel">Edit Group Information</h4>
                                        </div>
                                        <div class="modal-body">
                                                <form action="groupInfoController.jsp" method="POST" role="form" id="editGroup">
							<%out.println("<input type='hidden' name='id' value='"+ id + "'>");%>
                                                        <%out.println("Group Name:<br/><input type='text' name='groupName' value='" + groupPage.getGroupName() + "'><br/>");%>
							<%out.println("Group Description:<textarea style='resize:none;' rows='6' cols='38' name='groupDesc' form='editGroup'>"+groupPage.getGroupDescription()+"</textarea>");%>
                                        </div>
                                        <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary btn-sm">Save Changes</button>
                                                </form>
                                        </div>
                                </div>
                        </div>
                	</div>--%>
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<form role="form" method="POST" action="addWPNewsController.jsp">
				<%out.println("<input type='hidden' name='id' value='" + allUsers.getID(currentUser.getUsername()) + "'>");%>
				<div class="input-group">
      					<input type="text" class="form-control" name="wallpost" placeholder="Enter a status...">
      					<span class="input-group-btn">
        				<button class="btn btn-default" type="submit">Post</button>
      					</span>
    				</div>
				</form>
				<div class="panel-group" id="accordion" style="margin-top:20px;">
				<%
					User author = null;
					int i=0;
					for(WallPost w: allPosts){
						author = w.getAuthor();
  						out.println("<div class='panel panel-default'>");
    						out.println("<div class=panel-heading>");
      						out.println("<h4 class=panel-title>");

                                        	out.println("<a href='profile.jsp?id="+allUsers.getID(author.getUsername())+"' style=color:#428bca;font-size:12px;>"+author.getBasicInformation().getFirstName()+" "+author.getBasicInformation().getLastName()+"</a>");
						if(currentUser==author){
						out.println("<form role=form method=POST class=close style=opacity:1; action='deleteWPNewsController.jsp'><input type=hidden name=time value='" + w.getDate() + "'><input type=hidden name=id value='" + allUsers.getID(author.getUsername()) + "'><button type=submit class=close>&times;</button></form>");}
						out.println("<br/><p class='date' style='margin:0;padding:0;'>"+w.getDate()+"</p>");
                                        	out.println("<p style='margin:0;padding:0;margin-left:10%;margin-bottom:5px;'>"+w.getMessage()+"</p>");
						out.println("<form role=form method=POST action='likeNewsController.jsp' style=display:inline;><div class='btn-group btn-group-xs' style='position:relative;float:right;margin-left:10px;'><input type='hidden' name='time' value='"+w.getDate()+"'><input type='hidden' name='id' value='"+ allUsers.getID(author.getUsername())+"'><button type='submit' name='submit' value='like' class='btn btn-default'><span class='glyphicon glyphicon-thumbs-up'>"+w.getLikes().size()+"</span></button><button type='submit' name='submit' value='dislike' class='btn btn-default'><span class='glyphicon glyphicon-thumbs-down'>"+w.getDislikes().size()+"</span></button></div></form>");
						out.println("<a data-toggle=collapse data-parent=#accordion href=#collapse" + (i+1) + " style='font-size:12px;' class='collapsed'>");
          					out.println("<p class='text-right' style='margin:0;padding:0;color:#428bca;'>Comments("+w.getComments().size()+")</p></a></h4></div>");
    						out.println("<div id=collapse" + (i+1) + " " + "class='panel-collapse collapse'>");
      						out.println("<div class=panel-body>");
        					out.println("<ul style=list-style-type:none;margin-top:-10px;margin-bottom:-20px;>");

						comments = w.getComments();
						for(int j=0; j<comments.size(); j++){
							User cauth = comments.get(j).getAuthor();
                                        		out.println("<li><a href=profile.jsp?id="+allUsers.getID(cauth.getUsername())+" style=font-size:12px;>"+cauth.getBasicInformation().getFirstName()+" "+cauth.getBasicInformation().getLastName()+"</a> "+comments.get(j).getMessage());
							if(currentUser==cauth){
							out.println("<form role=form method=POST class=close style='opacity:1;margin-bottom:-5px;' action='removeCNewsController.jsp'><input type='hidden' name='wptime' value='"+w.getDate()+"'><input type='hidden' name='ctime' value='"+comments.get(j).getDate()+"'><input type=hidden name=id value="+allUsers.getID(author.getUsername())+"><button type=submit class=close>&times;</button></form>");}
                                                	out.println("</li><li class=date>"+comments.get(j).getDate()+"</li>");
						}
                                                out.println("<li><form role=form method=POST action='addCNewsController.jsp'><input type=hidden name=wptime value='"+w.getDate()+"'><input type='hidden' name='id' value='"+allUsers.getID(author.getUsername())+"'><div class='input-group comm'>");
                                                out.println("<input type=text class=form-control name='comment' placeholder='Enter a comment...'>");
                                                out.println("<span class=input-group-btn>");
                                                out.println("<button class='btn btn-default' type=submit>Post</button></span>");
                                                out.println("</div></form></li>");
						i = i+1;
						out.println("</ul></div></div></div>");	
						}
				%>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</body>

</html>
