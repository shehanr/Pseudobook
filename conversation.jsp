<%@page import="cpsc.ooad.team.awesome.*"%>

<html>
<head>
<%
	User currentUser = (User) session.getAttribute("logged");
	if(currentUser == null){%>
		<jsp:forward page="login.jsp"/>
	<%
	}
	else{
		UserRepository userRepo = UserRepository.instance();
		String id = request.getParameter("id");
		int userID = Integer.valueOf(id);
		User messagingUser = userRepo.getUser(userID);
		out.println("<title>" + messagingUser.getBasicInformation().getFullName() + "</title>");
	
		if(userID == currentUser.getID()){
			response.sendRedirect("inbox.jsp");
		}
		else{
			%>
			<link rel="stylesheet" type="text/css" href="layout.css">
			<body>
			<%
				out.println("Conversation with " + messagingUser.getBasicInformation().getFullName() + "<br>");
				if(currentUser.checkForConversation(messagingUser)){
					Conversation currentConversation = currentUser.getConversation(messagingUser);

					for(int i = 0; i < currentConversation.getAllMessages().size(); i++){
						out.println("<tr>");
						Message currentMessage = currentConversation.getAllMessages().get(i);
						User currentAuthor = currentMessage.getAuthor();
						out.println("<td>" + "<a href=profile.jsp?id=" + currentAuthor.getID() + ">" + currentAuthor.getBasicInformation().getFullName() + "</a></td>");
						out.println("<td>" + currentMessage.getMessage());
						out.println("<font size=2>" + currentMessage.getDate() + "</font></td></tr><br>");
					}
				}%>

				<form action="sendMessageController.jsp" method="post" id="message">
				<% out.println("<input type=hidden name=id value=" + id + " />");%>
				<br>
				<textarea rows="4" cols="50" placeholder="Enter message here..." name="messageText" form="message"></textarea>
				<br>
				<input type="submit" value="Send">
				</form>
				</body>
			</head>
		<%
		}
	}%>
</html>
