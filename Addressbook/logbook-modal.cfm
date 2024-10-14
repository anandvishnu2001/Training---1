<div class="modal fade" id="modal">
 	<div class="contentEdit modal-dialog d-flex bg-body modal-lg modal-dialog-scrollable">
		<div class="card-body col-5 rounded-start-3 bg-secondary p-3 d-flex flex-column justify-content-stretch">
			<img id="contact" class="img-fluid rounded-circle img-card-top d-block" src="./images/signup.png" alt="Contact">
		</div>
		<div class="modal-content flex-grow-1 d-flex p-3">
			<div class="modal-header d-flex">
				<h2 id="moadlhead" class="modal-title flex-grow-1 fw-bold text-center text-primary"></h2>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="row modal-body d-flex justify-content-between">
				<form id="modalForm" class="d-flex flex-column gap-2" action="" method="post" enctype="multipart/form-data">
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Personal Details<hr class="border-5"></legend>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-3">
								<select class="form-select invalid" id="title" name="title" required>
									<option value="" disabled selected></option>
									<cfloop list="#structKeyList(select.title)#" item="i">
										<cfoutput><option value="#i#">#select.title[i]#</option></cfoutput>
									</cfloop>
								</select>
								<label class="form-label" for="title">Title</label>
							</div>
							<div class="form-floating col-4">
								<input type="text" class="form-control" name="firstname" id="firstname" placeholder="" required>
								<label class="form-label" for="firstname">First name</label>
							</div>
							<div class="form-floating col-4">
								<input type="text" class="form-control" name="lastname" id="lastname" placeholder="" required>
								<label class="form-label" for="lastname">Last name</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<select class="form-select" id="gender" name="gender" required>
									<option value="" disabled selected></option>
									<cfloop list="#structKeyList(select.gender)#" item="i">
										<cfoutput><option value="#i#">#select.gender[i]#</option></cfoutput>
									</cfloop>
								</select>
								<label class="form-label" for="gender">Gender</label>
							</div>
							<div class="form-floating col-5">
								<input type="date" class="form-control" name="date_of_birth" id="date_of_birth" placeholder="" required>
								<label class="form-label" for="date_of_birth">Date of Birth</label>
							</div>
						</div>
						<div class="form-floating col-7">
							<input type="file" class="form-control" name="profile" id="profile" placeholder="" accept="image/*" required>
							<label class="form-label" for="profile">Profile Photo</label>
						</div>
					</fieldset>
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Contact Details<hr class="border-5"></legend>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="house_flat" id="house_flat" placeholder="" required>
								<label class="form-label" for="house_flat">House / Flat</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="street" id="street" placeholder="" required>
								<label for="street">Street</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="city" id="city" placeholder="" required>
								<label class="form-label" for="city">City</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="state" id="state" placeholder="" required>
								<label class="form-label" for="state">State</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="country" id="country" placeholder="" required>
								<label class="form-label" for="country">Country</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="pincode" id="pincode" placeholder="" required>
								<label class="form-label" for="pincode">Pincode</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="email" class="form-control" name="email" id="email" placeholder="" required>
								<label class="form-label" for="email">Email ID</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="phone" id="phone" pattern="[0-9]{10}" placeholder="" required>
								<label class="form-label" for="phone">Phone</label>
							</div>
						</div>
					</fieldset>
					<fieldset class="d-flex flex-column">
						<legend class="text-info">Hobbies<hr class="border-5"></legend>
							<div class="col-8">
								<select multiple class="form-select" id="hobbies" name="hobbies" required>
									<option value="" disabled selected></option>
									<cfloop list="#structKeyList(select.hobbies)#" item="i">
										<cfoutput><option value="#i#">#select.hobbies[i]#</option></cfoutput>
									</cfloop>
								</select>
							</div>
					</fieldset>
					<input name="id" id="id" type="hidden">
					<button name="modalbtn" id="modalbtn" type="submit" class="btn btn-success mt-5"></button>
				</form>
				<div id="modalView" class="d-flex flex-column gap-2">
                        		<div class="row">
						<h4 class="text-primary col-4">Name:</h4>
						<h5 class="text-info col-auto" id="v-name"></h5>
					</div>
					<div class="row">
						<h4 class="text-primary col-4">Gender:</h4>
						<h5 class="text-info col-auto" id="v-gender"></h5>
					</div>
					<div class="row">
						<h4 class="text-primary col-4">Date of Birth:</h4>
						<h5 class="text-info col-auto" id="v-dob"></h5>
					</div>
					<div class="row">
						<h4 class="text-primary col-4">Address:</h4>
						<h5 class="text-info col-auto gap-1" id="v-address"></h5>
					</div>
					<div class="row">
						<h4 class="text-primary col-4">Pincode:</h4>
						<h5 class="text-info col-auto" id="v-pincode"></h5>
					</div>
					<div class="row">
						<h4 class="text-primary col-4">Email:</h4>
						<h5 class="text-info col-auto" id="v-mail"></h5>
					</div>
					<div class="row">
						<h4 class="text-primary col-4">Phone:</h4>
						<h5 class="text-info col-auto" id="v-phone"></h5>
					</div>
					<div class="row">
						<h4 class="text-primary col-4">Hobbies:</h4>
						<h5 class="text-info col-auto" id="v-hobbies"></h5>
					</div>
                    		</div>
			</div>
		</div>
	</div>
	<div class="contentUpload modal-dialog bg-body">
		<div class="modal-content flex-grow-1 d-flex p-3">
			<div class="modal-header d-flex">
				<h2 id="uploadhead" class="modal-title flex-grow-1 fw-bold text-center text-warning">Upload Excel Sheet</h2>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<nav class="navbar navbar-expand-lg my-3 fw-bold justify-content-center">
				<ul class="navbar-nav nav-pills w-100 justify-content-between">
					<li class="nav-item">
							<a name="plainbtn" id="plainbtn" class="btn btn-outline-success fw-bold" href="xls.cfm?action=plain">
								Plain Template<img src="./images/xls-plain.png" width="40" height="40">
							</a>
					</li>
					<li class="nav-item">
						<form id="dataTemplate" name="dataTemplate" action="" method="post">
							<a name="databtn" id="databtn" class="btn btn-outline-success fw-bold" href="xls.cfm?action=data">
								Template with Data<img src="./images/xls-data.png" width="40" height="40">
							</a>
						</form>
					</li>
				</ul>
			</nav>
			<form id="uploadExcel" name="uploadExcel" class="d-flex flex-column gap-1" action="" method="post" enctype="multipart/form-data">
				<div class="form-floating">
					<input type="file" name="upload" id="upload" class="form-control" required>
				</div>
				<button name="uploadbtn" id="uploadbtn" type="submit" class="btn btn-outline-success fw-bold">
					Update Template <img src="./images/xls-data.png" width="40" height="40">
				</button>
			</form>
		</div>
	</div>
	<div class="contentDelete modal-dialog bg-body">
		<div class="modal-content flex-grow-1 d-flex p-3">
			<div class="modal-header d-flex">
				<h2 id="deletehead" class="modal-title flex-grow-1 fw-bold text-center text-warning">Are you sure you want to delete this contact?</h2>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<form id="confirmDelete" name="confirmDelete" class="d-flex flex-column" action="" method="post">
				<input type="hidden" name="d_id" id="d_id">
				<div class="d-flex justify-content-between">
					<button name="deletebtn" id="deletebtn" type="submit" class="btn btn-outline-success">Yes</button>
					<button name="return" id="return" type="submit" class="btn btn-outline-danger">No</button>
				</div>
			</form>
		</div>
	</div>
</div>