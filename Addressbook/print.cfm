<cfinclude template="object.cfm">
<cfset record=manager.getList( session.userid,
				url.id )>
<cfset rrr=structGetMetaData(record)>
<cfdump var="#rrr#">
<cfoutput>
<div class="row d-flex">
	<div class="bg-secondary col-4 d-flex flex-column justify-content-stretch p-5">
		<img id="contact" class="img-fluid rounded-circle img-card-top d-block" src="./uploads/#record[url.id].profile#" alt="Address Book">
	</div>
	<div class="bg-dark col-8 flex-grow-1 d-flex flex-column p-5 gap-2">
		<div class="row">
		<h2 class="text-primary col-4">Name:</h2>
		<h3 class="text-info col-auto" id="v-name">#record[url.id].title[StructKeyList(record[url.id].title)[1]]# #record[url.id].firstname# #record[url.id].lastname#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Gender:</h2>
			<h3 class="text-info col-auto" id="v-gender">#record[url.id].gender[StructKeyList(record[url.id].gender)[1]]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Date of Birth:</h2>
			<h3 class="text-info col-auto" id="v-dob">#record[url.id].date_of_birth#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Address:</h2>
			<h3 class="text-info col-auto gap-1" id="v-address">#record[url.id].house_flat#, <br>#record[url.id].street#, <br>#record[url.id].city#, <br>#record[url.id].state#, <br>#record[url.id].country#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Pincode:</h2>
			<h3 class="text-info col-auto" id="v-pincode">#record[url.id].pincode#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Email:</h2>
			<h3 class="text-info col-auto" id="v-mail">#record[url.id].email#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Phone:</h2>
			<h3 class="text-info col-auto" id="v-phone">#record[url.id].phone#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Hobbies:</h2>
			<h3 class="text-info col-auto" id="v-hobbies">
				<cfloop list="#StructKeyList(record[url.id].hobbies)#" item="i">
					#record[url.id].hobbies[i]#
					<cfif i NEQ listLast(StructKeyList(record[url.id].hobbies),",")>,<br></cfif>
				</cfloop>
			</h3>
		</div>
	</div>
</div></cfoutput>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="./js/jQuery.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>