<cfinclude template="logbook-submit.cfm">
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
	<body class="container-fluid d-flex flex-row align-items-center">
		<cfinclude template="object.cfm">
		<nav class="navbar navbar-expand-sm navbar-dark bg-info fixed-top">
			<div class="container-fluid fw-bold">
				<a class="no_print navbar-brand text-primary" href="./index.cfm">
					<img src="./images/logbook.png" width="40" height="40">
					Address Book
				</a>
				<ul class="navbar-nav nav-tabs">
					<li class="no_print nav-item">
						<form class="m-0" method="post">
							<button name="btn" id="btn" class="nav-link text-success" type="submit">
								<img src="./images/logout.png" width="25" height="25">
								Log Out
							</button>
						</form>
					</li>
				</ul>
			</div>
		</nav>
		<div class="no_print container d-inline-flex flex-column gap-3 w-75 mx-auto mt-5 p-5 mb-3">
			<div class="no_print glow row bg-body w-100 rounded-3 px-3">
				<nav class="no_print navbar navbar-expand-lg fw-bold justify-content-end">
					<ul class="no_print navbar-nav nav-tabs">
						<li class="no_print nav-item">
							<a class="nav-link text-success" href="pdf.cfm">
								<img src="./images/pdf.png" width="40" height="40">
							</a>
						</li>
						<li class="no_print nav-item">
							<a class="nav-link text-success" href="xls.cfm">
								<img src="./images/xls.png" width="40" height="40">
							</a>
						</li>
						<li class="no_print nav-item">
							<button id="printbtn" class="nav-link text-success">
								<img src="./images/print.png" width="40" height="40">
							</button>
						</li>
					</ul>
				</nav>
			</div>
			<div class="row d-inline-flex w-100 flex-wrap justify-content-around">
				<div class="no_print col-7 col-md-3 rounded-start-3">
					<div class="glow card bg-body p-3">
						<img class="img-fluid rounded-circle img-card-top mx-auto d-block" src="./images/signup.png" alt="Address Book" width="150" height="150">
						<div class="card-body d-flex flex-column justify-contrnt-center">
							<cfoutput><p id="user" class="card-title text-center">#session.check[2]#</p></cfoutput>
							<button class="btn btn-outline-primary btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-whatever="add">Create Contact</button>
						</div>
					</div>
				</div>
				<div class="glow bg-body card flex-grow-1 d-flex col-auto flex-column p-3">
					<p class="h1 fw-bold text-center text-success mb-3">CONTACTS</p>
					<cfinclude template="logbook-list.cfm">
				</div>
			</div>
		</div>
		<cfinclude template="logbook-modal.cfm">
		<link href="./css/print.css" rel="stylesheet" media="print">
		<link href="./css/style.css" rel="stylesheet">
		<link href="./css/bootstrap.min.css" rel="stylesheet">
		<cfoutput><script type="text/javascript">let user = "#session.check[1]#";</script></cfoutput>
		<script type="text/javascript" src="./js/jQuery.js"></script>
		<script type="text/javascript" src="./js/logbook-script.js"></script>
		<script type="text/javascript" src="./js/bootstrap.min.js"></script>
		<script type="text/javascript" src="./js/bootstrap.bundle.min.js"></script>
	</body>
</html>