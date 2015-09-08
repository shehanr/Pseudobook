<%@page import="cpsc.ooad.team.awesome.*" %>
<%@page import="java.util.Hashtable" %>
<%
	
        User currentUser = (User) session.getAttribute("logged");
	UserRepository registerCheck = UserRepository.instance();
	String firstName = request.getParameter("first");
	String lastName = request.getParameter("last");	
	String birthdayMonth = request.getParameter("birthdayMonth");	
	String birthdayDay= request.getParameter("birthdayDay");	
	String birthdayYear = request.getParameter("birthdayYear");
	String relationship = request.getParameter("relStatus");
	String birthday = birthdayMonth + birthdayDay + birthdayYear; //creates full date String
	String gender = request.getParameter("gender");
	
	BasicInformation newUserInfo = registerCheck.getUser(registerCheck.getID(currentUser.getUsername())).getBasicInformation();
	newUserInfo.setFirstName(firstName);
	newUserInfo.setLastName(lastName);
	newUserInfo.setBirthday(birthday);
	newUserInfo.setGender(gender);
	newUserInfo.setRelationshipStatus(relationship);
	response.sendRedirect("profile.jsp?id=" + registerCheck.getID(currentUser.getUsername()));
%>
