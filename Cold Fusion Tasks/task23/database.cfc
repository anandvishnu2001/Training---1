<cfcomponent>
	<cfif structKeyExists(form,"btn")>
		<cfquery name="local.InsertRecord" datasource="train">
			INSERT INTO 
				EMPLOYMENT(
					POSITION,
					RELOCATION,
					START_DATE,
					PORTFOLIO_WEB,
					RESUME,
					SALARY,
					NAME,
					EMAIL,
					PHONE
				)
			VALUES (
				"#form.position#",
				"#form.relocation#",
				"#form.start#",
				"#form.web#",
				"#form.resume#",
				#form.salary#,
				"#form.name#",
				"#form.email#",
				#form.phone#
			);
		</cfquery>
		Form submitted to Database Successfully!!!
	</cfif>
</cfcomponent>