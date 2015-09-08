<%@page import="cpsc.ooad.team.awesome.*" %>
<%@page import="java.util.Hashtable" %>	
<%
	Hashtable<String, String> errors =
                (Hashtable<String, String>)
                        session.getAttribute("check");
	UserRepository loginCheck = UserRepository.instance();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
	User current = null;
	Integer id = null;

	if(loginCheck.getID(email) == null){
		if(email != ""){
                        errors.put("lastUser", email);
                }
		errors.put("invalidUser", "*The email entered is not registered to an account");
		response.sendRedirect("login.jsp");
	}else{
		id = loginCheck.getID(email);
		current = loginCheck.getUser(id);
		if(!current.getPassword().equals(password)){
                        errors.put("invalidPass", "*The password entered does not match our records");
			response.sendRedirect("login.jsp");
                }
	}

	if(current != null && current.getPassword().equals(password)){
		session.setAttribute("logged", current);
		response.sendRedirect("profile.jsp?id="+id);
	}
%>
