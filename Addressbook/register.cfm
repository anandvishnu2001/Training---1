<html lang="en" data-bs-theme="dark">
	<body class="container-fluid d-flex flex-row align-items-center">
		<cfinclude template="register-submit.cfm">
		<nav class="navbar navbar-expand-lg navbar-dark bg-info fixed-top">
			<div class="container-fluid fw-bold">
				<a class="navbar-brand text-primary" href="./index.cfm">
					<img src="./images/logbook.png" width="40" height="40">
					Address Book
				</a>
				<ul class="navbar-nav nav-tabs">
					<li class="nav-item">
						<a class="nav-link active text-success" href="./register.cfm">
							<img src="./images/signup.png" width="25" height="25">
							Sign Up
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link text-success" href="./index.cfm">
							<img src="./images/login.png" width="25" height="25">
							Log In
						</a>
					</li>
				</ul>
			</div>
		</nav>
		<div class="glow row d-inline-flex flex-wrap justify-content-around rounded-3 w-75 mx-auto mt-5 mb-3">
			<div class="d-flex col-7 col-md-4 align-items-center bg-info rounded-start-3">
				<img class="img-fluid" src="./images/logbook.png" alt="Address Book" width="300" height="300">
			</div>
			<div action class="flex-grow-1 d-flex col-auto flex-column justify-content-between p-3">
				<p class="h1 text-center text-info mb-3">SIGN UP</p>
				<form name="register" id="register" class="d-flex flex-column was-validated gap-2" action="" method="post">
					<div class="form-floating">
						<input type="text" class="form-control" name="name" id="name" placeholder="" required>
						<label for="name">Fullname</label>
					</div>
					<div class="form-floating">
						<input type="email" class="form-control" name="email" id="email" placeholder="" required>
						<label for="email">Email ID</label>
					</div>
					<div class="form-floating">
						<input type="text" class="form-control" name="username" id="username" pattern="^\w{4,}$" placeholder="" required>
						<label for="username">Username</label>
					</div>
					<div class="form-floating">
						<input type="password" class="form-control" name="password" id="password" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$" placeholder="" required>
						<label for="password">Password</label>
					</div>
					<div class="form-floating">
						<input type="password" class="form-control" name="confirm" id="confirm" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$" placeholder="" required>
						<label for="confirm">Confirm Password</label>
					</div>
					<span id="feedback" class="text-center text-danger bg-warning invisible"></span>
					<button name="btn" id="btn" type="submit" class="btn btn-success btn-block disabled" form="register">Register</button>
				</form>
			</div>
		</div>
		<link href="./css/style.css" rel="stylesheet">
		<link href="./css/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="./js/jQuery.js"></script>
		<script type="text/javascript" src="./js/register-script.js"></script>
		<script type="text/javascript" src="./js/bootstrap.min.js"></script>
	</body>
</html>