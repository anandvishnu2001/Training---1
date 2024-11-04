<cfset control = CreateObject("component", "components.control")>
<cfif NOT (structKeyExists(session, "user") 
    AND session.user.access)>
        <cfset session.user = {
            "access" = false
        }>
</cfif>
<html lang="en">
	<head>
		<link href="/css/admin.css" rel="stylesheet">
		<link href="/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="container-fluid p-0 d-flex flex-column align-items-center">
		<nav id="main-nav" class="container-fluid navbar navbar-expand-lg justify-content-between bg-primary gap-5 z-3 fw-bold fixed-top" data-bs-theme="dark">
            <a class="navbar-brand" href="index.cfm">
                <img src="/images/shop.png" width="40" height="40" class="img-fluid">
                Shopping Cart
            </a>
            <form class="flex-grow-1 d-flex">
                <input name="searchWord" id="searchWord" class="form-control me-2" type="text" placeholder="Search">
                <button name="search" id="search" class="btn btn-primary" type="submit">
                    <img src="/images/search.png" class="img-fluid" alt="Cart" width="30" height="30">
                </button>
            </form>
            <ul class="flex-grow-1 navbar-nav nav-tabs nav-justified">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="" data-bs-toggle="dropdown">
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
                        <span class="badge bg-danger rounded-pill">99</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.cfm">
                        <img src="/images/login.png" class="img-fluid" alt="Login" width="30" height="30">
                    </a>
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
        <div class="container-fluid d-flex flex-row flex-wrap justify-content-evenly gap-5 p-5">
            <cfif structKeyExists(url, 'sub')>
                <cfset products = control.getProduct(subcategory=url.sub,limit=true)>
            <cfelseif structKeyExists(url, 'cat')>
                <cfset products = control.getProduct(category=url.cat,limit=true)>
            <cfelse>
                <cfset products = control.getProduct(limit=true)>
            </cfif>
            <cfif arrayLen(products) NEQ 0>
                <cfloop array="#products#" item="product">
                    <cfoutput>
                        <div class="card bg-light fw-bold col-3 p-3">
                            <div class="card-body d-flex row flex-wrap">
                                <img class="card-img col-md-6 w-50 h-auto img-fluid img-thumbnail" src="/uploads/#product.image#"
                                    alt="Card image" data-bs-theme="dark">
                                <div class="col-md-6 d-flex flex-column justify-content-evenly fw-bold">
                                    <p class="h4 card-title text-info">#product.name#</p>
                                    <p class="card-text text-danger">#product.price#</p>
                                </div>
                            </div>
                            <a type="submit" class="card-footer btn fw-bold btn-primary btn-block" href="product.cfm?pro=#product.id#">
                                Details
                            </a>
                        </div>
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