<cfset control = CreateObject("component", "components.control")>
<cfif NOT (structKeyExists(session, "user") 
    AND session.user.access)>
        <cfset session.user = {
            "access" = false
        }>
<cfelse>
    <cfset variables.carter = control.getCart(session.user.user)>
</cfif>
<cfset argumentCollection = { sort = structKeyExists(url, 'sort') ? url.sort : 'random' }>
<cfif structKeyExists(url, 'keyword')>
    <cfset argumentCollection.search = url.keyword>
<cfelseif structKeyExists(url, 'sub')>
    <cfset argumentCollection.subcategory = url.sub>
<cfelseif structKeyExists(url, 'cat')>
    <cfset argumentCollection.category = url.cat>
</cfif>
<cfset products = control.getProduct(argumentCollection=argumentCollection)>
<html lang="en">
	<head>
		<link href="/css/admin.css" rel="stylesheet">
		<link href="/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="container-fluid p-0 d-flex flex-column align-items-center">
		<nav id="main-nav" class="container-fluid navbar navbar-expand-lg justify-content-between bg-primary gap-5 z-3 fw-bold fixed-top" data-bs-theme="dark">
            <a class="flex-grow-1 navbar-brand ms-2" href="index.cfm">
                <img src="/images/shop.png" width="40" height="40" class="img-fluid">
                Shopping Cart
            </a>
            <form class="flex-grow-1 d-flex">
                <input name="keyword" id="keyword" class="form-control me-2" type="text" placeholder="Search" required>
                <button name="search" id="search" class="btn btn-primary" type="submit" value="keyword">
                    <img src="/images/search.png" class="img-fluid" alt="Cart" width="30" height="30">
                </button>
            </form>
            <ul class="flex-grow-1 navbar-nav nav-tabs nav-justified">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle <cfif structKeyExists(url, 'cat')>active</cfif>" href="" data-bs-toggle="dropdown">
                        <img src="/images/menu.png" class="img-fluid" alt="Cart" width="30" height="30">
                    </a>
                    <ul class="dropdown-menu">
                        <cfset categories = control.getCategory()>
                        <cfloop array="#categories#" item="item">
                            <cfoutput>
                                <li>
                                    <a id="#item.id#" class="dropdown-item" href="index.cfm?cat=#item.id#">#item.name#</a>
                                </li>
                            </cfoutput>
                        </cfloop>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.cfm">
                        <img src="/images/cart.png" class="img-fluid" alt="Cart" width="30" height="30">
                        <cfif structKeyExists(variables, 'carter')
                            AND arrayLen(variables.carter) GT 0>
                            <cfoutput>
                                <span class="badge bg-danger rounded-pill">#arrayLen(variables.carter)#</span>
                            </cfoutput>
                        </cfif>
                    </a>
                </li>
                <li class="nav-item">
                    <cfif structKeyExists(session, 'user')
                        AND session.user.access>
                            <a class="nav-link" href="user.cfm">
                                <cfoutput>
                                    <img src="/uploads/#session.user.image#" class="rounded-circle" alt="Login" width="30" height="30">
                                </cfoutput>
                            </a>
                    <cfelse>
                        <a class="nav-link" href="login.cfm">
                            <img src="/images/login.png" class="img-fluid" alt="Login" width="30" height="30">
                        </a>
                    </cfif>
                </li>
            </ul>
		</nav>
        <cfif structKeyExists(url, 'cat')>
            <nav id="category-nav" class="container-fluid navbar navbar-expand-lg justify-content-center bg-secondary z-2 fixed-top" data-bs-theme="dark">
                <ul class="flex-grow-1 navbar-nav nav-tabs nav-justified">
                    <cfset categories = control.getCategory()>
                    <cfloop array="#categories#" item="category">
                        <cfoutput>
                            <li class="nav-item dropdown">
                                <a id="#category.id#" class="nav-link
                                    <cfif category.id EQ url.cat>active</cfif>
                                    dropdown-toggle" 
                                    href="index.cfm?cat=#category.id#"
                                    data-bs-toggle="dropdown">
                                    #category.name#
                                </a>
                                <ul class="dropdown-menu">
                                    <cfset subcategories = control.getSubcategory(category.id)>
                                    <cfloop array="#subcategories#" item="subcategory">
                                        <cfoutput>
                                            <li>
                                                <a id="#subcategory.id#" class="dropdown-item" 
                                                    href="index.cfm?cat=#category.id#&sub=#subcategory.id#">
                                                        #subcategory.name#
                                                </a>
                                            </li>
                                        </cfoutput>
                                    </cfloop>
                                </ul>
                            </li>
                        </cfoutput>
                    </cfloop>
                </ul>
            </nav>
        </cfif>
        <nav class="container-fluid navbar navbar-expand-lg justify-content-center bg-info h-50 mt-5">
				<h1 class="text-center text-danger">
                    Welcome to<br/>
					<img src="/images/shop.png" width="50" height="50" class="img-fuid">
					Shopping Cart
				</h1>
		</nav>
        <div class="container d-flex justify-content-center p-3 gap-5">
            <h2 class="text-center text-success">
                PRICE
            </h2>
            <cfoutput>
                <cfset variables.url = cgi.HTTP_URL>
                <cfset variables.url = REReplace(variables.url, "[&?]sort=[^&]*", "", "all")>
                <cfset variables.url = variables.url & (find('?', variables.url) ? '&' : '?')>
                <a href="#variables.url#sort=pricelow" class="btn btn-success">Low to High</a>
                <a href="#variables.url#sort=pricehigh" class="btn btn-success">High to Low</a>
            </cfoutput>
        </div>
        <div class="container-fluid d-flex flex-row flex-wrap justify-content-evenly gap-5 p-5">
            <cfif arrayLen(products) NEQ 0>
                <cfloop array="#products#" item="product">
                    <cfoutput>
                        <a class="card bg-light text-decoration-none fw-bold col-3 p-3" href="product.cfm?pro=#product.id#">
                            <div class="card-body d-flex row flex-wrap">
                                <img class="card-img col-md-6 w-50 h-auto img-fluid img-thumbnail" src="/uploads/#product.image#"
                                    alt="Card image" data-bs-theme="dark">
                                <div class="col-md-6 d-flex flex-column justify-content-evenly fw-bold">
                                    <p class="h4 card-title text-info">#product.name#</p>
                                    <p class="card-text text-danger">#product.price#</p>
                                </div>
                            </div>
                        </a>
                    </cfoutput>
                </cfloop>
            <cfelse>
                <h1 class="text-center text-warning">Products items Empty!!</h1>
            </cfif>
        </div>
		<script type="text/javascript" src="/js/jQuery.js"></script>
		<script type="text/javascript" src="/js/home.js"></script>
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
	</body>
</html>