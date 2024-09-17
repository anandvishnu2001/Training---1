<cfinclude template="object.cfm">
<cfparam name="form.id" default="">
<cfset record=manager.getView( session.userid,
				form.id )>
<cfoutput>
<div class="d-flex">
	<div class="bg-secondary d-flex flex-column justify-content-stretch p-5">
		<img id="contact" class="img-fluid rounded-circle img-card-top d-block" src="./uploads/#record[4]#" alt="Address Book">
	</div>
	<div class="bg-dark flex-grow-1 d-flex flex-column p-5 gap-2">
		<div class="row">
		<h2 class="text-primary col-4">Name:</h2>
		<h3 class="text-info col-auto" id="v-name">#record[1]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Gender:</h2>
			<h3 class="text-info col-auto" id="v-gender">#record[2]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Date of Birth:</h2>
			<h3 class="text-info col-auto" id="v-dob">#record[3]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Address:</h2>
			<h3 class="text-info col-auto gap-1" id="v-address">#record[5]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Pincode:</h2>
			<h3 class="text-info col-auto" id="v-pincode">#record[6]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Email:</h2>
			<h3 class="text-info col-auto" id="v-mail">#record[7]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Phone:</h2>
			<h3 class="text-info col-auto" id="v-phone">#record[8]#</h3>
		</div>
	</div>
</div></cfoutput>
<cfinclude template="include.cfm">