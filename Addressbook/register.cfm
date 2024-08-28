<nav class="navbar navbar-expand-lg navbar-dark bg-info fixed-top">
	<div class="container-fluid fw-bold">
		<a class="navbar-brand text-primary" href="">
			<img src="./images/logbook.png" width="40" height="40">
			Address Book
		</a>
		<ul class="navbar-nav nav-pill">
			<li class="nav-item">
				<a class="nav-link text-success" href="">
					<img src="./images/signup.png" width="25" height="25">
					Sign Up
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link text-success" href="">
					<img src="./images/login.png" width="25" height="25">
					Log In
				</a>
			</li>
		</ul>
	</div>
</nav>
<div class="login row d-inline-flex flex-wrap justify-content-around rounded-3 mb-3">
		<div class="d-flex col-4 align-items-center bg-info rounded-start-3">
			<img class="img-fluid" src="./images/logbook.png" alt="Address Book">
		</div>
		<div action class="flex-grow-1 d-flex col-auto flex-column justify-content-between p-3">
			<p class="h1 text-center text-info mb-3">SIGN UP</p>
			<form name="signup" id="signup" class="d-flex flex-column gap-3" action="" method="post">
				<div class="form-floating">
					<input type="text" class="form-control" name="name" id="name" placeholder="" required>
					<label for="user">Fullname</label>
				</div>
				<div class="form-floating">
					<input type="email" class="form-control" name="email" id="email" placeholder="" required>
					<label for="user">Email ID</label>
				</div>
				<div class="form-floating">
					<input type="text" class="form-control" name="user" id="user" placeholder="" required>
					<label for="user">Username</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" name="password" id="password" placeholder="" required>
					<label for="password">Password</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" name="confirm" id="confirm" placeholder="" required>
					<label for="password">Confirm Password</label>
				</div>
				<button name="btn" type="submit" class="btn btn-success btn-block disabled" form="signup">Register</button>
			</form>
		</div>
</div>
<link href="./css/style.css" rel="stylesheet">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" href="./js/bootstrap.min.js"></script>