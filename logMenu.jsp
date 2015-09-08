<%@page import="cpsc.ooad.team.awesome.*" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="layout.css">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!-- Optional theme -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
</head>

<body>

<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Pseudobook</a>
        </div>

        <form class="navbar-form navbar-right" role="form" action="loginController.jsp" method="POST">
        <div class="form-group">
            <input type="text" size="25" class="form-control" placeholder="Email" name="email">
            <input type="text" size="25" class="form-control" placeholder="password" name="password">
        </div>
            <button type="submit" class="btn btn-default">Login</button>
        </form>
    
</div>
</nav>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
</body>

</html>

