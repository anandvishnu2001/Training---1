<html lang="en" data-bs-theme="dark">
	<body class="d-flex flex-row align-items-center">
		<cfinclude template="index-submit.cfm">
		<nav class="navbar navbar-expand-lg navbar-dark bg-info fixed-top">
			<div class="container-fluid fw-bold">
				<a class="navbar-brand text-primary" href="./index.cfm">
					<img src="./images/logbook.png" width="40" height="40">
					Address Book
				</a>
				<ul class="navbar-nav nav-tabs">
					<li class="nav-item">
						<a class="nav-link text-success" href="./register.cfm">
							<img src="./images/signup.png" width="25" height="25">
							Sign Up
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active text-success" href="./index.cfm">
							<img src="./images/login.png" width="25" height="25">
							Log In
						</a>
					</li>
				</ul>
			</div>
		</nav>
		<div class="glow row d-inline-flex flex-wrap justify-content-around rounded-3 w-75 mx-auto mt-5 mb-3">
			<div class="d-flex col-7 col-md-4 align-items-center bg-body rounded-start-3">
				<img class="img-fluid" src="./images/logbook.png" alt="Address Book" width="300" height="300">
			</div>
			<div action class="flex-grow-1 d-inline-flex col-auto flex-column justify-content-between p-3">
				<p class="h1 text-center text-info mb-3">LOGIN</p>
				<form name="login" id="login" class="d-flex flex-column was-validated gap-2" action="" method="post">
					<div class="form-floating">
						<input type="text" class="form-control" name="username" id="username" placeholder="" autofocus required>
						<label for="username">Username or Email</label>
					</div>
					<span id="feedback" class="text-center text-danger bg-warning invisible"></span>
					<div class="form-floating">
						<input type="password" class="form-control" name="password" id="password" placeholder="" required>
						<label for="password">Password</label>
					</div>
				</form>
				<div class="d-grid gap-2">
					<button name="btn" type="submit" class="btn btn-primary btn-block" form="login">Log in</button>
					<hr class="border-3 border-warning">
					<span class="text-center text-warning">Not registered yet ?</span>
					<button class="btn btn-success btn-block" onclick="window.location.href='register.cfm'">Sign up</button>
				</div>
			</div>
		</div>
		<link href="./css/style.css" rel="stylesheet">
		<link href="./css/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="./js/jQuery.js"></script>
		<script type="text/javascript" src="./js/index-script.js"></script>
		<script type="text/javascript" src="./js/bootstrap.min.js"></script>
	</body>
</html>