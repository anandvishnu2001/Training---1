<cfinclude template="object.cfm">
<cfset record=manager.getList( url.logid )>
<cfoutput>
<div class="row d-flex">
	<div class="bg-secondary col-4 d-flex flex-column justify-content-stretch p-5">
		<img id="contact" class="img-fluid rounded-circle img-card-top d-block" src="./uploads/#record[1].profile#" alt="Address Book">
	</div>
	<div class="bg-dark col-8 flex-grow-1 d-flex flex-column p-5 gap-2">
		<div class="row">
		<h2 class="text-primary col-4">Name:</h2>
		<h3 class="text-info col-auto" id="v-name">#record[1].title.value# #record[1].firstname# #record[1].lastname#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Gender:</h2>
			<h3 class="text-info col-auto" id="v-gender">#record[1].gender.value#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Date of Birth:</h2>
			<h3 class="text-info col-auto" id="v-dob">#record[1].date_of_birth#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Address:</h2>
			<h3 class="text-info col-auto gap-1" id="v-address">#record[1].house_flat#, <br>#record[1].street#, <br>#record[1].city#, <br>#record[1].state#, <br>#record[1].country#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Pincode:</h2>
			<h3 class="text-info col-auto" id="v-pincode">#record[1].pincode#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Email:</h2>
			<h3 class="text-info col-auto" id="v-mail">#record[1].email#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Phone:</h2>
			<h3 class="text-info col-auto" id="v-phone">#record[1].phone#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Hobbies:</h2>
			<h3 class="text-info col-auto" id="v-hobbies">
				<cfloop array="#record[1].hobbies#" index="i" item="j">
					#j.value#
					<cfif i NEQ arrayLen(record[1].hobbies)>,<br></cfif>
				</cfloop>
			</h3>
		</div>
	</div>
</div></cfoutput>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="./js/jQuery.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>