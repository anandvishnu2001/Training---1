<cfinclude template="object.cfm">
<cfset record=manager.getList( url.logid )>
<cfoutput>
<div class="row d-flex">
	<div class="bg-secondary col-4 d-flex flex-column justify-content-stretch p-5">
		<img id="contact" class="img-fluid rounded-circle img-card-top d-block" src="./uploads/#record[url.logid].profile#" alt="Address Book">
	</div>
	<div class="bg-dark col-8 flex-grow-1 d-flex flex-column p-5 gap-2">
		<div class="row">
		<h2 class="text-primary col-4">Name:</h2>
		<h3 class="text-info col-auto" id="v-name">#record[url.logid].title[StructKeyList(record[url.logid].title)[1]]# #record[url.logid].firstname# #record[url.logid].lastname#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Gender:</h2>
			<h3 class="text-info col-auto" id="v-gender">#record[url.logid].gender[StructKeyList(record[url.logid].gender)[1]]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Date of Birth:</h2>
			<h3 class="text-info col-auto" id="v-dob">#record[url.logid].date_of_birth#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Address:</h2>
			<h3 class="text-info col-auto gap-1" id="v-address">#record[url.logid].house_flat#, <br>#record[url.logid].street#, <br>#record[url.logid].city#, <br>#record[url.logid].state#, <br>#record[url.logid].country#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Pincode:</h2>
			<h3 class="text-info col-auto" id="v-pincode">#record[url.logid].pincode#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Email:</h2>
			<h3 class="text-info col-auto" id="v-mail">#record[url.logid].email#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Phone:</h2>
			<h3 class="text-info col-auto" id="v-phone">#record[url.logid].phone#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Hobbies:</h2>
			<h3 class="text-info col-auto" id="v-hobbies">
				<cfloop list="#StructKeyList(record[url.logid].hobbies)#" item="i">
					#record[url.logid].hobbies[i]#
					<cfif i NEQ listLast(StructKeyList(record[url.logid].hobbies),",")>,<br></cfif>
				</cfloop>
			</h3>
		</div>
	</div>
</div></cfoutput>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="./js/jQuery.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>