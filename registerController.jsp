<%@page import="cpsc.ooad.team.awesome.*" %>
<%@page import="java.util.Hashtable" %>
<%
	Hashtable<String, String> errors =
		(Hashtable<String, String>)
			session.getAttribute("check");
	UserRepository registerCheck = UserRepository.instance();
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");	
	String email = request.getParameter("email");
	String passone = request.getParameter("passone");
	String passtwo = request.getParameter("passtwo");
	String birthdayMonth = request.getParameter("birthdayMonth");	
	String birthdayDay= request.getParameter("birthdayDay");	
	String birthdayYear = request.getParameter("birthdayYear");
	String birthday = birthdayMonth + birthdayDay + birthdayYear; //creates full date String
	String gender = request.getParameter("gender");
	

	boolean validBirthday = true;
	int month = Integer.valueOf(birthdayMonth);
	int day = Integer.valueOf(birthdayDay);
	int year = Integer.valueOf(birthdayYear);

	if((month == 4 || month == 6 || month == 9 || month == 11) && (day > 30)){
		validBirthday = false;
	}
	else if(month == 2){
		if((year % 4 == 0) && day > 29){
			validBirthday = false;
		}
		else if(day > 28){
			validBirthday = false;
		}
	}


	if(email != "" && passone != "" && passtwo != "" && passone.equals(passtwo) && registerCheck.getID(email) == null && validBirthday == true && gender != null){
		registerCheck.createNewUser(email, passone);
		BasicInformation newUserInfo = registerCheck.getUser(registerCheck.getID(email)).getBasicInformation();
		newUserInfo.setFirstName(firstName);
		newUserInfo.setLastName(lastName);
		newUserInfo.setBirthday(birthday);
		session.setAttribute("logged", registerCheck.getUser(registerCheck.getID(email)));
		response.sendRedirect("profile.jsp?id="+ registerCheck.getID(email));
	}
	else{
		if(email == "" || passone == "" || passtwo == "" || gender == null){
			errors.put("empty", "*One or more of the fields were left empty");
		}
		if(email != ""){
			errors.put("lastUser", email);
		}
		if(registerCheck.getID(email) != null){
			errors.put("userTaken", "*Email is already in use");
		}
		if(!passone.equals(passtwo)){
			errors.put("passMatch", "*The passwords entered did not match");
		}
		if(validBirthday == false){
			errors.put("invalidDate", "*The date entered is not valid");
		}
		response.sendRedirect("/Pseudobook");
	}	
%>
