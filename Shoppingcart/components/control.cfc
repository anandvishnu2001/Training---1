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

    <cffunction  name="userLogin" access="public">
        <cfargument  name="user" type="string" required="true">
        <cfargument  name="password" type="string" required="true">
        <cfquery name="local.checkLog" datasource="shopping">
            SELECT
                userid,
                username,
                email,
                phone,
                image,
                status
            FROM
                admin
            WHERE
                username = <cfqueryparam value="#arguments.user#" cfsqltype="cf_sql_varchar">
            AND
                password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif local.checkLog.recordCount NEQ 0>
            <cfset session.user = {
                "access" = true,
                "user" = local.checkLog.userid,
                "name" = local.checkLog.username,
                "email" = local.checkLog.email,
                "phone" = local.checkLog.phone,
                "image" = local.checkLog.image
            }>
        <cfelse>
            <cfset structClear(session.check)>
            <cfset session.user.access = false>
        </cfif>
    </cffunction>

    <cffunction  name="validate" access="public">
        <cfargument  name="data" type="struct" required="true">
        <cfset local.input = {
            "data" = {
                "admin" = session.check.admin
            },
            "message" = []
        }>
        <cfif structKeyExists(arguments.data, 'recordId') AND len(arguments.data.recordId) NEQ 0>
            <cfset local.input.data['id'] = arguments.data.recordId>
            <cfset local.input.data['action'] = 'edit'>
        <cfelse>
            <cfset local.input.data['action'] = 'add'>
        </cfif>
        <cfif structKeyExists(arguments.data, 'categorySelect') AND len(arguments.data.categorySelect) NEQ 0>
            <cfset local.input.data['categorySelect'] = arguments.data.categorySelect>
            <cfif structKeyExists(arguments.data, 'subcategorySelect') AND len(arguments.data.subcategorySelect) NEQ 0>
                <cfset local.input.data['subcategorySelect'] = arguments.data.subcategorySelect>
                <cfif structKeyExists(arguments.data, 'productName') AND len(arguments.data.productName) NEQ 0>
                    <cfset local.input.data['name'] = arguments.data.productName>
                <cfelse>
                    <cfset arrayAppend(local.input.message, '*Product name required')>
                </cfif>
                <cfif structKeyExists(arguments.data, 'productDesc') AND len(arguments.data.productDesc) NEQ 0>
                    <cfset local.input.data['description'] = arguments.data.productDesc>
                <cfelse>
                    <cfset arrayAppend(local.input.message, '*Product description required')>
                </cfif>
                <cfif structKeyExists(arguments.data, 'price') AND len(arguments.data.price) NEQ 0>
                    <cfset local.input.data['price'] = arguments.data.price>
                <cfelse>
                    <cfset arrayAppend(local.input.message, '*Product price required')>
                </cfif>
                <cfif NOT structKeyExists(arguments.data, 'recordId')
                    OR (structKeyExists(arguments.data, 'productPic') 
                        AND len(arguments.data.productPic) NEQ 0)>
                            <cfset uploadDir = expandPath('/uploads/')>        
                            <cfif not directoryExists(uploadDir)>
                                <cfdirectory action="create" directory="#uploadDir#">
                            </cfif>
                            <cffile action="upload"
                                filefield="productPic"
                                destination="#uploadDir#"
                                nameConflict="makeunique">
                            <cfset local.input.data['image'] = cffile.serverFile>
                <cfelseif local.input.data['action'] EQ 'add'>
                    <cfset arrayAppend(local.input.message, '*Product image required')>
                </cfif>
            <cfelseif len(arguments.data.subcategoryText) NEQ 0>
                <cfset local.input.data['subcategory'] = arguments.data.subcategoryText>
            <cfelse>
                <cfset arrayAppend(local.input.message, '*Subcategory required')>
            </cfif>
        <cfelseif len(arguments.data.categoryText) NEQ 0>
            <cfset local.input.data['category'] = arguments.data.categoryText>
        <cfelse>
            <cfset arrayAppend(local.input.message, '*Category required')>
        </cfif>
        <cfreturn local.input>
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
                    categoryid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_varchar">
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
        <cfelseif arguments.data.action EQ "edit">
            <cfquery name="local.edit" datasource="shopping">
                UPDATE
                    subcategory
                SET
                    <cfif structKeyExists(arguments.data, 'subcategory')>
                        name = <cfqueryparam value="#arguments.data.subcategory#" cfsqltype="cf_sql_varchar">,
                    </cfif>
                    categoryid = <cfqueryparam value="#arguments.data.categorySelect#" cfsqltype="cf_sql_integer">,
                    lasteditedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    lasteditedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    subcategoryid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_varchar">
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
                    <cfqueryparam value="#arguments.data.name#" cfsqltype="cf_sql_varchar">,
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
            <cfquery name="local.edit" datasource="shopping">
                UPDATE
                    product
                SET
                    <cfif structKeyExists(arguments.data, 'image')>
                        image = <cfqueryparam value="#arguments.data.image#" cfsqltype="cf_sql_varchar">,
                    </cfif>
                    name = <cfqueryparam value="#arguments.data.name#" cfsqltype="cf_sql_varchar">,
                    description = <cfqueryparam value="#arguments.data.description#" cfsqltype="cf_sql_varchar">,
                    price = <cfqueryparam value="#arguments.data.price#" cfsqltype="cf_sql_decimal">,
                    subcategoryid = <cfqueryparam value="#arguments.data.subcategorySelect#" cfsqltype="cf_sql_integer">,
                    lasteditedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    lasteditedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    productid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_varchar">
            </cfquery>
        </cfif>
        <cfset local.sub = {
            action: 'edit',
            categorySelect: arguments.data.categorySelect,
            id: arguments.data.subcategorySelect,
            admin: arguments.data.admin
        }>
        <cfset variable = modifySubcategory(local.sub)>
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
                        subcategoryid = <cfqueryparam value="#arguments.subcategory#" cfsqltype="cf_sql_integer">
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
        <cfargument  name="category" type="integer" required="false">
        <cfargument  name="subcategory" type="integer" required="false">
        <cfargument  name="product" type="integer" required="false">
        <cfargument  name="sort" type="string" required="false">
        <cfquery name="local.list" datasource="shopping">
            SELECT
                productid,
                name,
                image,
                description,
                price,
                status,
                createdat,
                lasteditedat,
                createdby,
                lasteditedby,
                subcategoryid
            FROM
                product
            WHERE
                status = 1
            <cfif structKeyExists(arguments, 'category')>
                AND
                    subcategoryid IN (
                        SELECT
                            subcategoryid
                        FROM
                            subcategory
                        WHERE
                            categoryid = <cfqueryparam value="#arguments.category#" cfsqltype="cf_sql_integer">
                    )
            <cfelseif structKeyExists(arguments, 'subcategory')>
                AND
                    subcategoryid = <cfqueryparam value="#arguments.subcategory#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif structKeyExists(arguments, 'product')>
                AND
                    productid = <cfqueryparam value="#arguments.product#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif structKeyExists(arguments, 'sort')>
                <cfif arguments.sort EQ 'random'>
                    ORDER BY RAND()
                    LIMIT 6
                <cfelseif arguments.sort EQ 'price'>
                </cfif>
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
                "lasteditedat" : local.list.lasteditedat,
                "createdby": local.list.createdby,
                "lasteditedby": local.list.lasteditedby,
                "subcategory" : local.list.subcategoryid
            })>
        </cfoutput>
        <cfreturn local.output>
    </cffunction>

    <cffunction  name="addCart" access="remote" returnFormat="JSON">
        <cfargument  name="product" type="integer" required="true">
        <cfargument  name="user" type="integer" required="true">
        <cfquery name="local.list" datasource="shopping">
            SELECT
                cartid
            FROM
                cart
            WHERE
                productid = <cfqueryparam value="#arguments.product#" cfsqltype="cf_sql_integer">
            AND
                user = <cfqueryparam value="#arguments.user#" cfsqltype="cf_sql_integer">
            AND
                status = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif local.list.recordCount NEQ 0>
            <cfquery name="local.edit" datasource="shopping" result="result">
                UPDATE
                    cart
                SET
                    quantity = quantity + 1
                WHERE
                    cartid = <cfqueryparam value="#valueList(local.list.cartid)#" cfsqltype="cf_sql_integer" list='yes'>
            </cfquery>
        <cfelse>
            <cfquery name="local.add" datasource="shopping">
                INSERT INTO
                    cart(
                        productid,
                        userid,
                        quantity,
                        status
                    )
                VALUES(
                    <cfqueryparam value="#arguments.product#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#arguments.user#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                )
            </cfquery>
        </cfif>
    </cffunction>

    <cffunction  name="editCart" access="remote" returnFormat="JSON">
        <cfargument  name="cart" type="integer" required="true">
        <cfargument  name="product" type="integer" required="true">
        <cfargument  name="user" type="integer" required="false">
    </cffunction>

	<cffunction name="deleteItem" access="public">
		<cfargument name="data" type="struct" required="true">
        <cfif arguments.data.section EQ "category">
            <cfquery name="local.deleteCategories" datasource="shopping">
                UPDATE category
                SET
                    status = 0,
                    deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    deletedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    categoryid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfquery name="local.deleteSubCategories" datasource="shopping">
                UPDATE subcategory
                SET
                    status = 0,
                    deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    deletedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    categoryid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfquery name="local.deleteProducts" datasource="shopping">
                UPDATE product
                SET
                    status = 0,
                    deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    deletedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    subcategoryid IN (
                        SELECT subcategoryid
                        FROM subcategory
                        WHERE categoryid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_integer">
                    )
            </cfquery>
        <cfelseif arguments.data.section EQ "subcategory">
            <cfquery name="local.deleteSubCategories" datasource="shopping">
                UPDATE subcategory
                SET
                    status = 0,
                    deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    deletedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    subcategoryid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfquery name="local.deleteProducts" datasource="shopping">
                UPDATE product
                SET
                    status = 0,
                    deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    deletedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    subcategoryid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_integer">
            </cfquery>
        <cfelseif arguments.data.section EQ "product">
            <cfquery name="local.deleteProducts" datasource="shopping">
                UPDATE product
                SET
                    status = 0,
                    deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    deletedby = <cfqueryparam value="#arguments.data.admin#" cfsqltype="cf_sql_integer">
                WHERE
                    productid = <cfqueryparam value="#arguments.data.id#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>
    </cffunction>
</cfcomponent>