<cfinclude template="object.cfm">
<cfset record=manager.getList( session.userid,
				url.id )>
<cfoutput>
<div class="d-flex">
	<div class="bg-secondary d-flex flex-column justify-content-stretch p-5">
		<img id="contact" class="img-fluid rounded-circle img-card-top d-block" src="./uploads/#record[url.id].PROFILE#" alt="Address Book">
	</div>
	<div class="bg-dark flex-grow-1 d-flex flex-column p-5 gap-2">
		<div class="row">
		<h2 class="text-primary col-4">Name:</h2>
		<h3 class="text-info col-auto" id="v-name">#record[url.id].TITLE[StructKeyList(record[url.id].TITLE)[1]]# #record[url.id].FIRSTNAME# #record[url.id].LASTNAME#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Gender:</h2>
			<h3 class="text-info col-auto" id="v-gender">#record[url.id].GENDER[StructKeyList(record[url.id].GENDER)[1]]#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Date of Birth:</h2>
			<h3 class="text-info col-auto" id="v-dob">#record[url.id].DATE_OF_BIRTH#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Address:</h2>
			<h3 class="text-info col-auto gap-1" id="v-address">#record[url.id].HOUSE_FLAT#, <br>#record[url.id].STREET#, <br>#record[url.id].CITY#, <br>#record[url.id].STATE#, <br>#record[url.id].COUNTRY#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Pincode:</h2>
			<h3 class="text-info col-auto" id="v-pincode">#record[url.id].PINCODE#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Email:</h2>
			<h3 class="text-info col-auto" id="v-mail">#record[url.id].EMAIL#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Phone:</h2>
			<h3 class="text-info col-auto" id="v-phone">#record[url.id].PHONE#</h3>
		</div>
		<div class="row">
			<h2 class="text-primary col-4">Hobbies:</h2>
			<h3 class="text-info col-auto" id="v-hobbies">
				<cfloop list="#StructKeyList(record[url.id].HOBBIES)#" item="i">
					#record[url.id].HOBBIES[i]#
					<cfif i NEQ listLast(StructKeyList(record[url.id].HOBBIES),",")>,<br></cfif>
				</cfloop>
			</h3>
		</div>
	</div>
</div></cfoutput>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="./js/jQuery.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>