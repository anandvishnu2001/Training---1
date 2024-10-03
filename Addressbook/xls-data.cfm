<cfinclude template="object.cfm">
<cfset log = manager.getList()>
<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"#session.username#",1,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"#DateFormat(now(),"long")#",1,15)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Profile",2,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Title",2,2)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Firstname",2,3)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Lastname",2,4)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Gender",2,5)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"DOB",2,6)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"House",2,7)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Street",2,8)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"City",2,9)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"State",2,10)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Country",2,11)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Pincode",2,12)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Email",2,13)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Phone",2,14)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Hobbies",2,15)>

<cfset SpreadsheetMergeCells(spreadsheetObj,1,1,1,14)>

<cfset title={color="dark_red",fgcolor="aqua",bold="true",alignment="center",fontsize="23"}>
<cfset date={fgcolor="aqua",bold="true",alignment="right",verticalalignment="vertical_top"}>
<cfset head={color="gold",fgcolor="teal",bold="true",alignment="center",fontsize="13"}>

<cfset SpreadsheetFormatCell(spreadsheetObj,title,1,1)>
<cfset SpreadsheetFormatCell(spreadsheetObj,date,1,15)>
<cfset SpreadsheetFormatRow(spreadsheetObj,head,2)>

<cfset SpreadSheetSetColumnWidth(spreadsheetobj,1,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,2,6)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,3,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,4,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,5,8)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,6,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,7,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,8,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,9,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,10,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,11,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,12,10)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,13,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,14,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,15,35)>

<cfset j=1>
<cfloop collection="#log#" item="i">
	<cfset image = expandPath("uploads/#log[i].profile#")>
	<cfset SpreadsheetSetRowHeight(spreadsheetObj,j+2,40)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"uploads/#log[i].profile#",j+2,1) />
    	<cfset SpreadsheetAddImage(spreadsheetObj,image,"#j+2#,1,#j+3#,2")>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].title[StructKeyList(log[i].title)[1]]#",j+2,2)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].firstname#",j+2,3)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].lastname#",j+2,4)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].gender[StructKeyList(log[i].gender)[1]]#",j+2,5)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].date_of_birth#",j+2,6)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].house_flat#",j+2,7)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].street#",j+2,8)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].city#",j+2,9)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].state#",j+2,10)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].country#",j+2,11)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].pincode#",j+2,12)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].email#",j+2,13)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].phone#",j+2,14)>
	<cfset hobbies="">
	<cfloop list="#StructKeyList(log[i].hobbies)#" item="k">
		<cfset hobbies&="#log[i].hobbies[k]#">
		<cfif k NEQ listLast(StructKeyList(log[i].hobbies),",")>
			<cfset hobbies&=", ">
		</cfif>
	</cfloop>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#hobbies#",j+2,15)>
	<cfset j++>
</cfloop>
<cfloop from="3" to="#3+structCount(log)#" index="i">
	<cfif i%2 EQ 0>
		<cfset SpreadsheetFormatRow(spreadsheetObj,{fgcolor="grey_25_percent",verticalalignment="vertical_center"},i)>
	</cfif>
</cfloop>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-DataIncluded-Template.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#">