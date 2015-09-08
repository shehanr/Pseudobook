<%@page import="cpsc.ooad.team.awesome.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="layout.css">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!-- Optional theme -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
</head>

<%
        User currentUser = (User) session.getAttribute("logged");
        UserRepository allUsers = UserRepository.instance();
	Collection<User> hm = allUsers.getAllUsers();
	String searched = request.getParameter("search_field");
	Integer id = allUsers.getID(currentUser.getUsername());
	ArrayList<User> pending = currentUser.getPendingFriends();
%>

<body>

<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
	<!-- Brand and toggle get grouped for better mobile display -->
    	<div class="navbar-header">
      		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        		<span class="sr-only">Toggle navigation</span>
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>
      		</button>
      		<a class="navbar-brand" href="#">Pseudobook</a>
    	</div>
<%if(currentUser != null){%>
	<form class="navbar-form navbar-left" role="search" action="#" method="POST">
        <div class="form-group">
          	<input type="text" size="40" class="form-control" placeholder="Search for user..." name="search_field">
        </div>
        	<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
      	</form>
	<%if(searched != null){
		searched = searched.toLowerCase();
		ArrayList<Integer> names = new ArrayList<Integer>();
        	Iterator<User> itr = hm.iterator();
		
		while(itr.hasNext()){
			User u = itr.next();
            		String name = u.getBasicInformation().getFirstName() + u.getBasicInformation().getLastName();			
			if(name.toLowerCase().contains(searched)){
				names.add(allUsers.getID(u.getUsername()));
			}
        	}
	%>
	<div class="modal" id="search" tabindex="-1" role="dialog" aria-labelledby="searchLabel" aria-hidden="true">
        	<div class="modal-dialog modal-sm">
                	<div class="modal-content">
                        	<div class="modal-header">
					<%out.println("<a href='profile.jsp?id=" + id + "' class='close' data-dismiss='modal' aria-hidden=true>");%>
                                	&times;
					</a>
                                        <h4 class="modal-title" id="searchLabel">Search Results</h4>
                                </div>
                                <div class="modal-body">
				<ul class='nav nav-pills nav-stacked'>
                                <% if(names.size()==0){out.println("<p style='text-align:center;'>No matches found.</p>");}else{
					
					for(int i=0;i<names.size();i++){
					out.println("<li><a href='profile.jsp?id=" + names.get(i) + "'>");
					out.println("<img src='"+allUsers.getUser(names.get(i)).getProfilePicture()+"' style='width:30px;height:30px;'>");
					out.println("    " + allUsers.getUser(names.get(i)).getBasicInformation().getFirstName() + " " + allUsers.getUser(names.get(i)).getBasicInformation().getLastName() + "</a></li>");
				}}%>
				</ul>
                                </div>
                        </div>
                </div>
        </div>
	<%searched=null;}%>
	<ul class="nav nav-pills navbar-nav navbar-right">
	<li>
		<%
		out.println("<a href='profile.jsp?id=" + allUsers.getID(currentUser.getUsername()) + "'>" + currentUser.getBasicInformation().getFirstName());
		%>
		</a>
	</li>
	<li>
		<a href="home.jsp">Home</a>
	</li>
	<li class="dropdown">
          <a href="" class="dropdown-toggle" data-toggle="dropdown"><span class="badge pull-right"><%if(pending.size()==0){out.println("0");}else{out.println(pending.size());}%></span>Requests</a>
          <ul class="dropdown-menu">
	<%
	if(pending.size()==0){out.println("<li style=text-align:center;>No pending requests</a></li>");}else{
		for(int i=0;i<pending.size();i++){
			out.println("<li style='float:left;border-bottom:thin solid grey;'><img src='"+pending.get(i).getProfilePicture()+"' style='width:30px;height:30px;float:left;margin-left:20px;margin-top:5px;margin-right:5px;'>");
            		out.println(pending.get(i).getBasicInformation().getFirstName()+ " " + pending.get(i).getBasicInformation().getLastName());
			 out.println("<form role=form method=POST action=friendDecisionController.jsp style=display:inline;float:left;><input type=hidden name=pendid value="+allUsers.getID(pending.get(i).getUsername())+"><input type=hidden name=id value="+id +"><div class='btn-group btn-group-xs'style='position:relative;float:right;margin-left:5px;'><button type=submit name=submit value=add class='btn btn-success'><span class='glyphicon glyphicon-ok'></span></button><button type=submit name=submit value='remove' class='btn btn-danger'><span class='glyphicon glyphicon-remove'></span></button></div></form></li>");
		}
	}
        %>  
	  </ul>
        </li>
	<li>
		<a href="#">
	<span class="badge pull-right">4</span>
		Messages
		</a>
	</li>
	<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="badge pull-right">6</span>Notifications</a>
          <ul class="dropdown-menu">
            <li><a href="#">Blah 1</a></li>
            <li><a href="#">Blah 2</a></li>
            <li><a href="#">Blah 3</a></li>
            <li><a href="#">Blah 4</a></li>
	    <li><a href="#">Blah 5</a></li>
            <li><a href="#">Blah 6</a></li>
          </ul>
        </li>
	<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Options <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a style="cursor:hand;cursor:pointer;" data-toggle="modal" data-target="#group">Create Group</a></li>
            <li><a href="#">Privacy</a></li>
            <li class="divider"></li>
            <li><a href="logoutController.jsp">Logout</a></li>
          </ul>
        </li>
	</ul>
	<div class="modal fade" id="group" tabindex="-1" role="dialog" aria-labelledby="groupLabel" aria-hidden="true">
        	<div class="modal-dialog modal-sm">
                        <div class="modal-content">
                                        <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                <h4 class="modal-title" id="goupLabel">Create Group</h4>
                                        </div>
                                        <div class="modal-body">
                                                <form action="createGroupController.jsp" method="POST" role="form" id="groupForm">
                                                        Group Name:</br><input type="text" name="groupName"/>
							<br/>Group Description:<textarea style="resize:none;" rows="6" cols="38" name="groupDesc" form="groupForm"></textarea>
                                        </div>
                                        <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary btn-sm">Create Group</button>
                                                </form>
                                        </div>
                        </div>
                </div>
        </div>
<%}%>
</div>
</nav>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script type=text/javascript>
        $(window).load(function(){
                $('#search').modal('show');
        });
</script>
</body>

</html>

