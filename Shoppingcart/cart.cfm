<cfset control = CreateObject("component", "components.control")>
<cfif structKeyExists(url, 'pro')>
    <cfif structKeyExists(variables, 'carter')>
        <cfset variables.carter = control.addCart(product=url.pro)>
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
        <div class="container-fluid d-flex flex-row justify-content-evenly align-items-center gap-5 p-5 mt-5">
            <div class="card bg-light fw-bold col-8 p-3">
                <ul class="card-body list-group d-flex flex-column">
                    <li class="list-group-item d-flex flex-column gap-3">
                        <div class="d-flex flex-row flex-wrap justify-content-evenly">
                            <img class="card-img w-50 h-auto img-fluid img-thumbnail" src="/images/shop.png"
                                alt="Card image" data-bs-theme="dark">
                            <div class="col-5 d-flex flex-column justify-content-evenly fw-bold">
                                <p class="h4 card-title text-info">#product.name#</p>
                                <p class="card-text text-danger">#product.price#</p>
                            </div>
                        </div>
                        <div class="d-flex justify-content-evenly">
                            <button class="btn btn-secondary rounded-pill disabled">-</button>
                            <p class="card-text text-muted">q</p>
                            <button class="btn btn-secondary rounded-pill">+</button>
                            <button class="btn btn-danger">Remove item</button>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="card bg-light fw-bold col-3 p-3 gap-5">
                <button class="btn btn-success">Check out</button>
                <button class="btn btn-danger">Empty cart</button>
            </div>
        </div>
		<script type="text/javascript" src="/js/jQuery.js"></script>
		<script type="text/javascript" src="/js/home.js"></script>
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
	</body>
</html>