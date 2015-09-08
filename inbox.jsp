<%@page import="cpsc.ooad.team.awesome.*"%>
<%@page import="java.util.ArrayList"%>

<html>
<head>
<title>Inbox</title>
<link rel="stylesheet" type="text/css" href="layout.css">
</head>
<%
	User currentUser = (User) session.getAttribute("logged");
	if(currentUser == null){%>
		<jsp:forward page="login.jsp"/>
	<%
	}
	else{
		ArrayList<Conversation> currentUserConversations = currentUser.getAllConversations();
		UserRepository userRepo = UserRepository.instance();
		%>
		<body><%/*
		<div style="background-color:black">
		<div class="container">
			<jsp:include page="menu.jsp"/>
		*/%>

		</body>
			Conversations
			<table>
			<%
				for(int a = 0; a < currentUserConversations.size(); a++){
					out.println("<tr>");
					Conversation current = currentUserConversations.get(a);
					User messagingUser = null;
					for(int b = 0; b < 2; b++){
						if(current.getMessagingUsers().get(b) != currentUser){
							messagingUser = current.getMessagingUsers().get(b);	
						}
					}
					out.println("<td>" + "<a href=conversation.jsp?id=" + messagingUser.getID() + ">" + messagingUser.getBasicInformation().getFullName() + "</a></td>");
					if(current.getAllMessages().size() > 0){	
						out.println("<td>" + current.getAllMessages().get(current.getAllMessages().size()-1).getMessage() + "</td>");
					}
					else{
						out.println("<td></td>");
					}
					out.println("</tr>");
				}
			%>
		<%
		}%>	
</html>
