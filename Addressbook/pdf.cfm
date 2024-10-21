<cfinclude template="object.cfm">
<cfset log = manager.getList()>
<cfheader name="Content-Disposition" value="attachment; filename=example.pdf">
<cfheader name="Content-Type" value="application/pdf">

<cfcontent type="application/pdf" reset="true">

