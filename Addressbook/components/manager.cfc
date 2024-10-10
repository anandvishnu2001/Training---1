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
		<cfset session.userid = local.checker.user_id>
		<cfset session.username = local.checker.username>
		<cfif local.givenPass EQ local.checker.password>
			<cfset session.check.access=true>
		<cfelse>
			<cfset session.check.access=false>
		</cfif>
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
		<cfreturn local.hashedPass>
	</cffunction>

	<cffunction name="selectSet" access="public" returnType="struct">
		<cfset local.list = structNew()>
		<cfquery name="local.title" datasource="address">
			SELECT
				id,
				value
			FROM
				title;
		</cfquery>
		<cfoutput query="local.title">
			<cfset local.list.title["#local.title.id#"]=local.title.value>
		</cfoutput>
		<cfquery name="local.gender" datasource="address">
			SELECT
				id,
				value
			FROM
				gender;
		</cfquery>
		<cfoutput query="local.gender">
			<cfset local.list.gender["#local.gender.id#"]=local.gender.value>
		</cfoutput>
		<cfquery name="local.hobbies" datasource="address">
			SELECT
				id,
				value
			FROM
				hobbies;
		</cfquery>
		<cfoutput query="local.hobbies">
			<cfset local.list.hobbies["#local.hobbies.id#"]=local.hobbies.value>
		</cfoutput>
		<cfreturn local.list>
	</cffunction>

	<cffunction name="modifyContact" access="public">
		<cfargument name="log_id" type="string" required="false">
		<cfargument name="title" type="string" required="true">
		<cfargument name="firstname" type="string" required="true">
		<cfargument name="lastname" type="string" required="true">
		<cfargument name="gender" type="string" required="true">
		<cfargument name="date_of_birth" type="string" required="true">
		<cfargument name="profile" type="string" required="false">
		<cfargument name="house_flat" type="string" required="true">
		<cfargument name="street" type="string" required="true">
		<cfargument name="city" type="string" required="true">
		<cfargument name="state" type="string" required="true">
		<cfargument name="country" type="string" required="true">
		<cfargument name="pincode" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="phone" type="string" required="true">
		<cfargument name="hobbies" type="string" required="true">
		<cfif structKeyExists(arguments,"log_id") AND arguments.log_id NEQ "">
			<cfset local.id = crypter(arguments.log_id,"decrypt")>
			<cfquery name="local.updateInfo" datasource="address">
				UPDATE
					log_book
				SET
					title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
					firstname = <cfqueryparam value="#arguments.firstname#" cfsqltype="cf_sql_varchar">,
					lastname = <cfqueryparam value="#arguments.lastname#" cfsqltype="cf_sql_varchar">,
					profile = CASE
						WHEN <cfqueryparam value="#arguments.profile#" cfsqltype="cf_sql_varchar"> != ''
							THEN <cfqueryparam value="#arguments.profile#" cfsqltype="cf_sql_varchar">
						ELSE profile
					END,
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
					user_id = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">;
			</cfquery>
			<cfquery name="local.deleteHobbies" datasource="address">
				DELETE FROM
					contact_hobbies
				WHERE
					contact = <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
				AND
					hobbies
				NOT IN
					(<cfqueryparam value="#arguments.hobbies#" cfsqltype="cf_sql_integer" list="true">);
			</cfquery>
			<cfquery name="local.updateHobbies" datasource="address">
				INSERT INTO
					contact_hobbies(
						contact,
						hobbies
					)
				SELECT 
					<cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer"> AS contact,
					temp.hobby
				FROM (
					<cfloop list="#arguments.hobbies#" index="local.i" item="local.j">
						<cfif local.i NEQ 1>
							UNION ALL
						</cfif>
							SELECT <cfqueryparam value="#local.j#" cfsqltype="cf_sql_integer"> AS hobby
					</cfloop>
				) AS temp
				WHERE temp.hobby NOT IN (
					SELECT
						hobbies
					FROM
						contact_hobbies
					WHERE
						contact = <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
				);
			</cfquery>
		<cfelse>
			<cfquery name="local.insertData" result="res">
				INSERT INTO
					log_book(
						user_id,
						title,
						firstname,
						lastname,
						profile,
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
					<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#arguments.firstname#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.lastname#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.profile#" cfsqltype="cf_sql_varchar">,
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
			<cfquery name="local.insertHobbies" datasource="address">
				INSERT INTO
					contact_hobbies(
						contact,
						hobbies
					)
				VALUES
					<cfloop list="#arguments.hobbies#" index="local.i" item="local.j">
						(
							<cfqueryparam value="#res.GENERATEDKEY#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#local.j#" cfsqltype="cf_sql_integer">
						)
						<cfif local.i NEQ listLen(arguments.hobbies)>,</cfif>
					</cfloop>;
			</cfquery>
		</cfif>
	</cffunction>

	<cffunction name="getList" access="remote" returnFormat="JSON" returnType="struct">
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
				l.user_id=<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
			<cfif structKeyExists(arguments,"logid")>
				AND l.log_id=<cfqueryparam value="#crypter(arguments.logid,'decrypt')#" cfsqltype="cf_sql_integer">
			</cfif>;
		</cfquery>
		<cfset local.records = structNew()>
		<cfset local.metadata = structNew()>
		<cfoutput query="local.list">
			<cfset local.id = crypter(local.list.log_id,"encrypt")>
			<cfif NOT structKeyExists(local.records,local.id)>
				<cfset local.records[local.id] = {
					"title"={ #local.list.title#=local.list.tvalue },
					"firstname"=local.list.firstname,
					"lastname"=local.list.lastname,
					"profile"=local.list.profile,
					"gender"={ #local.list.gender#=local.list.gvalue },
					"date_of_birth"=local.list.date_of_birth,
					"house_flat"=local.list.house_flat,
					"street"=local.list.street,
					"city"=local.list.city,
					"state"=local.list.state,
					"country"=local.list.country,
					"pincode"=local.list.pincode,
					"email"=local.list.email,
					"phone"=local.list.phone,
					"hobbies"={ #local.list.hobbies#=local.list.hvalue }}>
			<cfelse>
				<cfset local.records[local.id]["hobbies"][local.list.hobbies]=local.list.hvalue> 
			</cfif>
		</cfoutput>
		<cfreturn local.records>
	</cffunction>

	<cffunction name="getIdByEmail" access="public">
		<cfargument name="email" type="string" required="true">
		<cfquery name="local.getID" datasource="address">
			SELECT 
				log_id
			FROM
				log_book
			WHERE
				user_id=<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_varchar">
			AND
				email=<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfif len(local.getId.log_id) NEQ 0>
			<cfset local.access={ check: true,
						id: crypter(local.getId.log_id,"encrypt") }>
		<cfelse>
			<cfset local.access={ check: false }>
		</cfif>
		<cfreturn local.access>
	</cffunction>

	<cffunction name="deleteRecord" access="public">
		<cfargument name="log_id" type="string" required="true">
		<cfset local.id = crypter(arguments.log_id,"decrypt")>
		<cfquery name="local.deleteRow" datasource="address">
			DELETE FROM
				log_book
			WHERE
				log_id=<cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
			AND
				user_id=<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfquery name="local.deleteHobbies" datasource="address">
			DELETE FROM
				contact_hobbies
			WHERE
				contact = <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">;
		</cfquery>
	</cffunction>

	<cffunction name="createExcel" access="public">
		<cfargument name="action" type="string" required="true">
		<cfargument name="excel" type="string" required="false">
		<cfset local.spreadsheetObj = SpreadsheetNew("AddressBook","true")>
		<cfset local.head={color="gold",fgcolor="teal",bold="true",alignment="center",fontsize="13"}>
		<cfset SpreadsheetFormatRow(local.spreadsheetObj,local.head,1)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,1,6)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,2,13)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,3,13)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,4,8)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,5,13)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,6,25)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,7,15)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,8,15)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,9,15)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,10,15)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,11,10)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,12,25)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,13,13)>
		<cfset SpreadSheetSetColumnWidth(local.spreadsheetObj,14,35)>
		<cfif arguments.action EQ "plain" OR arguments.action EQ "data">
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Title",1,1)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Firstname",1,2)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Lastname",1,3)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Gender",1,4)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"DOB",1,5)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"House",1,6)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Street",1,7)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"City",1,8)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"State",1,9)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Country",1,10)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Pincode",1,11)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Email",1,12)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Phone",1,13)>
			<cfset spreadsheetSetCellValue(local.spreadsheetObj,"Hobbies",1,14)>
		</cfif>
		<cfif arguments.action EQ "data" OR arguments.action EQ "upload">
			<cfset local.log = getList()>
		</cfif>
		<cfif arguments.action EQ "plain">
			<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Plain-Template.xlsx">
		<cfelseif arguments.action EQ "data">
			<cfset local.j=1>
			<cfloop collection="#local.log#" item="local.i">
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].title[StructKeyList(local.log[local.i].title)[1]]#",local.j+1,1)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].firstname#",local.j+1,2)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].lastname#",local.j+1,3)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].gender[StructKeyList(local.log[local.i].gender)[1]]#",local.j+1,4)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].date_of_birth#",local.j+1,5)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].house_flat#",local.j+1,6)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].street#",local.j+1,7)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].city#",local.j+1,8)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].state#",local.j+1,9)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].country#",local.j+1,10)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].pincode#",local.j+1,11)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].email#",local.j+1,12)>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.log[local.i].phone#",local.j+1,13)>
				<cfset local.hobbies = listMap(StructKeyList(local.log[local.i].hobbies), function(key) {
						return local.log[local.i].hobbies[key];
					})>
				<cfset spreadsheetSetCellValue(local.spreadsheetObj,"#local.hobbies#",local.j+1,14)>
				<cfset local.j++>
			</cfloop>
			<cfloop from="1" to="#1+structCount(local.log)#" index="local.i">
				<cfif local.i%2 EQ 0>
					<cfset SpreadsheetFormatRow(local.spreadsheetObj,{fgcolor="grey_25_percent",verticalalignment="vertical_center"},local.i)>
				</cfif>
			</cfloop>
			<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-DataIncluded-Template.xlsx">
		<cfelseif arguments.action EQ "upload">
			<cfset local.select = selectSet()>
			<cfspreadsheet
				action="read"
				headerrow="1"
				excludeHeaderRow="true"
				src="#arguments.excel#"
				query="local.quer">
			<cfset local.quer.addColumn("Result","varchar",arrayNew(1))>
			<cfoutput query="local.quer">
				<cfset local.pending = "">
				<cfif (NOT queryKeyExists(local.quer,"title")) OR len(local.quer.title) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Title",",")>
				<cfelse>
					<cfset structDelete(variables,"local.qtitle")>
					<cfset local.checkTitle=StructFindValue(local.select.title,trim(local.quer.title))>
					<cfif arrayLen(local.checkTitle) NEQ 0>
						<cfset local.qtitle=val(local.checkTitle[1].key)>
					<cfelse>
						<cfset local.pending = listAppend(local.pending,"Title(Valid)",",")>
					</cfif>
				</cfif>
				<cfif (NOT queryKeyExists(local.quer,"firstname")) OR len(local.quer.firstname) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Firstname",",")>
				</cfif>
				<cfif (NOT queryKeyExists(local.quer,"lastname")) OR len(local.quer.lastname) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Lastname",",")>
				</cfif>
				<cfif (NOT queryKeyExists(local.quer,"gender")) OR len(local.quer.gender) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Gender",",")>
				<cfelse>
					<cfset structDelete(variables,"local.qgender")>
					<cfset local.checkGender=StructFindValue(local.select.gender,trim(local.quer.gender))>
					<cfif arrayLen(local.checkGender) NEQ 0>
						<cfset local.qgender=val(local.checkGender[1].key)>
					<cfelse>
						<cfset local.pending = listAppend(local.pending,"Gender(Valid)",",")>
					</cfif>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"DOB") OR len(local.quer.DOB) EQ 0>
					<cfset local.pending = listAppend(local.pending,"DOB",",")>
				<cfelseif NOT isDate(local.quer.DOB) OR (isDate(local.quer.DOB) AND local.quer.DOB GT now())>
					<cfset local.pending = listAppend(local.pending,"DOB(Valid)",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"house") OR len(local.quer.house) EQ 0>
					<cfset local.pending = listAppend(local.pending,"House",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"street") OR len(local.quer.street) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Street",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"city") OR len(local.quer.city) EQ 0>
					<cfset local.pending = listAppend(local.pending,"City",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"state") OR len(local.quer.state) EQ 0>
					<cfset local.pending = listAppend(local.pending,"State",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"country") OR len(local.quer.country) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Country",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"pincode") OR len(local.quer.pincode) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Pincode",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"email") OR len(local.quer.email) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Email",",")>
				<cfelseif NOT REFindNoCase("^[\w]+@[\w]+\.[a-zA-Z]{2,}$",local.quer.email)>
					<cfset local.pending = listAppend(local.pending,"Email(Valid)",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"phone") OR len(local.quer.phone) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Phone",",")>
				<cfelseif NOT REFindNoCase("[0-9]{10}",local.quer.phone)>
					<cfset local.pending = listAppend(local.pending,"Phone(Valid)",",")>
				</cfif>
				<cfif NOT queryKeyExists(local.quer,"hobbies") OR listLen(local.quer.hobbies) EQ 0>
					<cfset local.pending = listAppend(local.pending,"Hobbies",",")>
				<cfelse>
					<cfset local.hobby="">
					<cfset local.flag=0>
					<cfset local.arrayHobbies=listToArray(local.quer.hobbies)>
					<cfset arrayEach(local.arrayHobbies,function(value){
							local.checkHobbies=StructFindValue(local.select.hobbies,trim(value));
							if(arrayLen(local.checkHobbies) NEQ 0)
								local.hobby = listAppend(local.hobby,local.checkHobbies[1].key,",");
							else
								local.flag = 1;
						})>
					<cfif local.flag EQ 1>
						<cfset local.pending = listAppend(local.pending,"Hobbies(Valid)",",")>
					</cfif>
				</cfif>
				<cfif len(local.pending) NEQ 0>
					<cfset QuerySetCell(local.quer,"Result",local.pending&" missing",local.quer.currentRow)>
				<cfelse>
					<cfset local.idStruct=getIdByEmail(local.quer.email)>
					<cfset modifyContact( (local.idStruct.check ? local.idStruct.id : ""),
						local.qtitle,
						local.quer.firstname,
						local.quer.lastname,
						local.qgender,
						dateformat(local.quer.DOB,"yyyy-mm-dd"),
						(local.idStruct.check ? local.log[local.idStruct.id].profile : "signup.png"),
						local.quer.house,
						local.quer.street,
						local.quer.city,
						local.quer.state,
						local.quer.country,
						local.quer.pincode,
						local.quer.email,
						local.quer.phone,
						local.hobby )>
					<cfif local.idStruct.check>
						<cfset QuerySetCell(local.quer,"Result","updated",local.quer.currentRow)>
					<cfelse>
						<cfset QuerySetCell(local.quer,"Result","added",local.quer.currentRow)>
					</cfif>
				</cfif>
			</cfoutput>
			<cfset local.sortquer = querySort(local.quer,function(row1,row2){
					if(find("missing",row1.result))
						sortkey1=1;
					else if(row1.result EQ "added")
						sortkey1=2;
					else if(row1.result EQ "updated")
						sortkey1=3;
					if(find("missing",row2.result))
						sortkey2=1;
					else if(row2.result EQ "added")
						sortkey2=2;
					else if(row2.result EQ "updated")
						sortkey2=3;
					return compare(sortkey1,sortkey2);
				})>
			<cfset SpreadsheetAddRows(local.spreadsheetObj,local.sortquer,1,1,true,[],true)>
			<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Upload-Result.xlsx">
		</cfif>
		<cfset local.binary = SpreadsheetReadBinary(local.spreadsheetObj)>
		<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#local.binary#">
	</cffunction>

	<cffunction name="crypter" access="private">
		<cfargument name="id" type="string" required="true">
		<cfargument name="action" type="string" required="true">
		<cfif arguments.action EQ "encrypt">
			<cfset local.result = encrypt(arguments.id,variables.key,'AES','hex')>
		<cfelseif arguments.action EQ "decrypt">
			<cfset local.result = decrypt(arguments.id,variables.key,'AES','hex')>
		</cfif>	
		<cfreturn local.result>
	</cffunction>
</cfcomponent>