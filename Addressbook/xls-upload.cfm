<cfinclude template="object.cfm">
<cfset log = manager.getList()>
<cfset theDir = expandPath('./uploads/')>

<cffile action="upload"
	filefield="form.upload"
	destination="#theDir#"
	nameConflict="makeunique">

<cfspreadsheet
	action="read"
	headerrow="1"
	excludeHeaderRow = "true"
	src="#expandPath('./uploads/')##cffile.ServerFile#"
	query="quer">
<cfdump var="#quer#">

<cfset quer.addColumn("Result","varchar",arrayNew(1))>

<cfoutput query="quer">
		<cfset pending = "">
		<cfif NOT queryKeyExists(quer,"title") OR len(quer.title) EQ 0>
			<cfset pending = pending & "Title,">
		<cfelse>
			<cfset tflag=0>
			<cfloop collection="#select.title#" item="i">
				<cfif select.title[i] EQ trim(quer.title)>
					<cfset qtitle=val(i)>
					<cfbreak>
				</cfif>
			</cfloop>
			<cfif NOT structKeyExists(variables,"qtitle")>
				<cfset pending = pending & "Title(Invalid),">
			</cfif>
		</cfif>
		<cfif NOT queryKeyExists(quer,"firstname") OR len(quer.firstname) EQ 0>
			<cfset pending = pending & "Firstname,">
		</cfif>
		<cfif NOT queryKeyExists(quer,"lastname") OR len(quer.lastname) EQ 0>
			<cfset pending = pending & "Lastname,">
		</cfif>
		<cfif NOT queryKeyExists(quer,"gender") OR len(quer.gender) EQ 0>
			<cfset pending = pending & "Gender,">
		<cfelse>
			<cfloop collection="#select.gender#" item="i">
				<cfif select.gender[i] EQ trim(quer.gender)>
					<cfset qgender=val(i)>
					<cfbreak>
				</cfif>
			</cfloop>
			<cfif NOT structKeyExists(variables,"qgender")>
				<cfset pending = pending & "Gender(Invalid),">
			</cfif>
		</cfif>
		<cfif NOT queryKeyExists(quer,"DOB") OR len(quer.DOB) EQ 0>
			<cfset pending = pending & "DOB,">
		<cfelseif NOT isDate(quer.DOB) OR (isDate(quer.DOB) AND quer.DOB GT now())>
			<cfset pending = pending & "DOB(Invalid),">
		</cfif>
		<cfif NOT queryKeyExists(quer,"house") OR len(quer.house) EQ 0>
			<cfset pending = pending & "House,">
		</cfif>
		<cfif NOT queryKeyExists(quer,"street") OR len(quer.street) EQ 0>
			<cfset pending = pending & "Street,">
		</cfif>
		<cfif NOT queryKeyExists(quer,"city") OR len(quer.city) EQ 0>
			<cfset pending = pending & "City,">
		</cfif>
		<cfif NOT queryKeyExists(quer,"state") OR len(quer.state) EQ 0>
			<cfset pending = pending & "State,">
		</cfif>
		<cfif NOT queryKeyExists(quer,"country") OR len(quer.country) EQ 0>
			<cfset pending = pending & "Country,">
		</cfif>
		<cfif NOT queryKeyExists(quer,"pincode") OR len(quer.pincode) EQ 0>
			<cfset pending = pending & "Pincode,">
		</cfif>
		<cfif NOT queryKeyExists(quer,"email") OR len(quer.email) EQ 0>
			<cfset pending = pending & "Email,">
		<cfelseif NOT REFindNoCase("^[\w]+@[\w]+\.[a-zA-Z]{2,}$",quer.email)>
			<cfset pending = pending & "Email(Invalid),">
		</cfif>
		<cfif NOT queryKeyExists(quer,"phone") OR len(quer.phone) EQ 0>
			<cfset pending = pending & "Phone,">
		<cfelseif NOT REFindNoCase("[0-9]{10}",quer.phone)>
			<cfset pending = pending & "Phone(Invalid),">
		</cfif>
		<cfif NOT queryKeyExists(quer,"hobbies") OR listLen(quer.hobbies) EQ 0>
			<cfset pending = pending & "Hobbies,">
		<cfelse>
			<cfset flag=0>
			<cfset hobby="">
			<cfloop list="#quer.hobbies#" index="i" item="k">
				<cfset tflag=0>
				<cfloop collection="#select.hobbies#" item="j">
					<cfif trim(select.hobbies[j]) EQ trim(k)>
						<cfset hobby = listAppend(hobby,j,",")>
						<cfset tflag=1>
						<cfbreak>
					</cfif>
				</cfloop>
				<cfif tflag NEQ 1>
					<cfset flag=1>
				</cfif>
			</cfloop>
			<cfif flag EQ 1>
				<cfset pending = pending & "Hobbies(Invalid),">
			</cfif>
		</cfif>
		<cfif listLen(pending) NEQ 0>
			<div class="bg-body d-flex flex-wrap mt-5 mx-3 pt-5">
				<cfoutput>
					<cfloop list="#pending#" index="i">
						<p class="border my-1 mx-2">#i##quer.firstname#</p>
					</cfloop>
				</cfoutput>
			</div>
			<cfset quer.setCell("Result",pending,quer.currentRow)>
		<cfelse>
			<cfset eflag=0>
			<cfloop collection="#log#" item="i">
				<cfif log[i].email EQ quer.email>
					<cfset eflag=1>
					<cfbreak>
				</cfif>
			</cfloop>
			<cfif eflag EQ 1>
				<cfset manager.updateContact( #i#,
						qtitle,
						quer.firstname,
						quer.lastname,
						qgender,
						dateformat(quer.DOB,"yyyy-mm-dd"),
						log[i].profile,
						quer.house,
						quer.street,
						quer.city,
						quer.state,
						quer.country,
						quer.pincode,
						quer.email,
						quer.phone,
						hobby )>
				<cfset quer.setCell("Result","updated",quer.currentRow)>
			<cfelse>
				<cfset manager.insertContact( qtitle,
						quer.firstname,
						quer.lastname,
						qgender,
						dateformat(quer.DOB,"yyyy-mm-dd"),
						"signup.png",
						quer.house,
						quer.street,
						quer.city,
						quer.state,
						quer.country,
						quer.pincode,
						quer.email,
						quer.phone,
						hobby )>
				<cfset quer.setCell("Result","added",quer.currentRow)>
			</cfif>
		</cfif>
</cfoutput>
<cfspreadsheet
	action="write"
	query="quer"
	filename="#theDir#output.xlsx"
	overwrite="true">

<cfset outputfile = SpreadsheetRead("#theDir#output.xlsx",1)>

<cfset binary = SpreadsheetReadBinary(outputfile)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Upload-Result.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#">