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
		<cfquery name="local.checker" datasource="address">
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
		<cfset local.givenPass = hasher(arguments.password,local.checker.salt)>
		<cfset local.check = structNew()>
		<cfset session.userid = local.checker.user_id>
		<cfset session.username = local.checker.username>
		<cfif local.givenPass EQ local.checker.password>
			<cfset local.check.access=true>
		<cfelse>
			<cfset local.check.access=false>
		</cfif>
		<cfreturn local.check>
	</cffunction>

	<cffunction name="exist" access="remote" returnFormat="JSON">
		<cfargument name="check" type="string" required="true">
		<cfargument name="item" type="string" required="true">
		<cfquery name="local.userCheck" datasource="address">
			SELECT 
				username,email
			FROM
				log_user
			WHERE
				<cfif arguments.check EQ "email">
					email=<cfqueryparam value="#arguments.item#" cfsqltype="cf_sql_varchar">;
				<cfelseif arguments.check EQ "username">
					username=<cfqueryparam value="#arguments.item#" cfsqltype="cf_sql_varchar">;
				</cfif>
		</cfquery>
		<cfset local.access = structNew()>
		<cfif local.userCheck.recordCount NEQ 0>
			<cfset local.access[1]=true>
		<cfelse>
			<cfset local.access[1]=false>
		</cfif>
		<cfreturn local.access>
	</cffunction>

	<cffunction name="hasher" access="private">
		<cfargument name="pass" type="string" required="true">
		<cfargument name="salt" type="string" required="true">
		<cfset local.saltedPass = arguments.pass & arguments.salt>
		<cfset local.hashedPass = hash(local.saltedPass,"SHA-256","UTF-8")>	
		<cfreturn local.hashedPass/>
	</cffunction>

	<cffunction name="insertContact" access="public">
		<cfargument name="user_id" type="string" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="firstname" type="string" required="true">
		<cfargument name="lastname" type="string" required="true">
		<cfargument name="gender" type="string" required="true">
		<cfargument name="date_of_birth" type="string" required="true">
		<cfargument name="profile" type="string" required="true">
		<cfargument name="house_flat" type="string" required="true">
		<cfargument name="street" type="string" required="true">
		<cfargument name="city" type="string" required="true">
		<cfargument name="state" type="string" required="true">
		<cfargument name="country" type="string" required="true">
		<cfargument name="pincode" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="phone" type="string" required="true">
		<cfargument name="hobbies" type="string" required="true">
		<cfquery name="local.insertData">
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
		<cfquery name="local.generated" datasource="address">
			SELECT LAST_INSERT_ID() AS id;
		</cfquery>
		<cfquery name="local.insertHobbies" datasource="address">
			INSERT INTO
				contact_hobbies(
					contact,
					hobbies
				)
			VALUES
				<cfloop list="#arguments.hobbies#" index="i">
					(
						<cfqueryparam value="#local.generated.id#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#i#" cfsqltype="cf_sql_integer">
					)
					<cfif i NEQ listLast(arguments.hobbies,",")>,</cfif>
				</cfloop>
			;
		</cfquery>
		<cfif arguments.profile NEQ "">
			<cfquery name="local.insertPhoto" datasource="address">
				UPDATE
					log_book
				SET
					profile = <cfqueryparam value="#arguments.profile#" cfsqltype="cf_sql_varchar">
				WHERE
					log_id = <cfqueryparam value="#local.generated.id#" cfsqltype="cf_sql_integer">
				AND
					user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
		</cfif>
	</cffunction>

	<cffunction name="getList" access="remote" returnFormat="JSON" returnType="struct">
		<cfargument name="userid" type="string" required="true">
		<cfargument name="logid" type="string" required="false">
		<cfquery name="local.list" datasource="address">
			SELECT
				l.log_id,
				l.title,
				t.value AS tvalue,
				l.firstname,
				l.lastname,
				l.gender,
				g.value AS gvalue,
				l.date_of_birth,
				l.profile,
				l.house_flat,
				l.street,
				l.city,
				l.state,
				l.country,
				l.pincode,
				l.email,
				l.phone,
				c.hobbies,
				h.value AS hvalue
			FROM
				log_book l
			LEFT JOIN
				title t ON l.title=t.id
			LEFT JOIN
				gender g ON l.gender=g.id
			LEFT JOIN
				contact_hobbies c ON l.log_id=c.contact
			LEFT JOIN
				hobbies h ON c.hobbies=h.id
			WHERE
				l.user_id=<cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
			<cfif structKeyExists(arguments,"logid")>
				AND l.log_id=<cfqueryparam value="#decrypt(arguments.logid,variables.key,"AES","hex")#" cfsqltype="cf_sql_integer">
			</cfif>;
		</cfquery>
		<cfset local.records = structNew()>
		<cfoutput query="local.list">
			<cfif NOT structKeyExists(local.records,"#encrypt(local.list.log_id,variables.key,'AES','hex')#")>
				<cfset local.records["#encrypt(local.list.log_id,variables.key,'AES','hex')#"] = {
					"title"={ #local.list.title#="#local.list.tvalue#" },
					firstname="#local.list.firstname#",
					lastname="#local.list.lastname#",
					profile="#local.list.profile#",
					gender={ #local.list.gender#="#local.list.gvalue#" },
					date_of_birth="#local.list.date_of_birth#",
					house_flat="#local.list.house_flat#",
					street="#local.list.street#",
					city=local.list.city,
					state="#local.list.state#",
					country="#local.list.country#",
					pincode="#local.list.pincode#",
					email="#local.list.email#",
					phone="#local.list.phone#",
					hobbies={ #local.list.hobbies#="#local.list.hvalue#" }}>
			<cfelse>
				<cfset StructInsert(local.records["#encrypt(local.list.log_id,variables.key,'AES','hex')#"]["hobbies"],"#local.list.hobbies#","#local.list.hvalue#")>
			</cfif>
		</cfoutput>
		<cfreturn local.records>
	</cffunction>

	<cffunction name="updateContact" access="public">
		<cfargument name="user_id" type="string" required="true">
		<cfargument name="log_id" type="string" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="firstname" type="string" required="true">
		<cfargument name="lastname" type="string" required="true">
		<cfargument name="gender" type="string" required="true">
		<cfargument name="date_of_birth" type="string" required="true">
		<cfargument name="profile" type="string">
		<cfargument name="house_flat" type="string" required="true">
		<cfargument name="street" type="string" required="true">
		<cfargument name="city" type="string" required="true">
		<cfargument name="state" type="string" required="true">
		<cfargument name="country" type="string" required="true">
		<cfargument name="pincode" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="phone" type="string" required="true">
		<cfargument name="hobbies" type="string" required="true">
		<cfset local.id = decrypt(arguments.log_id,variables.key,"AES","hex")>
		<cfquery name="local.updateInfo" datasource="address">
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
		<cfquery name="local.deleteHobbies" datasource="address">
			DELETE FROM
				contact_hobbies
			WHERE
				contact = <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfquery name="local.updateHobbies" datasource="address">
			INSERT INTO
				contact_hobbies(
					contact,
					hobbies
				)
			VALUES
				<cfloop list="#arguments.hobbies#" index="i">
					(
						<cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#i#" cfsqltype="cf_sql_integer">
					)
					<cfif i NEQ listLast(arguments.hobbies,",")>,</cfif>
				</cfloop>;
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

	<cffunction name="deleteRecord" access="public">
		<cfargument name="user_id" type="string" required="true">
		<cfargument name="log_id" type="string" required="true">
		<cfset local.id = decrypt(arguments.log_id,variables.key,"AES","hex")>
		<cfquery name="local.deleteRow" datasource="address">
			DELETE FROM
				log_book
			WHERE
				log_id=<cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
			AND
				user_id=<cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfquery name="local.deleteHobbies" datasource="address">
			DELETE FROM
				contact_hobbies
			WHERE
				contact = <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">;
		</cfquery>
	</cffunction>
</cfcomponent>