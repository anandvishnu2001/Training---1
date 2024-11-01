<cfset control = CreateObject("component", "components.control")>
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
                <input class="form-control me-2" type="text" placeholder="Search">
                <button class="btn btn-primary" type="button">
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
        <div class="container-fluid d-flex flex-row flex-wrap justify-content-evenly gap-5 mt-5 p-5">
            <cfif structKeyExists(url, 'pro')>
                <cfset products = control.getProduct(product=url.pro)>
                <cfoutput>
                    <div class="card bg-light fw-bold p-3">
                        <div class="card-body d-flex row flex-wrap">
                            <img class="card-img col-md-6 w-50 h-auto img-fluid img-thumbnail" src="/uploads/#products[1].image#"
                                alt="Card image" data-bs-theme="dark">
                            <div class="col-md-6 d-flex flex-column justify-content-evenly align-items-start fw-bold">
                                <h1 class="card-title text-dark">#products[1].name#</h1>
                                <h3 class="card-text text-muted">#products[1].description#</h3>
                                <h2 class="card-text text-danger">#products[1].price#</h2>
                                <div class="container-fluid btn-group btn-group-lg">
                                    <a class="card-link btn btn-success" href="cart.cfm?pro=#products[1].id#">
                                        Add to <img src="/images/cart.png" class="img-fluid" alt="Cart" width="30" height="30">
                                    </a>
                                    <a class="card-link btn btn-success" href="">
                                        Buy Now
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </cfoutput>
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