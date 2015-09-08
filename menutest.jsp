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
      		<a class="navbar-brand" href="#">Fakebook</a>
    	</div>

	<form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          	<input type="text" size="40" class="form-control" placeholder="Search for user..." name="search_field">
        </div>
        	<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
      	</form>

	<ul class="nav nav-pills navbar-nav navbar-right">
	<li>
		<a href="#">
		Home
		</a>
	</li>
	<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="badge pull-right">2</span>Requests</a>
          <ul class="dropdown-menu">
            <li><a href="#">Request 1</a></li>
            <li><a href="#">Request 2</a></li>
          </ul>
        </li>
	<li>
		<a href="#" data-toggle="modal" data-target="#myModal">
		<span class="badge pull-right">4</span>
		Messages
		</a>
	</li>
	        <div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
	<div class="modal-content">
        <div class="modal-header">
        <a href="#" data-toggle="modal" data-target="#newModal"><button type="button" style="float:right;" class="btn btn-primary btn-xs" data-dismiss="modal">New conversation <span class="glyphicon glyphicon-plus"></span></button></a>
                        <h4 class="modal-title" id="myModalLabel">Messages</h4>
        </div>
	<div class="modal-body">
		<jsp:include page="message.jsp"/>	
	</div>
	<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
	</div>
	</div></div>

	<div class="modal" id="newModal" tabindex="-1" role="dialog" aria-labelledby="newModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
        <div class="modal-content">
        <div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title" id"newModalLabel">New conversation</h4>
	</div>
	<div class="modal-body">
        	<jsp:include page="newmessage.jsp"/>
        </div>
		<div class="modal-footer">
                <a href="#" data-toggle="modal" data-target="#myModal"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></a>
                </div>
	</div></div></div>
	<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="badge pull-right">6</span>Notifications</a>
          <ul class="dropdown-menu">
            <li><a href="#">Blah 1</a></li>
            <li><a href="#">Blah 2</a></li>
            <li><a href="#">Blah 3</a></li>
            <li><a href="#">Blah 4</a></li>
	    <li><a href="#">Blah 5</a></li>
            <li><a href="#">Blah 6</a></li>
          </ul>
        </li>
	<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Options <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li class="divider"></li>
            <li><a href="#">Logout</a></li>
          </ul>
        </li>
</div>
</nav>
<script type=text/javascript>
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(window).load(function(){
        $('#myModal').modal('show');
    });
</script>
</body>

</html>

