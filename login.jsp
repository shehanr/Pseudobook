<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.util.*" %>
<html>

<head>
<title>Login</title>
<link rel="stylesheet" type="text/css" href="layout.css">
<link rel="stylesheet" type="text/css" href="reg_log.css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!-- Optional theme -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
</head>


<%
	Hashtable<String, String> errors =
		(Hashtable<String, String>)
			session.getAttribute("check");
	if(errors == null){
		errors = new Hashtable<String, String>();
	        session.setAttribute("check", errors);
	}

%>
<body>
<div style="background-color:black">
<div class="container">
        <jsp:include page="log_Menu.jsp"/>
        <div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4">
	<%
	if(errors.size() > 0){
		out.println("<div style=color:red; align=center>");	
		if(errors.get("notLogged") != null){ out.println(errors.get("notLogged"));}
		if(errors.get("invalidUser") != null){ out.println("<br>"+ errors.get("invalidUser"));}
        	if(errors.get("invalidPass") != null){ out.println("<br>"+ errors.get("invalidPass"));}
		out.println("</div>");
	}
	%>
	<div class="innerContainer effect">
<h1>Login</h1>
<form action="loginController.jsp" method="GET">

<input type="text" size="32" placeholder="Email" name="email"
<%
       if(errors.get("lastUser") != null){ out.println("value=" + errors.get("lastUser"));}
%>>
<input type="password" size="32" placeholder="Password" name="password">
<%

        errors = new Hashtable<String, String>();
        session.setAttribute("check", errors);

%></br>
<p class="submit">
<input type="submit" value="Login"></p>
</form>

</div>
</div>
<div class="col-md-4"></div>
</div></div></div>
</body>
</html>
