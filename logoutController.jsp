<%	
	if(session.getAttribute("logged") != null){
                session.setAttribute("logged", null);
        }
	response.sendRedirect("login.jsp");
%>
