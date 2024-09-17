<cfcomponent>
	<cfset variables.key="baiYIM2yvVW258BNOmovjQ==">
	<cffunction name="insertUser" access="public">
		<cfargument name="username" type="string" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfset local.salt = generateSecretKey("AES")>
		<cfset local.hashedPass = hasher(arguments.password,local.salt)>
		<cfquery name="local.insertData" datasource="address">
			INSERT INTO
				log_user(
					username,
					name,
					email,
					password,
					salt
				)
			VALUES(
				<cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#local.hashedPass#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#local.salt#" cfsqltype="cf_sql_varchar">
			);
		</cfquery>
	</cffunction>

	<cffunction name="checkPass" access="public">
		<cfargument name="id" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfquery name="local.check" datasource="address">
			SELECT
				user_id,
				username,
				password,
				salt
			FROM
				log_user
			WHERE
				username=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
			OR
				email=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfset local.givenPass = hasher(arguments.password,local.check.salt)>
		<cfset local.access = structNew()>
		<cfset session.userid = local.check.user_id>
		<cfset session.username = local.check.username>
		<cfif local.givenPass EQ local.check.password>
			<cfset local.access[1]=true>
		<cfelse>
			<cfset local.access[1]=false>
		</cfif>
		<cfreturn true>
	</cffunction>

	<cffunction name="exist" access="remote" returnFormat="JSON">
		<cfargument name="check" type="string" required="true">
		<cfargument name="item" type="string" required="true">
		<cfquery name="local.userCheck" datasource="address">
			SELECT 
				email
			FROM
				log_user
			WHERE
				<cfif arguments.check EQ "email">
					email=<cfqueryparam value="#arguments.item#" cfsqltype="cf_sql_varchar">;
				<cfelseif arguments.check EQ "username">
					username=<cfqueryparam value="#arguments.item#" cfsqltype="cf_sql_varchar">;
				</cfif>
		</cfquery>
		<cfif local.userCheck.recordCount NEQ 0>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="hasher" access="private">
		<cfargument name="pass" type="string" required="true">
		<cfargument name="salt" type="string" required="true">
		<cfset local.saltedPass = arguments.pass & arguments.salt>
		<cfset local.hashedPass = hash(local.saltedPass,"SHA-256","UTF-8")>	
		<cfreturn local.hashedPass/>
	</cffunction>

	<cffunction name="insertContact" access="public">
		<cfargument name="user_id" type="string">
		<cfargument name="title" type="string">
		<cfargument name="firstname" type="string">
		<cfargument name="lastname" type="string">
		<cfargument name="gender" type="string">
		<cfargument name="date_of_birth" type="string">
		<cfargument name="profile" type="string">
		<cfargument name="house_flat" type="string">
		<cfargument name="street" type="string">
		<cfargument name="city" type="string">
		<cfargument name="state" type="string">
		<cfargument name="country" type="string">
		<cfargument name="pincode" type="string">
		<cfargument name="email" type="string">
		<cfargument name="phone" type="string">
		<cfquery name="local.insertData" datasource="address" result="result">
			INSERT INTO
				log_book(
					user_id,
					title,
					firstname,
					lastname,
					gender,
					date_of_birth,
					house_flat,
					street,
					city,
					state,
					country,
					pincode,
					email,
					phone
				)
			VALUES(
				<cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#arguments.firstname#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.lastname#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#arguments.date_of_birth#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#arguments.house_flat#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.city#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.country#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
			);
		</cfquery>
		<cfset local.id = result.GENERATEDKEY>
		<cfif arguments.profile NEQ "">
			<cfquery name="local.insertPhoto" datasource="address">
				UPDATE
					log_book
				SET
					profile = <cfqueryparam value="#arguments.profile#" cfsqltype="cf_sql_varchar">
				WHERE
					log_id = <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
				AND
					user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
		</cfif>
	</cffunction>

	<cffunction name="getList" access="remote" returnFormat="JSON" returnType="struct">
		<cfargument name="id" type="string">
		<cfquery name="local.list" datasource="address" returnType="struct">
			SELECT
				l.log_id,
				l.profile,
				CONCAT(
					t.value," ",
					l.firstname," ",
					l.lastname	) AS name,
				l.email AS email,
				l.phone AS phone
			FROM
				log_book l
			INNER JOIN
				title t ON l.title = t.id
			WHERE
				l.user_id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfloop from="1" to="#local.list.RECORDCOUNT#" index="i">
			<cfset local.list.RESULTSET[i]["log_id"]=encrypt(local.list.RESULTSET[i]["log_id"],variables.key,"AES","hex")>
		</cfloop>
		<cfreturn local.list>
	</cffunction>

	<cffunction name="getEdit" access="public">
		<cfargument name="user_id" type="string">
		<cfargument name="log_id" type="string">
		<cfset local.id = decrypt(arguments.log_id,variables.key,"AES","hex")>
		<cfquery name="local.record" datasource="address" returnType="struct">
			SELECT
				title,
				firstname,
				lastname,
				gender,
				date_of_birth,
				profile,
				house_flat,
				street,
				city,
				state,
				country,
				pincode,
				email,
				phone
			FROM
				log_book
			WHERE
				log_id=<cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
			AND
				user_id=<cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfset local.data = structNew()>
		<cfset locak.data = local.record[RESULTSET][0]>
		<cfreturn local.data>
	</cffunction>

	<cffunction name="updateContact" access="public">
		<cfargument name="user_id" type="string">
		<cfargument name="log_id" type="string">
		<cfargument name="title" type="string">
		<cfargument name="firstname" type="string">
		<cfargument name="lastname" type="string">
		<cfargument name="gender" type="string">
		<cfargument name="date_of_birth" type="string">
		<cfargument name="profile" type="string">
		<cfargument name="house_flat" type="string">
		<cfargument name="street" type="string">
		<cfargument name="city" type="string">
		<cfargument name="state" type="string">
		<cfargument name="country" type="string">
		<cfargument name="pincode" type="string">
		<cfargument name="email" type="string">
		<cfargument name="phone" type="string">
		<cfset local.id = decrypt(arguments.log_id,variables.key,"AES","hex")>
		<cfquery name="local.insertPhoto" datasource="address">
			UPDATE
				log_book
			SET
				title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
				firstname = <cfqueryparam value="#arguments.firstname#" cfsqltype="cf_sql_varchar">,
				lastname = <cfqueryparam value="#arguments.lastname#" cfsqltype="cf_sql_varchar">,
				gender = <cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_varchar">,
				date_of_birth = <cfqueryparam value="#arguments.date_of_birth#" cfsqltype="cf_sql_varchar">,
				house_flat = <cfqueryparam value="#arguments.house_flat#" cfsqltype="cf_sql_varchar">,
				street = <cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
				city = <cfqueryparam value="#arguments.city#" cfsqltype="cf_sql_varchar">,
				state = <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
				country = <cfqueryparam value="#arguments.country#" cfsqltype="cf_sql_varchar">,
				pincode = <cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_varchar">,
				email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
				phone = <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
			WHERE
				log_id = <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
			AND
				user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfif arguments.profile NEQ "">
			<cfquery name="local.updatePhoto" datasource="address">
				UPDATE
					log_book
				SET
					profile = <cfqueryparam value="#arguments.profile#" cfsqltype="cf_sql_varchar">
				WHERE
					log_id = <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
				AND
					user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
		</cfif>
	</cffunction>

	<cffunction name="getView" access="remote" returnFormat="JSON" returnType="struct">
		<cfargument name="user_id" type="string">
		<cfargument name="log_id" type="string">
		<cfset local.id = decrypt(arguments.log_id,variables.key,"AES","hex")>
		<cfquery name="local.record" datasource="address" returnType="struct">
			SELECT
				CONCAT(
					t.value," ",
					l.firstname," ",
					l.lastname	) AS name,
				g.value AS gender,
				l.date_of_birth,
				l.profile,
				CONCAT(
					l.house_flat,",<br>",
					l.street,",<br>",
					l.city,",<br>",
					l.state,",<br>",
					l.country	) AS address,
				l.pincode,
				l.email,
				l.phone
			FROM
				log_book l
			INNER JOIN
				title t ON l.title = t.id
			INNER JOIN
				gender g ON l.gender = g.id
			WHERE
				log_id=<cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
			AND
				user_id=<cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfreturn local.record>
	</cffunction>

	<cffunction name="deleteRecord" access="remote" returnFormat="JSON">
		<cfargument name="user_id" type="string">
		<cfargument name="log_id" type="string">
		<cfset local.id = decrypt(arguments.log_id,variables.key,"AES","hex")>
		<cfquery name="local.deleteRow" datasource="address">
			DELETE FROM
				log_book
			WHERE
				log_id=<cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
			AND
				user_id=<cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfreturn 1>
	</cffunction>
</cfcomponent>