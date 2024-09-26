<cfif structKeyExists(session,"check") AND session.check.access>
	<cfinvoke component="components.manager"
			method="selectSet"
			returnVariable="select">
	<cfif structKeyExists(form,"btn")>
		<cfset session.check.access = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
	<cfset error = arrayNew(1)>
	<cfif structKeyExists(form,"addbtn") OR structKeyExists(form,"editbtn")>
		<cfif structKeyExists(form,"title")>
			<cfif len(form.title) EQ 0>
				<cfset arrayAppend(error,"*Title field to be selected")>
			<cfelse>
				<cfif NOT listFind(structKeyList(select.title),trim(form.title))>
					<cfset arrayAppend(error,"*Selection of Title field is Invalid")>
				</cfif>
			</cfif>
		<cfelse>
			<cfset arrayAppend(error,"*Title field to be selected")>
		</cfif>
		<cfif len(form.firstname) EQ 0>
			<cfset arrayAppend(error,"*Firstname field is Empty")>
		</cfif>
		<cfif len(form.lastname) EQ 0>
			<cfset arrayAppend(error,"*Lastname field is Empty")>
		</cfif>
		<cfif structKeyExists(form,"gender")>
			<cfif len(form.gender) EQ 0>
				<cfset arrayAppend(error,"*Gender field to be selected")>
			<cfelse>
				<cfif NOT listFind(structKeyList(select.gender),trim(form.gender))>
					<cfset arrayAppend(error,"Selection of Gender field is Invalid")>
				</cfif>
			</cfif>
		<cfelse>
			<cfset arrayAppend(error,"*Gender field to be selected")>
		</cfif>
		<cfif len(form.date_of_birth) EQ 0>
			<cfset arrayAppend(error,"*Date_of_birth field is Empty")>
		<cfelse>
			<cfif (NOT isDate(form.date_of_birth)) AND CreateDateTime(year(form.date_of_birth),month(form.date_of_birth),day(form.date_of_birth)) GT now()>
				<cfset arrayAppend(error,"Input of Date_of_birth field is Invalid")>
			</cfif>
		</cfif>
		<cfif len(form.profile) EQ 0>
			<cfset arrayAppend(error,"*Profile pic field is Empty")>
		<cfelse>
			<cfinclude template="imageedit.cfm">
			<cfset ext = "jpg,jpeg,png,gif,bmp,tiff">
			<cfif NOT listFindNoCase(ext,listLast(filename,"."))>
				<cfset arrayAppend(error,"Input of Profile pic field is Invalid")>
			</cfif>
		</cfif>
		<cfif len(form.house_flat) EQ 0>
			<cfset arrayAppend(error,"*House_flat field is Empty")>
		</cfif>
		<cfif len(form.street) EQ 0>
			<cfset arrayAppend(error,"*Street field is Empty")>
		</cfif>
		<cfif len(form.city) EQ 0>
			<cfset arrayAppend(error,"*City field is Empty")>
		</cfif>
		<cfif len(form.state) EQ 0>
			<cfset arrayAppend(error,"*State field is Empty")>
		</cfif>
		<cfif len(form.country) EQ 0>
			<cfset arrayAppend(error,"*Country field is Empty")>
		</cfif>
		<cfif len(form.pincode) EQ 0>
			<cfset arrayAppend(error,"*Pincode field is Empty")>
		</cfif>
		<cfif len(form.email) EQ 0>
			<cfset arrayAppend(error,"*Email field is Empty")>
		<cfelseif NOT REFindNoCase("^[\w]+@[\w]+\.[a-zA-Z]{2,}$",form.email)>
			<cfset arrayAppend(error,"Input of Email field is Invalid")>
		</cfif>
		<cfif len(form.phone) EQ 0>
			<cfset arrayAppend(error,"*Phone field is Empty")>
		<cfelseif NOT REFindNoCase("[0-9]{10}",form.phone)>
			<cfset arrayAppend(error,"*Input of Phone field is Invalid")>
		</cfif>
		<cfif structKeyExists(form,"hobbies")>
			<cfif listLen(form.hobbies) EQ 0>
				<cfset arrayAppend(error,"*Hobbies field to be selected")>
			<cfelse>
				<cfset tflag=0>
				<cfloop list="#form.hobbies#" item="i">
					<cfif NOT listFind(structKeyList(select.hobbies),i)>
						<cfset tflag=1>
					</cfif>
				</cfloop>
				<cfif tflag EQ 1>
					<cfset arrayAppend(error,"*Selection of Hobbies field is Invalid")>
				</cfif>
			</cfif>
		<cfelse>
			<cfset arrayAppend(error,"*Hobbies field to be selected")>
		</cfif>
		<cfif arrayLen(error) GT 0>
			<div class="bg-body d-flex flex-wrap mt-5 mx-3 pt-5">
				<cfoutput>
					<cfloop array="#error#" index="i">
						<p class="border my-1 mx-2">#i#</p>
					</cfloop>
				</cfoutput>
			</div>
		<cfelse>
			<cfif structKeyExists(form,"addbtn")>
				<cfset manager.insertContact( session.userid,
								form.title,
								form.firstname,
								form.lastname,
								form.gender,
								form.date_of_birth,
								filename,
								form.house_flat,
								form.street,
								form.city,
								form.state,
								form.country,
								form.pincode,
								form.email,
								form.phone,
								form.hobbies )>
			</cfif>
			<cfif structKeyExists(form,"editbtn")>
				<cfset manager.updateContact( session.userid,
								form.id,
								form.title,
								form.firstname,
								form.lastname,
								form.gender,
								form.date_of_birth,
								filename,
								form.house_flat,
								form.street,
								form.city,
								form.state,
								form.country,
								form.pincode,
								form.email,
								form.phone,
								form.hobbies )>
			</cfif>
		</cfif>
	</cfif>
	<cfif structKeyExists(form,"deletebtn")>
		<cfset manager.deleteRecord( session.userid,
						form.d_id )>
	<cfelseif structKeyExists(form,"return")>
		<cflocation url="logbook.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>