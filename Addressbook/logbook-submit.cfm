<cfif structKeyExists(session,"check") AND session.check.access>
	<cfinvoke component="components.manager"
			method="selectSet"
			returnVariable="select">
	<cfif structKeyExists(form,"btn")>
		<cfset session.check.access = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
	<cfif error = arrayNew(1)>
	<cfif len(trim(form.title)) EQ 0>
		<cfset arrayAppend(error,"Title field to be selected")>
	<cfelse>
		<cfloop list="#structKeyList(select.title)#" item="i">
			<cfif NOT listFind(trim(form.title),i)>
				<cfset tflag=1>
			</cfif>
		</cfloop>
		<cfif tflag EQ 1>
			<cfset arrayAppend(error,"Selection of Title field is Invalid")>
		</cfif>
	</cfif>
	<cfif len(trim(form.firstname)) EQ 0>
		<cfset arrayAppend(error,"Firstname field is Empty")>
	<cfelseif NOT REFindNoCase("^[a-zA-Z]+$",form.firstname)>
		<cfset arrayAppend(error,"Input of Firstname field is Invalid")>
	</cfif>
	<cfif len(trim(form.lastname)) EQ 0>
		<cfset arrayAppend(error,"Lastname field is Empty")>
	<cfelseif NOT REFindNoCase("^[a-zA-Z]+$",form.lastname)>
		<cfset arrayAppend(error,"Input of Lastname field is Invalid")>
	</cfif>
	<cfif len(trim(form.gender)) EQ 0>
		<cfset arrayAppend(error,"Gender field to be selected")>
	<cfelse>
		<cfloop list="#structKeyList(select.gender)#" item="i">
			<cfif NOT listFind(trim(form.gender),i)>
				<cfset tflag=1>
			</cfif>
		</cfloop>
		<cfif tflag EQ 1>
			<cfset arrayAppend(error,"Selection of Gender field is Invalid")>
		</cfif>
	</cfif>
	<cfif></cfif>
	<cfif></cfif>
	<cfif len(trim(form.house_flat)) EQ 0>
		<cfset arrayAppend(error,"Lastname field is Empty")>
	<cfelseif NOT REFindNoCase("^[a-zA-Z\d]+$",form.house_flat)>
		<cfset arrayAppend(error,"Input of Lastname field is Invalid")>
	</cfif>
	<cfif></cfif>
	<cfif></cfif>
	<cfif></cfif>
	<cfif arrayLen(error) GT 0>
	<cfelse>
		<cfif structKeyExists(form,"addbtn")>
			<cfinclude template="imageadd.cfm">
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
			<cfinclude template="imageedit.cfm">
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
	<cfif structKeyExists(form,"deletebtn")>
		<cfset manager.deleteRecord( session.userid,
						form.d_id )>
	<cfelseif structKeyExists(form,"return")>
		<cflocation url="logbook.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>