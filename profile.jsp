<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.util.ArrayList"%>
<html>

<head>
<title>Profile Page</title>
<link rel="stylesheet" type="text/css" href="layout.css">
</head>

<%
	User currentUser = (User) session.getAttribute("logged");
	UserRepository allUsers = UserRepository.instance();
	Integer id = Integer.parseInt(request.getParameter("id"));
	boolean loggedPage = false;
	if(allUsers.getUser(id) == currentUser){
		loggedPage = true;
	}
	User pageOwner = allUsers.getUser(id);
	BasicInformation pageBasic = pageOwner.getBasicInformation();
	String bday = pageBasic.getBirthday();
	String month = bday.substring(0,2);
	String day = bday.substring(2,4);
	String year = bday.substring(4,8);
	ArrayList<String> hobbies = pageBasic.getHobbies();
	ArrayList<User> friends = pageOwner.getFriends();
	ArrayList<WallPost> wallposts = pageOwner.getAllWallPost();
	ArrayList<Group> groups = currentUser.getGroups();
	String hobbyStr = "";
	if(hobbies.size() > 0){
		for(int i=0;i<hobbies.size();i++){
			hobbyStr += hobbies.get(i) + ", ";
		}
		hobbyStr = hobbyStr.substring(0, hobbyStr.length()-2);
	}
	ArrayList<Message> comments = null;
%>

