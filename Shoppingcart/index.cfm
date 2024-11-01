<cfset control = CreateObject("component", "components.control")>
<html lang="en">
	<head>
		<link href="/css/admin.css" rel="stylesheet">
		<link href="/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="container-fluid p-0 d-flex flex-column align-items-center">
		<nav class="container-fluid navbar navbar-expand-lg justify-content-between bg-primary gap-5 fw-bold fixed-top" data-bs-theme="dark">
            <a class="navbar-brand" href="">
                <img src="/images/shop.png" width="40" height="40" class="rounded-pill">
                Shopping Cart
            </a>
            <form class="flex-grow-1 d-flex">
                <input class="form-control me-2" type="text" placeholder="Search">
                <button class="btn btn-primary" type="button">Search</button>
            </form>
            <ul class="flex-grow-1 navbar-nav nav-tabs nav-justified">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="" role="button" data-bs-toggle="dropdown">
                        Menu
                    </a>
                    <ul class="dropdown-menu">
                        <cfset categories = control.getCategory()>
                        <cfloop array="#categories#" item="item">
                            <cfoutput>
                                <li><a id="#item.id#" class="dropdown-item" href="index.cfm?cat=#item.id#">#item.name#</a></li>
                            </cfoutput>
                        </cfloop>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="">
                        Cart
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="">
                        Log in/Sign up
                    </a>
                </li>
            </ul>
		</nav>
        <cfif structKeyExists(url, 'cat')>
            <nav class="container-fluid navbar navbar-expand-lg justify-content-center bg-dark fixed-top mt-5" data-bs-theme="dark">
                <ul class="flex-grow-1 navbar-nav nav-tabs nav-justified">
                    <cfset categories = control.getCategory()>
                    <cfloop array="#categories#" item="category">
                        <cfoutput>
                            <li class="nav-item dropdown">
                                <a id="#category.id#" class="nav-link dropdown-toggle" href="index.cfm?cat=#category.id#"
                                    role="button" data-bs-toggle="dropdown">
                                    #category.name#
                                </a>
                                <ul class="dropdown-menu">
                                    <cfset subcategories = control.getSubcategory(category.id)>
                                    <cfloop array="#subcategories#" item="subcategory">
                                        <cfoutput>
                                            <li><a id="#subcategory.id#" class="dropdown-item" href="index.cfm?cat=#category.id#&sub=#subcategory.id#">#subcategory.name#</a></li>
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
					<img src="/images/shop.png" width="40" height="40" class="img-fuid">
					Shopping Cart
				</h1>
		</nav>
        <div class="container-fluid d-flex flex-row flex-wrap justify-contend evenly gap-5 p-5">
            <div class="card bg-secondary fw-bold col-3 p-3">
                <div class="card-body d-flex row flex-wrap">
                    <img class="card-img col-md-6 w-50 h-auto img-fluid img-thumbnail" src="/images/shop.png" alt="Card image" data-bs-theme="dark">
                    <div class="col-md-6 d-flex flex-column justify-content-center fw-bold">
                        <p class="h4 card-title text-info">Product Name</p>
                        <p class="card-text text-warning">Product Price</p>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-evenly">
                <a type="submit" class="btn btn-primary btn-block" href="">
                    Details
                </a>
                <a type="submit" class="btn btn-danger btn-block" href="">
                    Add to cart
                </a>
                </div>
            </div>
        </div>
		<script type="text/javascript" src="/js/jQuery.js"></script><!---
		<script type="text/javascript" src="/js/admin.js"></script>--->
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
	</body>
</html>