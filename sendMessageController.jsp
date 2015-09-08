<%@page import="cpsc.ooad.team.awesome.*"%>
<html>
<%
	User currentUser = (User)session.getAttribute("logged");
	String messagingUserIDStr = request.getParameter("id");
	int messagingUserID = Integer.valueOf(messagingUserIDStr);
	User messagingUser = UserRepository.instance().getUser(messagingUserID);
	String messageText = request.getParameter("messageText");
	if(!(currentUser.checkForConversation(messagingUser))){
		currentUser.startConversation(messagingUser, messageText);
	}
	else{
		Conversation currentConversation = currentUser.getConversation(UserRepository.instance().getUser(messagingUserID));
		currentConversation.addMessage(currentUser, messageText);
	}
	String redirectPage = "conversation.jsp?id=" + messagingUserIDStr;
	response.sendRedirect(redirectPage);
%>
</html>
