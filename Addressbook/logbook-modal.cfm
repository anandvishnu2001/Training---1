<div class="modal fade" id="modal">
 	<div class="contentEdit modal-dialog d-flex bg-body modal-lg modal-dialog-scrollable">
		<div class="card-body col-5 rounded-start-3 bg-secondary p-3 d-flex flex-column justify-content-stretch">
			<img id="contact" class="img-fluid rounded-circle img-card-top d-block" src="./images/signup.png" alt="Address Book">
		</div>
		<div class="modal-content flex-grow-1 d-flex p-3">
			<div class="modal-header d-flex">
				<h2 id="h-add" class="modal-title flex-grow-1 fw-bold text-center text-primary">Create Contact</h2>
				<h2 id="h-edit" class="modal-title flex-grow-1 fw-bold text-center text-primary">Edit Contact</h2>
				<h2 id="h-view" class="modal-title flex-grow-1 fw-bold text-center text-primary">Contact Details</h2>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="row modal-body d-flex justify-content-between">
				<form id="modalAdd" class="d-flex flex-column was-validation gap-2" action="" method="post" enctype="multipart/form-data">
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Personal Details<hr class="border-5"></legend>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-3">
								<select class="form-select invalid" id="a_title" name="a_title" required>
									<option value="" disabled selected>Select a title</option>
									<option value="1">Mr.</option>
									<option value="2">Ms.</option>
									<option value="3">Mrs.</option>
								</select>
								<label class="form-label" for="a_title">Title</label>
							</div>
							<div class="form-floating col-4">
								<input type="text" class="form-control" name="a_firstname" id="a_firstname" placeholder="" required>
								<label class="form-label" for="a_firstname">First name</label>
							</div>
							<div class="form-floating col-4">
								<input type="text" class="form-control" name="a_lastname" id="a_lastname" placeholder="" required>
								<label class="form-label" for="a_lastname">Last name</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<select class="form-select" id="a_gender" name="a_gender" required>
									<option value="" disabled selected>Select a gender</option>
									<option value="1">Male</option>
									<option value="2">Female</option>
									<option value="3">Other</option>
								</select>
								<label class="form-label" for="a_gender">Gender</label>
							</div>
							<div class="form-floating col-5">
								<input type="date" class="form-control" name="a_date_of_birth" id="a_date_of_birth" placeholder="" required>
								<label class="form-label" for="a_date_of_birth">Date of Birth</label>
							</div>
						</div>
						<div class="form-floating col-7">
							<input type="file" class="form-control" name="a_profile" id="a_profile" placeholder="" accept="image/*">
							<label class="form-label" for="a_profile">Profile Photo</label>
						</div>
					</fieldset>
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Contact Details<hr class="border-5"></legend>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="a_house_flat" id="a_house_flat" placeholder="" required>
								<label class="form-label" for="a_house_flat">House / Flat</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="a_street" id="a_street" placeholder="" required>
								<label for="a_street">Street</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="a_city" id="a_city" placeholder="" required>
								<label class="form-label" for="a_city">City</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="a_state" id="a_state" placeholder="" required>
								<label class="form-label" for="a_state">State</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="a_country" id="a_country" placeholder="" required>
								<label class="form-label" for="a_country">Country</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="a_pincode" id="a_pincode" placeholder="" required>
								<label class="form-label" for="a_pincode">Pincode</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="email" class="form-control" name="a_email" id="a_email" placeholder="" required>
								<label class="form-label" for="a_email">Email ID</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="a_phone" id="a_phone" pattern="[0-9]{10}" placeholder="" required>
								<label class="form-label" for="a_phone">Phone</label>
							</div>
						</div>
					</fieldset>
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Hobbies<hr class="border-5"></legend>
							<div class="form-floating col-3">
								<select multiple class="form-select" id="a_hobbies" name="a_hobbies" required>
									<option value="" disabled selected>Select a title</option>
									<option value="1">Sports</option>
									<option value="2">Cooking</option>
									<option value="3">Traveling</option>
									<option value="4">Dance</option>
									<option value="5">Music</option>
									<option value="6">Reading</option>
									<option value="7">Gardening</option>
									<option value="8">Painting/Drawing</option>
									<option value="9">Crafting</option>
									<option value="10">Photography</option>
								</select>
								<label class="form-label" for="a_hobbies">Title</label>
							</div>
					</fieldset>
					<button name="addbtn" id="addbtn" type="submit" class="btn btn-success">Save</button>
				</form>
				<form id="modalEdit" class="d-flex flex-column was-validated gap-2" action="" method="post" enctype="multipart/form-data">
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Personal Details<hr class="border-5"></legend>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-3">
								<select class="form-select" id="e_title" name="e_title" required>
									<option value="" disabled selected>Select a title</option>
									<option value="1">Mr.</option>
									<option value="2">Ms.</option>
									<option value="3">Mrs.</option>
								</select>
								<label class="form-label" for="e_title">Title</label>
							</div>
							<div class="form-floating col-4">
								<input type="text" class="form-control" name="e_firstname" id="e_firstname" placeholder="" required>
								<label class="form-label" for="e_firstname">First name</label>
							</div>
							<div class="form-floating col-4">
								<input type="text" class="form-control" name="e_lastname" id="e_lastname" placeholder="" required>
								<label class="form-label" for="e_lastname">Last name</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<select class="form-select" id="e_gender" name="e_gender" required>
									<option value="" disabled selected>Select a gender</option>
									<option value="1">Male</option>
									<option value="2">Female</option>
									<option value="3">Other</option>
								</select>
								<label class="form-label" for="e_gender">Gender</label>
							</div>
							<div class="form-floating col-5">
								<input type="date" class="form-control" name="e_date_of_birth" id="e_date_of_birth" placeholder="" required>
								<label class="form-label" for="e_date_of_birth">Date of Birth</label>
							</div>
						</div>
						<div class="form-floating col-7">
							<input type="file" class="form-control" name="e_profile" id="e_profile" placeholder="" accept="image/*">
							<label class="form-label" for="e_profile">Profile Photo</label>
						</div>
					</fieldset>
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Contact Details<hr class="border-5"></legend>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="e_house_flat" id="e_house_flat" placeholder="" required>
								<label class="form-label" for="e_house_flat">House / Flat</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="e_street" id="e_street" placeholder="" required>
								<label for="e_street">Street</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="e_city" id="e_city" placeholder="" required>
								<label class="form-label" for="e_city">City</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="e_state" id="e_state" placeholder="" required>
								<label class="form-label" for="e_state">State</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="e_country" id="e_country" placeholder="" required>
								<label class="form-label" for="e_country">Country</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" name="e_pincode" id="e_pincode" placeholder="" required>
								<label class="form-label" for="e_pincode">Pincode</label>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-5">
								<input type="email" class="form-control" name="e_email" id="e_email" placeholder="" required>
								<label class="form-label" for="e_email">Email ID</label>
							</div>
							<div class="form-floating col-5">
								<input type="text" class="form-control" 
									name="e_phone" id="e_phone" pattern="[0-9]{10}" placeholder="" required>
								<label class="form-label" for="e_phone">Phone</label>
							</div>
						</div>
					</fieldset>
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Hobbies<hr class="border-5"></legend>
							<div class="form-floating col-3">
								<select multiple class="form-select" id="e_hobbies" name="e_hobbies" width="20" required>
									<option value="" disabled selected></option>
									<option value="1">Sports</option>
									<option value="2">Cooking</option>
									<option value="3">Traveling</option>
									<option value="4">Dance</option>
									<option value="5">Music</option>
									<option value="6">Reading</option>
									<option value="7">Gardening</option>
									<option value="8">Painting/Drawing</option>
									<option value="9">Crafting</option>
									<option value="10">Photography</option>
								</select>
								<label class="form-label" for="e_hobbies">Title</label>
							</div>
					</fieldset>
					<input type="hidden" name="e_id" id="e_id">
					<button name="editbtn" id="editbtn" type="submit" class="btn btn-success">Save</button>
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
                    		</div>
			</div>
		</div>
	</div>
	<div class="contentDelete modal-dialog bg-body">
		<div class="modal-content flex-grow-1 d-flex p-3">
			<div class="modal-header d-flex">
				<h2 id="h-add" class="modal-title flex-grow-1 fw-bold text-center text-warning">Are you sure you want to delete this contact?</h2>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<form id="confirmDelete" name="confirmDelete" class="d-flex flex-column" action="" method="post">
				<input type="hidden" name="d_id" id="d_id">
				<div class="d-flex justify-content-between">
					<button name="deletebtn" id="deletebtn" type="submit" class="btn btn-outline-success">Yes</button>
					<button name="return" id="return" type="submit" class="btn btn-outline-danger">No</button>
				</div>
			<form>
		</div>
	</div>
</div>