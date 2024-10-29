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
        <cfif local.checkLog.recordCount NEQ 0>
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
        <cfargument  name="data" type="struct" required="true">
        <cfif arguments.data.action EQ "add">
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
                    <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                );
            </cfquery>
        <cfelseif arguments.data.action EQ "edit">
            <cfquery name="local.edit" datasource="shopping">
                UPDATE
                    category
                SET
                    name = <cfqueryparam value="#arguments.data.category#" cfsqltype="cf_sql_varchar">,
                    lasteditedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    lasteditedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    categoryid = <cfqueryparam value="#arguments.data.recordId#" cfsqltype="cf_sql_varchar">
            </cfquery>
        </cfif>
    </cffunction>

    <cffunction  name="modifySubcategory" access="public">
        <cfargument  name="data" type="struct" required="true">
        <cfif arguments.data.action EQ "add">
            <cfquery name="local.add" datasource="shopping">
                INSERT INTO
                    subcategory(
                        name,
                        categoryid,
                        status,
                        createdat,
                        createdby
                    )
                VALUES(
                    <cfqueryparam value="#arguments.data.subcategory#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.data.categorySelect#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                );
            </cfquery>
        </cfif>
    </cffunction>

    <cffunction  name="modifyProduct" access="public">
        <cfargument  name="data" type="struct" required="true">
        <cfif arguments.data.action EQ "add">
            <cfquery name="local.add" datasource="shopping">
                INSERT INTO
                    product(
                        name,
                        image,
                        description,
                        price,
                        subcategoryid,
                        status,
                        createdat,
                        createdby
                    )
                VALUES(
                    <cfqueryparam value="#arguments.data.product#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.data.image#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.data.description#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.data.price#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.data.subcategorySelect#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                );
            </cfquery>
        <cfelseif arguments.data.action EQ "edit">
        </cfif>
    </cffunction>

    <cffunction  name="getCategory" access="remote" returnFormat="JSON">
        <cfargument  name="category" type="string" required="false">
        <cfquery name="local.list" datasource="shopping">
            SELECT
                categoryid,
                name,
                createdat,
                createdby
            FROM
                category
            WHERE
                status = 1
            <cfif structKeyExists(arguments, 'category')>
                    AND categoryid = <cfqueryparam value="#arguments.category#" cfsqltype="cf_sql_integer">
            </cfif>
            ;
        </cfquery>
        <cfset local.output = []>
        <cfoutput query="local.list">
            <cfset arrayAppend(local.output, {
                "id" : local.list.categoryid,
                "name" : local.list.name,
                "createdat" : local.list.createdat,
                "createdby": local.list.createdby 
            })>
        </cfoutput>
        <cfreturn local.output>
    </cffunction>

    <cffunction  name="getSubcategory" access="remote" returnFormat="JSON">
        <cfargument  name="category" type="integer" required="true">
        <cfargument  name="subcategory" type="integer" required="false">
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
                status = 1
            AND
                categoryid = <cfqueryparam value="#arguments.category#" cfsqltype="cf_sql_integer">
                <cfif structKeyExists(arguments, 'subcategory')>
                    AND
                        name = <cfqueryparam value="#arguments.subcategory#" cfsqltype="cf_sql_varchar">
                </cfif>
            ;
        </cfquery>
        <cfset local.output = []>
        <cfoutput query="local.list">
            <cfset arrayAppend(local.output, {
                "id" : local.list.subcategoryid,
                "name" : local.list.name,
                "createdat" : local.list.createdat,
                "createdby": local.list.createdby,
                "category" : local.list.categoryid
            })>
        </cfoutput>
        <cfreturn local.output>
    </cffunction>

    <cffunction  name="getProduct" access="remote" returnFormat="JSON">
        <cfargument  name="subcategory" type="integer" required="true">
        <cfargument  name="product" type="integer" required="false">
        <cfquery name="local.list" datasource="shopping">
            SELECT
                productid,
                name,
                image,
                description,
                price,
                status,
                createdat,
                createdby,
                subcategoryid
            FROM
                product
            WHERE
                status = 1
            AND
                subcategoryid = <cfqueryparam value="#arguments.subcategory#" cfsqltype="cf_sql_integer">
                <cfif structKeyExists(arguments, 'product')>
                    AND
                        name = <cfqueryparam value="#arguments.product#" cfsqltype="cf_sql_varchar">
                </cfif>
            ;
        </cfquery>
        <cfset local.output = []>
        <cfoutput query="local.list">
            <cfset arrayAppend(local.output, {
                "id" : local.list.productid,
                "name" : local.list.name,
                "image" : local.list.image,
                "description" : local.list.description,
                "price" : local.list.price,
                "createdat" : local.list.createdat,
                "createdby": local.list.createdby,
                "subcategory" : local.list.subcategoryid
            })>
        </cfoutput>
        <cfreturn local.output>
    </cffunction>
</cfcomponent>