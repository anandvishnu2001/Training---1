<cfinclude template="logbook-modal-list-submit.cfm">
<div class="modal fade" id="listModal">
 	<div class="modal-dialog bg-body modal-lg modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header d-flex">
				<h2 class="modal-title flex-grow-1 fw-bold text-center text-primary">Create Contact</h2>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body">
				<form name="modalAdd" id="modal" class="d-flex flex-column was-validated gap-2" action="" method="post" enctype="multipart/form-data">
					<fieldset class="d-flex flex-column gap-3">
						<legend class="text-info">Personal Details<hr class="border-5"></legend>
						<div class="d-flex justify-content-between">
							<div class="form-floating col-3">
								<select class="form-select" id="title" name="title" required>
									<option value="" disabled selected>Select a title</option>
									<option value="1">Mr.</option>
									<option value="2">Ms.</option>
									<option value="3">Mrs.</option>
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
									<option value="" disabled selected>Select a gender</option>
									<option value="1">Male</option>
									<option value="2">Female</option>
									<option value="3">Other</option>
								</select>
								<label class="form-label" for="gender">Gender</label>
							</div>
							<div class="form-floating col-5">
								<input type="date" class="form-control" name="date_of_birth" id="date_of_birth" placeholder="" required>
								<label class="form-label" for="date_of_birth">Date of Birth</label>
							</div>
						</div>
						<div class="form-floating col-7">
							<input type="file" class="form-control" name="profile" id="profile" placeholder="" accept="image/*">
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
						<span id="feedback" class="text-center text-danger bg-warning invisible"></span>
						<button name="edit" id="create" type="submit" class="btn btn-success" form="modalAdd">Save</button>
					</fieldset>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>