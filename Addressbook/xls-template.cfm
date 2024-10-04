<cfinclude template="object.cfm">
<cfset log = manager.getList()>
<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Title",1,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Firstname",1,2)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Lastname",1,3)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Gender",1,4)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"DOB",1,5)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"House",1,6)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Street",1,7)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"City",1,8)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"State",1,9)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Country",1,10)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Pincode",1,11)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Email",1,12)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Phone",1,13)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Hobbies",1,14)>

<cfset head={color="gold",fgcolor="teal",bold="true",alignment="center",fontsize="13"}>

<cfset SpreadsheetFormatRow(spreadsheetObj,head,1)>

<cfset SpreadSheetSetColumnWidth(spreadsheetobj,1,6)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,2,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,3,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,4,8)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,5,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,6,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,7,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,8,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,9,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,10,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,11,10)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,12,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,13,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,14,35)>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Plain-Template.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >