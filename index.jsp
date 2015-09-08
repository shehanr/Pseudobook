<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.util.*" %>
<html>

<head>
<title>Register</title>
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
        <jsp:include page="logMenu.jsp"/>
        <div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4">
	<%
	if(errors.size() > 0){
		out.println("<div style=color:red; align=center>");
        	if(errors.get("empty")!= null){ out.println(errors.get("empty"));}
		if(errors.get("userTaken") != null){ out.println("<br>" + errors.get("userTaken"));}
		if(errors.get("passMatch") != null){ out.println("<br>" + errors.get("passMatch"));}
		if(errors.get("invalidDate") != null){ out.println("<br>" + errors.get("invalidDate"));}
		out.println("</div>");
	}
	%>
	<div class="innerContainer effect">
<h1>Register</h1>
<form action="registerController.jsp" method="GET">
<input type="text" size="32" placeholder="First Name" name="firstName">
<input type="text" size="32" placeholder="Last Name" name="lastName">

<input type="text" size="32" placeholder="Email" name="email"
<%
	if(errors.get("lastUser") != null){ out.println("value=" + errors.get("lastUser")+ ">");}else{out.println(">");}
%>
<input type="password" size="32" placeholder="Password" name="passone">
<input type="password" size="32" placeholder="Re-enter Password" name="passtwo"><br/>
<%
	errors = new Hashtable<String, String>();
        session.setAttribute("check", errors);

%>

Birthday</br>

<select name="birthdayMonth" id="month" style="height:30px;">
	<option value="01">Jan</option>
	<option value="02">Feb</option>
	<option value="03">Mar</option>
	<option value="04">Apr</option>
 	<option value="05">May</option>
	<option value="06">Jun</option>
	<option value="07">Jul</option>
	<option value="08">Aug</option>
	<option value="09">Sep</option>
	<option value="10">Oct</option>
	<option value="11">Nov</option>
	<option value="12">Dec</option>
</select>

<select name="birthdayDay" id="day" style="height:30px;">
	<%
	for(int i=1; i<=31; i++){
		if(i < 10){
		out.println("<option value=0" + i + ">" + i + "</option>\n");
		}else{
		out.println("<option value=" + i + ">" + i + "</option>\n");}
	}%>
</select>

<select name="birthdayYear" id="year" style="height:30px;">
	<%
	Date current = new Date();
	int year = current.getYear();
	
	for(int i=2014; i >= 1914; i--){
		out.println("<option value=" + i + ">" + i + "</option>\n");
	} 
	%>	
</select>
</br>
<input type="radio" name="gender" value="M" checked>Male
<input type="radio" name="gender" value="F">Female</br>

<p class="submit">
<input type="submit" value="Register"></p>
</form>
</div>
</div>
<div class="col-md-4"></div>
</div></div></div>
</body>
</html>
