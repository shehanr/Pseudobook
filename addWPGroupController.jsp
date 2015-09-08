<%@page import="cpsc.ooad.team.awesome.*"%>

<%
        Integer id = Integer.parseInt(request.getParameter("id"));
        UserRepository allGroups = UserRepository.instance();
        User currentUser = (User) session.getAttribute("logged");
        String wallpost = request.getParameter("wallpost");

        if(wallpost != ""){
                allGroups.getGroup(id).addWallPost(currentUser, wallpost);
        }
        response.sendRedirect("group.jsp?id="+id);
%>

