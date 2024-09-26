<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
	<head>
		<link href="./css/print.css" rel="stylesheet" media="print">
		<link href="./css/style.css" rel="stylesheet">
		<link href="./css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="container-fluid d-flex flex-column align-items-center">
		<cfinclude template="object.cfm">
		<cfinclude template="logbook-submit.cfm">
		<nav class="no-print navbar navbar-expand-sm navbar-dark bg-info fixed-top">
			<div class="container-fluid fw-bold">
				<a class="navbar-brand text-primary" href="./index.cfm">
					<img src="./images/logbook.png" width="40" height="40">
					Address Book
				</a>
				<ul class="navbar-nav nav-tabs">
					<li class="nav-item">
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
		<div class="container d-inline-flex flex-column gap-3 w-100 mx-auto mt-5 p-5 mb-3">
			<div class="no-print glow row bg-body w-100 rounded-3 px-3">
				<nav class="navbar navbar-expand-lg fw-bold justify-content-end">
					<ul class="navbar-nav nav-tabs">
						<li class="nav-item">
							<a class="nav-link text-success" href="pdf.cfm">
								<img src="./images/pdf.png" width="40" height="40">
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-success" href="xls.cfm">
								<img src="./images/xls.png" width="40" height="40">
							</a>
						</li>
						<li class="nav-item">
							<button id="printbtn" class="nav-link text-success">
								<img src="./images/print.png" width="40" height="40">
							</button>
						</li>
					</ul>
				</nav>
			</div>
			<div class="row d-inline-flex w-100 flex-wrap justify-content-around">
				<div class="no-print col-6 col-md-3 rounded-start-3">
					<div class="glow card bg-body p-3">
						<img class="img-fluid rounded-circle img-card-top mx-auto d-block" src="./images/signup.png" alt="Address Book" width="200" height="200">
						<div class="card-body d-flex flex-column justify-content-center">
							<cfoutput><h3 id="user" class="card-title text-center text-info">#session.username#</h3></cfoutput>
							<button class="btn btn-outline-primary btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="add">Create Contact</button>
						</div>
					</div>
				</div>
				<div class="glow bg-body card flex-grow-1 d-flex col-auto flex-column p-3">
					<p class="h1 fw-bold text-center text-success mb-3">CONTACTS</p>
					<div class="table-responsive">
						<cfinclude template="logbook-list.cfm">
					</div>
				</div>
			</div>
		</div>
		<cfinclude template="logbook-modal.cfm">
		<cfinclude template="logbook-include.cfm">
	</body>
</html>