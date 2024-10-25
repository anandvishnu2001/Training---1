<cfcomponent>
    <cffunction  name="adminLogin" access="public">
        <cfargument  name="admin" type="string" required="true">
        <cfargument  name="password" type="string" required="true">
        <cfquery name="local.checkLog" datasource="shopping">
            SELECT
                adminid,
                name,
                email,
                status
            FROM
                admin
            WHERE
                name = <cfqueryparam value="#arguments.admin#" cfsqltype="cf_sql_varchar">
            AND
                password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif local.checkLog.recordCount EQ 0>
            <cfset session.check = {
                "access" = true,
                "admin" = local.checkLog.adminid,
                "name" = local.checkLog.name
            }>
        <cfelse>
            <cfset structClear(session.check)>
            <cfset session.check.access = false>
        </cfif>
    </cffunction>

    <cffunction  name="modifyCategory" access="public">
        <cfargument  name="action" type="string" required="true">
        <cfargument  name="data" type="struct" required="true">
        <cfif arguments.action EQ "add">
            <cfquery name="local.add" datasource="shopping">
                INSERT INTO
                    category(
                        name,
                        status,
                        createdat,
                        createdby
                    )
                VALUES(
                    <cfqueryparam value="#arguments.data.category#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
                    <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                )
            </cfquery>
        </cfif>
    </cffunction>

    <cffunction  name="getCategory" access="remote" returnFormat="JSON">
        <cfargument  name="category" type="string" required="false">
        <cfquery name="local.list" datasource="shopping">
            SELECT
                categoryid,
                name,
                status,
                createdat,
                createdby
            FROM
                category
            <cfif structKeyExists(arguments, 'category')>
                WHERE
                    name = <cfqueryparam value="#arguments.category#" cfsqltype="cf_sql_varchar">
            </cfif>
            ;
        </cfquery>
        <cfset local.output = []>
        <cfoutput query="local.list">
            <cfset arrayAppend(local.output, {
                "id" : local.list.categoryid,
                "name" : local.list.name,
                "status" : local.list.status,
                "createdat" : local.list.createdat,
                "createdby": local.list.createdby 
            })>
        </cfoutput>
        <cfreturn local.output>
    </cffunction>

    <cffunction  name="getSubcategory" access="remote" returnFormat="JSON">
        <cfargument  name="data" type="struct" required="true">
        <cfquery name="local.list" datasource="shopping">
            SELECT
                subcategoryid,
                name,
                status,
                createdat,
                createdby,
                categoryid
            FROM
                subcategory
            WHERE
                categoryid = <cfqueryparam value="#arguments.data.category#" cfsqltype="cf_sql_integer">
                <cfif structKeyExists(arguments.data, 'subcategory')>
                    AND name = <cfqueryparam value="#arguments.data.subcategory#" cfsqltype="cf_sql_varchar">
                </cfif>
            ;
        </cfquery>
        <cfoutput query="local.list">
            <cfset arrayAppend(local.output, {
                "id" : local.list.subcategoryid,
                "name" : local.list.name,
                "status" : local.list.status,
                "createdat" : local.list.createdat,
                "createdby": local.list.createdby,
                "category" : local.list.categoryid
            })>
        </cfoutput>
        <cfreturn local.output>
    </cffunction>

    <cffunction  name="getProduct" access="remote" returnFormat="JSON">
        <cfargument  name="data" type="struct" required="true">
        <cfquery name="local.list" datasource="shopping">
            SELECT
                productid,
                name,
                image,
                description,
                stock,
                price,
                status,
                createdat,
                createdby,
                subcategoryid
            FROM
                product
            WHERE
                subcategoryid = <cfqueryparam value="#arguments.data.subcategory#" cfsqltype="cf_sql_integer">
                <cfif structKeyExists(arguments.data, 'product')>
                    AND name = <cfqueryparam value="#arguments.data.product#" cfsqltype="cf_sql_varchar">
                </cfif>
            ;
        </cfquery>
        <cfoutput query="local.list">
            <cfset arrayAppend(local.output, {
                "id" : local.list.productid,
                "name" : local.list.name,
                "image" : local.list.image,
                "description" : local.list.description,
                "stock" : local.list.stock,
                "price" : local.list.price,
                "status" : local.list.status,
                "createdat" : local.list.createdat,
                "createdby": local.list.createdby,
                "subcategory" : local.list.subcategoryid
            })>
        </cfoutput>
        <cfreturn local.output>
    </cffunction>
</cfcomponent>