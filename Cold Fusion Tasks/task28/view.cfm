<cfset page = createObject('component','manager')>
<cfset info = page.getPageInfo(#url.value#)>
<cfoutput query="info">
	<h1 align="center">#pageid#</h1>
	<h2 align="center">#pagename#</h2>
	<h3 align="center">#pagedescs#</h3>
</cfoutput>