<cfinclude template="object.cfm">
<cfset log = manager.getList(session.userid)>
<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"#session.username#",1,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"#DateFormat(now(),"long")#",1,5)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"",2,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"NAME",2,2)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"EMAIL",2,3)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"PHONE",2,4)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"HOBBIES",2,5)>

<cfset SpreadsheetMergeCells(spreadsheetObj,1,1,1,4)>

<cfset title={color="dark_red",fgcolor="aqua",bold="true",alignment="center",fontsize="23"}>
<cfset date={fgcolor="aqua",bold="true",alignment="right",verticalalignment="vertical_top"}>
<cfset head={color="gold",fgcolor="teal",bold="true",alignment="center",fontsize="20"}>

<cfset SpreadsheetFormatCell(spreadsheetObj,title,1,1)>
<cfset SpreadsheetFormatCell(spreadsheetObj,date,1,5)>
<cfset SpreadsheetFormatRow(spreadsheetObj,head,2)>
<cfset j=1>
<cfloop collection="#log#" item="i">
	<cfset image = expandPath("uploads/#log[i].profile#")>
	<cfset SpreadsheetSetRowHeight(spreadsheetObj,j+2,50)>
    	<cfset SpreadsheetAddImage(spreadsheetObj,image,"#j+2#,1,#j+3#,2")>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].title[StructKeyList(log[i].title)[1]]# #log[i].firstname# #log[i].lastname#",j+2,2)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,2,20)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].email#",j+2,3)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,3,30)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].phone#",j+2,4)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,4,15)>
	<cfset hobbies="">
	<cfloop list="#StructKeyList(log[i].hobbies)#" item="k">
		<cfset hobbies&="#log[i].hobbies[k]#">
		<cfif k NEQ listLast(StructKeyList(log[i].hobbies),",")>
			<cfset hobbies&=", ">
		</cfif>
	</cfloop>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#hobbies#",j+2,5)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,5,50)>
	<cfset j++>
</cfloop>
<cfloop from="3" to="#3+structCount(log)#" index="i">
	<cfif i%2 EQ 0>
		<cfset SpreadsheetFormatRow(spreadsheetObj,{fgcolor="grey_25_percent",verticalalignment="vertical_center"},i)>
	</cfif>
</cfloop>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >