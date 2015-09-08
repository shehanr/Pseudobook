<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.util.ArrayList"%>
<html>

<head>
<title>Group Page</title>
<link rel="stylesheet" type="text/css" href="layout.css">
</head>

<%
	User currentUser = (User) session.getAttribute("logged");
	UserRepository allUsers = UserRepository.instance();
	Integer id = Integer.parseInt(request.getParameter("id"));
	Group groupPage = allUsers.getGroup(id);
	User pageOwner = groupPage.getModerator();
	BasicInformation pageBasic = pageOwner.getBasicInformation();
	boolean loggedPage = false;
        if(pageOwner == currentUser){
                loggedPage = true;
        }
	ArrayList<User> members = groupPage.getMembers();
	ArrayList<WallPost> wallposts = groupPage.getWallPosts();
	ArrayList<Message> comments = null;
	ArrayList<User> friends = pageOwner.getFriends();
	boolean isMember = false;
	if(members.contains(currentUser) || pageOwner == currentUser){ isMember = true;}
%>

<body>
<div style="background-color:black">
<div class="container">
	<jsp:include page="menu.jsp"/>
	<%if(isMember){%>
	<div class="row">
  		<div class="col-md-3">
			<%--
    			<div class="thumbnail" style="text-align:center;position:relative;">
			<%if(loggedPage){%>
			<button class="btn btn-primary btn-xs upbutton" data-toggle="modal" data-target="#upload">
                        Upload profile picture
                        </button>
			<%}
      			out.println("<img src='"+pageOwner.getProfilePicture()+"' style='width:253px;height:265px;'>");
    			%>
			</div>
			<%
				if(loggedPage == false && currentUser != null){
				if(groupPage.getMembers().contains(currentUser)){
				out.println("<div style=text-align:center;><button type=button class='btn btn-primary' style='text-align:center;margin-top:-10px;margin-bottom:10px;'>Member <span class='glyphicon glyphicon-ok'></span></button></div>");
				}else if(currentUser.getPendingFriends().contains(pageOwner)){
				out.println("<div style=text-align:center;><button type=button class='btn btn-primary' style='text-align:center;margin-top:-10px;margin-bottom:10px;'>Respond to Friend Request</button></div>");
				}else if(pageOwner.getPendingFriends().contains(currentUser)){
                                out.println("<div style=text-align:center;><button type=button class='btn btn-primary' style='text-align:center;margin-top:-10px;margin-bottom:10px;'>Friend Request Sent</button></div>");
				}else{	
			%>--%>
			<%if(loggedPage){%>
				<div style="text-align:center;margin-bottom:10px;">
				<button type="button" name="addMember" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editMemb">Add Members <span class="glyphicon glyphicon-plus"></span></button>
				</div><%}%>
			<ul class="list-group">
                                <%--<li class="list-group-item"><b>Groups</b></li>--%>
				<%
                                out.println("<li class='list-group-item'><b>Members <span class='badge'>"+members.size()+"</span></b><br/>");
                                        for(int i=0;i<members.size();i++){
                                        out.println("<a href='profile.jsp?id=" + allUsers.getID(members.get(i).getUsername()) + "'>");
                                        out.println("<img src='"+members.get(i).getProfilePicture()+"' style='width:30px;height:30px;'>");
                                        out.println("    " + members.get(i).getBasicInformation().getFirstName() + " " + members.get(i).getBasicInformation().getLastName() + "</a>");
                                }%>
				</li>
                        </ul>
  		</div>
		<div class="modal fade" id="editMemb" tabindex="-1" role="dialog" aria-labelledby="editMembLabel" aria-hidden="true">
  			<div class="modal-dialog modal-sm">
    				<div class="modal-content">
      					<div class="modal-header">
        					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        					<h4 class="modal-title" id="editMembLabel">Choose Members</h4>
      					</div>
      					<div class="modal-body">
        					<form action="addMemberController.jsp" method="POST" role="form">
							<%out.println("<input type='hidden' name='id' value='"+id+"'>");
							for(int i=0;i<friends.size();i++){
							if(!members.contains(friends.get(i))){
							out.println("<input type='checkbox' name='members' value='"+allUsers.getID(friends.get(i).getUsername())+"'>"+friends.get(i).getBasicInformation().getFirstName()+" "+ friends.get(i).getBasicInformation().getLastName()+"<br/>");
							}}
							%>
      					</div>
      					<div class="modal-footer">
        					<button type="submit" class="btn btn-primary btn-sm">Add Members</button>
						</form>
      					</div>
    				</div>
  			</div>
		</div>
		<div class="col-md-9">
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
 				<li class="list-group-item" style="padding:5px 8px;">Website: <%out.println("<a href=" + pageOwner.getBasicInformation().getEmail() + ">" + pageOwner.getBasicInformation().getEmail() + "</a>");%></li>
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
							<%out.println("Website (optional):<br/><input type='text' name='groupWeb' value='" + pageOwner.getBasicInformation().getEmail() + "'><br/>");%>
                                        </div>
                                        <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary btn-sm">Save Changes</button>
                                                </form>
                                        </div>
                                </div>
                        </div>
                	</div>
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<%if(members.contains(currentUser) || currentUser==pageOwner){%>
				<form role="form" method="POST" action="addWPGroupController.jsp">
				<%out.println("<input type='hidden' name='id' value='" + id + "'>");%>
				<div class="input-group">
      					<input type="text" class="form-control" name="wallpost" placeholder="Enter a status/wallpost...">
      					<span class="input-group-btn">
        				<button class="btn btn-default" type="submit">Post</button>
      					</span>
    				</div>
				</form><%}%>
				<div class="panel-group" id="accordion" style="margin-top:20px;">
				<%
					User author = null;
					for(int i=0; i<wallposts.size(); i++){
						author = wallposts.get(i).getAuthor();
  						out.println("<div class='panel panel-default'>");
    						out.println("<div class=panel-heading>");
      						out.println("<h4 class=panel-title>");

                                        	out.println("<a href='profile.jsp?id="+allUsers.getID(author.getUsername())+"' style=color:#428bca;font-size:12px;>"+author.getBasicInformation().getFirstName()+" "+author.getBasicInformation().getLastName()+"</a>");
						if(currentUser==pageOwner || currentUser == author){
						out.println("<form role=form method=POST class=close style=opacity:1; action=deleteWPGroupController.jsp><input type=hidden name=time value='" + wallposts.get(i).getDate() + "'><input type=hidden name=id value='" + id + "'><button type=submit class=close>&times;</button></form>");}
						out.println("<br/><p class='date' style='margin:0;padding:0;'>"+wallposts.get(i).getDate()+"</p>");
                                        	out.println("<p style='margin:0;padding:0;margin-left:10%;margin-bottom:5px;'>"+wallposts.get(i).getMessage()+"</p>");
						if(members.contains(currentUser) || currentUser==pageOwner){
						out.println("<form role=form method=POST action=likeGroupController.jsp style=display:inline;><div class='btn-group btn-group-xs' style='position:relative;float:right;margin-left:10px;'><input type='hidden' name='time' value='"+wallposts.get(i).getDate()+"'><input type='hidden' name='id' value='"+id+"'><button type='submit' name='submit' value='like' class='btn btn-default'><span class='glyphicon glyphicon-thumbs-up'>"+wallposts.get(i).getLikes().size()+"</span></button><button type='submit' name='submit' value='dislike' class='btn btn-default'><span class='glyphicon glyphicon-thumbs-down'>"+wallposts.get(i).getDislikes().size()+"</span></button></div></form>");}
						out.println("<a data-toggle=collapse data-parent=#accordion href=#collapse" + (i+1) + " style='font-size:12px;' class='collapsed'>");
          					out.println("<p class='text-right' style='margin:0;padding:0;color:#428bca;'>Comments("+wallposts.get(i).getComments().size()+")</p></a></h4></div>");
    						out.println("<div id=collapse" + (i+1) + " " + "class='panel-collapse collapse'>");
      						out.println("<div class=panel-body>");
        					out.println("<ul style=list-style-type:none;margin-top:-10px;margin-bottom:-20px;>");

						comments = wallposts.get(i).getComments();
						for(int j=0; j<comments.size(); j++){
							User cauth = comments.get(j).getAuthor();
                                        		out.println("<li><a href=profile.jsp?id="+allUsers.getID(cauth.getUsername())+" style=font-size:12px;>"+cauth.getBasicInformation().getFirstName()+" "+cauth.getBasicInformation().getLastName()+"</a> "+comments.get(j).getMessage());
							if(currentUser==cauth || currentUser==pageOwner){
							out.println("<form role=form method=POST class=close style='opacity:1;margin-bottom:-5px;' action=removeCGroupController.jsp><input type='hidden' name='wptime' value='"+wallposts.get(i).getDate()+"'><input type='hidden' name='ctime' value='"+comments.get(j).getDate()+"'><input type=hidden name=id value="+id+"><button type=submit class=close>&times;</button></form>");}
                                                	out.println("</li><li class=date>"+comments.get(j).getDate()+"</li>");
						}
						if(members.contains(currentUser) || currentUser==pageOwner){
                                                out.println("<li><form role=form method=POST action='addCGroupController.jsp'><input type=hidden name=wptime value='"+wallposts.get(i).getDate()+"'><input type='hidden' name='id' value='"+id+"'><div class='input-group comm'>");
                                                out.println("<input type=text class=form-control name='comment' placeholder='Enter a comment...'>");
                                                out.println("<span class=input-group-btn>");
                                                out.println("<button class='btn btn-default' type=submit>Post</button></span>");
                                                out.println("</div></form></li>");
						}
						out.println("</ul></div></div></div>");	
					}
				%>
				</div>
			</div>
		</div>
	</div>
<%}%>
</div>
</div>
</body>

</html>
