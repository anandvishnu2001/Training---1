<cfif NOT (structKeyExists(session, "user") 
    AND session.user.access)>
        <cfset session.user = {
            "access" = false
        }>
</cfif>
<cfset control = CreateObject("component", "components.control")>
<cfif structKeyExists(form, "btn")>
	<cfset control.userLogin(user=form.user, password=form.password)>
    <cfif session.user.access>
		<cflocation url="index.cfm" addToken="no">
	<cfelse>
		<cflocation url="login.cfm" addToken="no">
	</cfif>
</cfif>
<html lang="en">
	<head>
		<link href="/css/admin.css" rel="stylesheet">
		<link href="/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="container-fluid p-0 d-flex flex-row align-items-center">
		<nav id="main-nav" class="container-fluid navbar navbar-expand-lg justify-content-between bg-primary gap-5 z-3 fw-bold fixed-top" data-bs-theme="dark">
            <a class="navbar-brand" href="index.cfm">
                <img src="/images/shop.png" width="40" height="40" class="img-fluid">
                Shopping Cart
            </a>
            <form class="flex-grow-1 d-flex">
                <input class="form-control me-2" type="text" placeholder="Search">
                <button class="btn btn-primary" type="button">
                    <img src="/images/search.png" class="img-fluid" alt="Cart" width="30" height="30">
                </button>
            </form>
            <ul class="flex-grow-1 navbar-nav nav-tabs nav-justified">
                <li class="nav-item">
                    <a class="nav-link" href="cart.cfm">
                        <img src="/images/cart.png" class="img-fluid" alt="Cart" width="30" height="30">
                        <span class="badge bg-danger rounded-pill">99</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.cfm">
                        <img src="/images/login.png" class="img-fluid" alt="Login" width="30" height="30">
                    </a>
                </li>
            </ul>
		</nav>
		<div class="card col-lg-4 col-md-6 col-8 rounded-3 mx-auto mt-5 mb-3 p-3">
			<p class="h1 card-header card-title text-center text-primary">USER LOGIN</p>
			<form name="login" id="login" class="card-body d-flex flex-column was-validated gap-2" action="" method="post">
				<div class="form-floating">
					<input type="text" class="form-control" name="user" id="user" placeholder="" autofocus required>
					<label for="user" class="form-label">User</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" name="password" id="password" placeholder="" required>
					<label for="password" class="form-label">Password</label>
				</div>
				<span id="feedback" class="border-3 text-center text-danger bg-warning invisible"></span>
			</form>
			<button name="btn" id="btn" type="submit" class="card-footer btn btn-success btn-block" form="login">
				Log in
			</button>
		</div>
		<script type="text/javascript" src="/js/jQuery.js"></script><!---
		<script type="text/javascript" src="/js/admin.js"></script>--->
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
	</body>
</html>