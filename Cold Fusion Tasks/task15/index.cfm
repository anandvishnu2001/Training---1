<cfinvoke component="product" method="multiply" returnVariable="result1">
	<cfinvokeargument name="arg1" value="1">
	<cfinvokeargument name="arg2" value="2">
</cfinvoke>
<cfobject component="product" name="instance1">
<cfset instance2 = createObject("component","product")>
<cfset result2 = instance1.multiply(1,2,3)>
<cfset result3 = instance1.multiply(1,2,3,4)>
<cfoutput>
	<b>multiply(1,2)</b> from <b>cfinvoke</b> is <b>#result1#</b><br>
	<b>multiply(1,2,3)</b> from <b>cfobject</b> is <b>#result2#</b><br>
	<b>multiply(1,2,3,4)</b> from <b>createobject</b> is <b>#result3#</b>
</cfoutput>