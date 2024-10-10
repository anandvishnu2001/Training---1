<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<div class="no-print glow w-100 row bg-body rounded-3 mb-3 px-3">
				<nav class="navbar navbar-expand-lg fw-bold justify-content-end">
					<ul class="navbar-nav nav-tabs w-50 flex-row justify-content-between">
					<li class="nav-item">
						<form id="plainTemplate" name="plainTemplate" action="" method="post">
							<button name="plainbtn" id="plainbtn" type="submit" class="btn btn-outline-success">
							</button>
						</form>
					</li>
					<li class="nav-item">
						<form id="plainTemplate" name="plainTemplate" action="" method="post">
							<button name="plainbtn" id="plainbtn" type="submit" class="btn btn-outline-success">
								Plain Template<img src="./images/xls-plain.png" width="40" height="40">
							</button>
						</form>
					</li>
					<li class="nav-item">
						<form id="dataTemplate" name="dataTemplate" action="" method="post">
							<button name="databtn" id="databtn" type="submit" class="btn btn-outline-success">
								Template with Data<img src="./images/xls-data.png" width="40" height="40">
							</button>
						</form>
					</li>
					</ul>
				</nav>
			</div>
			<div class="row d-flex w-100 gap-1 flex-wrap justify-content-around">
					<div class="no-print col-12 col-lg-3 h-25 glow card bg-body rounded-start-3 p-3">
						<img class="img-fluid rounded-circle img-card-top mx-auto d-block" src="./images/signup.png" alt="Address Book" width="200" height="200">
						<div class="card-body d-flex flex-column justify-content-center gap-1">
							<cfoutput><h3 id="user" class="card-title text-center text-info">#session.username#</h3></cfoutput>
			<form id="uploadExcel" name="uploadExcel" class="d-flex flex-column gap-1" action="" method="post" enctype="multipart/form-data">
				<div class="form-floating">
					<input type="file" name="upload" id="upload" class="form-control">
				</div>
				<button name="uploadbtn" id="uploadbtn" type="submit" class="btn btn-outline-success">Upload</button>
			</form>
						</div>
					</div>
				<div class="glow bg-body card flex-grow-1 d-flex col-8 flex-column p-3">
					<p class="h1 fw-bold text-center text-success mb-3">CONTACTS</p>
					<div class="table-responsive">
						<table class="table align-middle table-responsive table-borderless table-sm table-hover">	
							<thead>
								<th></th>
								<th class="header text-primary">Name</th>
								<th class="header text-primary">Email</th>
								<th class="header text-primary">Phone</th>
							</thead>
							<tbody name="contactList" id="contactList"></tbody>
						</table>
					</div>
				</div>
			</div>
		<link href="./css/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="./js/jQuery.js"></script>
		<script type="text/javascript" src="./js/logbook-script.js"></script>
		<script type="text/javascript" src="./js/bootstrap.min.js"></script>
</html>