<body>
<div style="background-color:black">
<div class="container">
	<jsp:include page="menu.jsp"/>
	<div class="row">
  		<div class="col-md-3">
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
				if(currentUser.getFriends().contains(pageOwner)){
				out.println("<div style=text-align:center;><button type=button class='btn btn-primary' style='text-align:center;margin-top:-10px;margin-bottom:10px;'>Friends <span class='glyphicon glyphicon-ok'></span></button></div>");
				}else if(currentUser.getPendingFriends().contains(pageOwner)){
				out.println("<div style=text-align:center;><button type=button class='btn btn-primary' style='text-align:center;margin-top:-10px;margin-bottom:10px;'>Respond to Friend Request</button></div>");
				}else if(pageOwner.getPendingFriends().contains(currentUser)){
                                out.println("<div style=text-align:center;><button type=button class='btn btn-primary' style='text-align:center;margin-top:-10px;margin-bottom:10px;'>Friend Request Sent</button></div>");
				}else{	
			%>
			<form action="addFriendController.jsp" method="POST" role="form" style="text-align:center;margin-top:-10px;margin-bottom:10px;">
				<%out.println("<input type='hidden' name='id' value="+id+">");%>
				<button type="submit" name="addfriend" class="btn btn-primary">Add Friend <span class="glyphicon glyphicon-plus"></span></button>
			</form>
			<%}}%>
			<ul class="list-group">
				<%
				if(loggedPage){
                                out.println("<li class='list-group-item'><b>Groups <span class='badge'>"+groups.size()+"</span></b><br/>");
				for(int i=0;i<groups.size();i++){
					out.println("<a href='group.jsp?id="+allUsers.getID(groups.get(i).getGroupName())+"'>");
					out.println("    " + groups.get(i).getGroupName() + "</a>");
				}
				out.println("</li>");
				}
                                out.println("<li class='list-group-item'><b>Friends <span class='badge'>"+friends.size()+"</span></b><br/>");
                                        for(int i=0;i<friends.size();i++){
                                        out.println("<a href='profile.jsp?id=" + allUsers.getID(friends.get(i).getUsername()) + "' style='font-size:12px;'>");
                                        out.println("<img src='"+friends.get(i).getProfilePicture()+"' style='width:30px;height:30px;'>");
                                        out.println("    " + friends.get(i).getBasicInformation().getFirstName() + " " + friends.get(i).getBasicInformation().getLastName() + "</a>");
                                }%>
				</li>
                        </ul>
  		</div>
		<div class="modal fade" id="upload" tabindex="-1" role="dialog" aria-labelledby="uploadLabel" aria-hidden="true">
  			<div class="modal-dialog modal-sm">
    				<div class="modal-content">
      					<div class="modal-header">
        					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        					<h4 class="modal-title" id="uploadLabel">Upload photo</h4>
      					</div>
      					<div class="modal-body">
        					<form action="uploadController.jsp" method="POST" enctype="multipart/form-data">
							<input type="file" name="file"/>
      					</div>
      					<div class="modal-footer">
        					<button type="submit" class="btn btn-primary btn-sm">Set as profile picture</button>
						</form>
      					</div>
    				</div>
  			</div>
		</div>
		<div class="col-md-9">
			<ul class="list-group">
  				<li class="list-group-item"><b>About me:</b>
				<%
					if(loggedPage){
				%>
                                <button class="btn btn-default btn-xs" style="position:relative;float:right;" data-toggle="modal" data-target="#editBasic">Edit Basic Information</button>
				<%}%>
				</li>
  				<li class="list-group-item" style="padding:5px 8px;">Name: <%out.println(pageBasic.getFirstName() + " " + pageBasic.getLastName());%></li>
  				<li class="list-group-item" style="padding:5px 8px;">Gender: <%out.println(pageBasic.getGender());%></li>
				<li class="list-group-item" style="padding:5px 8px;">Birthday: <%out.println(month + "/" + day + "/" + year);%></li>
				<li class="list-group-item" style="padding:5px 8px;">Relationship Status: <%out.println(pageBasic.getRelationshipStatus());%></li>
  				<li class="list-group-item" style="padding:5px 8px;">Hobbies: <%out.println(hobbyStr);%></li>
			</ul>
			<div class="modal fade" id="editBasic" tabindex="-1" role="dialog" aria-labelledby="basicLabel" aria-hidden="true">
                        <div class="modal-dialog modal-sm">
                                <div class="modal-content">
                                        <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                <h4 class="modal-title" id="basicLabel">Edit Basic Information</h4>
                                        </div>
                                        <div class="modal-body">
                                                <form action="basicInfoController.jsp" method="POST" role="form">
                                                        <%out.println("First Name:<br/><input type='text' name='first' value='" + pageBasic.getFirstName() + "'><br/>");%>
							<%out.println("Last Name:<br/><input type='text' name='last' value='" + pageBasic.getLastName() + "'><br/>");%>
							Gender:<br/>
							<%
                                                        if(pageBasic.getGender().equals("M")){
                                                                out.println("<input type='radio' name='gender' value='M' checked>Male");
                                                        }else{
                                                                out.println("<input type='radio' name='gender' value='M'>Male");
                                                        }
                                                        if(pageBasic.getGender().equals("F")){
                                                                out.println("<input type='radio' name='gender' value='F' checked>Female</br>");
                                                        }else{
                                                                out.println("<input type='radio' name='gender' value='F'>Female</br>");
                                                        }
                                                        %>
							Birthday</br>
							<select name="birthdayMonth" id="month">
							<%
							int monc;
							if(month.substring(0,1).equals("0")){
                                                                monc = Integer.parseInt(month.substring(1,2));
                                                        }else{
                                                                monc = Integer.parseInt(month);
                                                        }
        						for(int i=1; i<=12; i++){
                                                        	if(i == monc && i < 10){
                                                                        out.println("<option value=0" + i + " selected>" + i + "</option>\n");
                                                                }
                                                                if(i != monc && i < 10){
                                                                        out.println("<option value=0" + i + ">" + i + "</option>\n");
                                                                }
                                                                if(i == monc && i >= 10){
                                                                        out.println("<option value=" + i + " selected>" + i + "</option>\n");
                                                                }
                                                                if(i != monc && i >= 10){
                                                                        out.println("<option value=" + i + ">" + i + "</option>\n");
                                                                }
							}%>
							</select>
							<select name="birthdayDay" id="day">
        						<%
							int dayc;
							if(day.substring(0,1).equals("0")){
								dayc = Integer.parseInt(day.substring(1,2));
							}else{
								dayc = Integer.parseInt(day);
							} 
        						for(int i=1; i<=31; i++){
								if(i == dayc && i < 10){
									out.println("<option value=0" + i + " selected>" + i + "</option>\n");
								}
                						if(i != dayc && i < 10){
                							out.println("<option value=0" + i + ">" + i + "</option>\n");
                						}
								if(i == dayc && i >= 10){
                							out.println("<option value=" + i + " selected>" + i + "</option>\n");
								}
								if(i != dayc && i >= 10){
                                                                        out.println("<option value=" + i + ">" + i + "</option>\n");
                                                                }
        						}%>
							</select>
							<select name="birthdayYear" id="year">
        						<%
							int yearc = Integer.parseInt(year);
        						for(int i=2014; i >= 1914; i--){
								if(i == yearc){
                							out.println("<option value=" + i + " selected>" + i + "</option>\n");
								}else{
									out.println("<option value=" + i + ">" + i + "</option>\n");
								}
        						}
        						%>
							</select>
							</br>Relationship Status:</br>
							<select name="relStatus" id="reStat">
								<%
								if(pageBasic.getRelationshipStatus().equals("")){
                                                                        out.println("<option value='' selected></option>\n");
                                                                }else{
									out.println("<option value=''></option>\n");
								}
                                                                if(pageBasic.getRelationshipStatus().equals("Single")){
                                                                        out.println("<option value='Single' selected>Single</option>\n");
                                                                }else{
									out.println("<option value='Single'>Single</option>\n");
								}
                                                                if(pageBasic.getRelationshipStatus().equals("In a relationship")){
                                                                        out.println("<option value='In a relationship' selected>In a relationship</option>\n");
                                                                }else{
									out.println("<option value='In a relationship'>In a relationship</option>\n");
								}
                                                                if(pageBasic.getRelationshipStatus().equals("I'd rather not say")){
                                                                        out.println("<option value='I'd rather not say' selected>I'd rather not say</option>\n");
                                                                }else{
									out.println("<option value='I'd rather not say'>I'd rather not say</option>\n");
								}
								%>
							</select>
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
				<%if(friends.contains(currentUser) || currentUser==pageOwner){%>
				<form role="form" method="POST" action="addWallPostController.jsp">
				<div class="input-group">
					<%out.println("<input type='hidden' name='id' value='"+id+"'>");%>
      					<input type="text" class="form-control" name="wallpost" placeholder="Enter a status/wallpost...">
      					<span class="input-group-btn">
        				<button class="btn btn-default" type="submit">Post</button>
      					</span>
    				</div>
				</form><%}%>
				<div class="panel-group" id="accordion" style="margin-top:20px;">
				<%
					for(int i=0; i<wallposts.size(); i++){
						User author = wallposts.get(i).getAuthor();
  						out.println("<div class='panel panel-default'>");
    						out.println("<div class=panel-heading>");
      						out.println("<h4 class=panel-title>");

                                        	out.println("<a href='profile.jsp?id="+allUsers.getID(author.getUsername())+"' style=color:#428bca;font-size:12px;>"+author.getBasicInformation().getFirstName()+" "+author.getBasicInformation().getLastName()+"</a>");
						if(currentUser==pageOwner || currentUser == author){
						out.println("<form role=form method=POST class=close style=opacity:1; action=deleteWallPostController.jsp><input type=hidden name=time value='" + wallposts.get(i).getDate() + "'><input type=hidden name=id value='" + id + "'><button type=submit class=close>&times;</button></form>");}
						out.println("<br/><p class='date' style='margin:0;padding:0;'>"+wallposts.get(i).getDate()+"</p>");
                                        	out.println("<p style='margin:0;padding:0;margin-left:10%;margin-bottom:5px;'>"+wallposts.get(i).getMessage()+"</p>");
						if(friends.contains(currentUser) || currentUser==pageOwner){
						out.println("<form role=form method=POST action=likeController.jsp style=display:inline;><div class='btn-group btn-group-xs' style='position:relative;float:right;margin-left:10px;'><input type='hidden' name='time' value='"+wallposts.get(i).getDate()+"'><input type='hidden' name='id' value='"+id+"'><button type='submit' name='submit' value='like' class='btn btn-default'><span class='glyphicon glyphicon-thumbs-up'>"+wallposts.get(i).getLikes().size()+"</span></button><button type='submit' name='submit' value='dislike' class='btn btn-default'><span class='glyphicon glyphicon-thumbs-down'>"+wallposts.get(i).getDislikes().size()+"</span></button></div></form>");}
						out.println("<a data-toggle=collapse data-parent=#accordion href=#collapse" + (i+1) + " style='font-size:12px;' class='collapsed'>");
          					out.println("<p class='text-right' style='margin:0;padding:0;color:#428bca;'>Comments("+wallposts.get(i).getComments().size()+")</p></a></h4></div>");
    						out.println("<div id=collapse" + (i+1) + " " + "class='panel-collapse collapse'>");
      						out.println("<div class=panel-body>");
        					out.println("<ul style=list-style-type:none;margin-top:-10px;margin-bottom:-15px;>");

						comments = wallposts.get(i).getComments();
						for(int j=0; j<comments.size(); j++){
							User cauth = comments.get(j).getAuthor();
                                        		out.println("<li><a href=profile.jsp?id="+allUsers.getID(cauth.getUsername())+" style=font-size:12px;>"+cauth.getBasicInformation().getFirstName()+" "+cauth.getBasicInformation().getLastName()+"</a> "+comments.get(j).getMessage());
							if(currentUser==cauth || currentUser==pageOwner){
							out.println("<form role=form method=POST class=close style='opacity:1;margin-bottom:-5px;' action=removeCommentController.jsp><input type='hidden' name='wptime' value='"+wallposts.get(i).getDate()+"'><input type='hidden' name='ctime' value='"+comments.get(j).getDate()+"'><input type=hidden name=id value="+id+"><button type=submit class=close>&times;</button></form>");}
                                                	out.println("</li><li class=date>"+comments.get(j).getDate()+"</li>");
						}
						if(friends.contains(currentUser) || currentUser==pageOwner){
                                                out.println("<li><form role=form method=POST action='addCommentController.jsp'><input type=hidden name=wptime value='"+wallposts.get(i).getDate()+"'><input type='hidden' name='id' value='"+id+"'><div class='input-group comm'>");
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
</div>
</div>
</body>

</html>
