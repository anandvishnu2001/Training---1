<cfset control = CreateObject("component", "components.control")>
<cfif NOT (structKeyExists(session, "user") 
    AND session.user.access)>
        <cflocation  url="login.cfm?log=1" addToken="no">
<cfelse>
    <cfset variables.carter = control.getCart(session.user.user)>
</cfif>
<html lang="en">
	<head>
		<link href="/css/admin.css" rel="stylesheet">
		<link href="/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="container-fluid p-0 d-flex flex-column align-items-center">
		<nav id="main-nav" class="container-fluid navbar navbar-expand-lg justify-content-center bg-primary gap-5 z-3 fw-bold fixed-top" data-bs-theme="dark">
            <a class="flex-grow-1 navbar-brand" href="index.cfm">
                <img src="/images/shop.png" width="40" height="40" class="img-fluid">
                Shopping Cart
            </a>
            <ul class="flex-grow-1 navbar-nav nav-tabs nav-justified">
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
                    <a class="nav-link" href="login.cfm?log=0">
                        <img src="/images/logout.png" class="img-fluid" alt="Login" width="30" height="30">
                    </a>
                </li>
            </ul>
		</nav>
        <div class="container-fluid d-flex flex-row flex-wrap align-items-start justify-content-start h-100 p-0 mt-5">
            <cfoutput>
                <div class="bg-dark h-100 d-flex flex-column fw-bold col-4 gap-5 p-5">
                    <img class="w-100 h-auto img-fluid img-thumbnail rounded-circle" src="/uploads/#session.user.image#"
                        alt="Card image" data-bs-theme="dark">
                    <h1 class="text-center text-info fw-bold">#session.user.name#</h1>
                    <button id="address-btn" class="btn fw-bold btn-outline-primary btn-block">
                        <img src="/images/address.png" class="img-fluid" alt="Login" width="40" height="40">
                        Manage Addresses
                    </button>
                    <button id="order-btn" class="btn fw-bold btn-outline-primary btn-block">
                        <img src="/images/order.png" class="img-fluid" alt="Login" width="40" height="40">
                        Order Details
                    </button>
                </div>
            </cfoutput>
            <div class="h-100 d-flex flex-column fw-bold col-8 p-5">
                <div id="address-card" class="card bg-light h-100 fw-bold p-5">
                    <h3 class="card-title">Manage Addresses</h3>
                    <cfoutput>
                    <div class="card-body overflow-y-scroll accordion">
                        <div class="accordion-item">
                            <div class="accordion-header">
                                <span class="accordion-button bg-primary gap-5">
                                    <h4 class="text-white">Accordion Item 1</h4>
                                    <button class="btn btn-light">pdf</button>
                                </span>
                            </div>
                            <div class="accordion-body list-goup"><div class="col-5">
                                <span class="h5 card-text text-muted">Name</span>
                                <span class="h5 card-text text-muted">Price</span>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="card-footer btn fw-bold btn-primary btn-block" href="">
                    <span class="h3">Add Address</span>
                </button></cfoutput>
                </div>
                <div id="order-card" class="card bg-light h-100 fw-bold p-5">
                    <h3 class="card-title">Order History</h3>
                    <ul class="card-body overflow-y-scroll list-group p-2 gap-3 d-flex fw-bold">
                        <li class="d-flex flex-wrap justify-content-evenly p-5 list-group-item">
                            <span class="h5 col-12 card-text text-dark">Order</span>
                            <div class="col-5">
                                <span class="h5 card-text text-muted">Name</span>
                                <span class="h5 card-text text-muted">Price</span>
                                <div class="d-flex flex-column gap-1 justify-content-evenly">
                                    <a class="btn fw-bold btn-danger btn-block" href="">
                                        Remove
                                    </a>
                                </div>
                            </div>
                            <div class="col-5">
                                <span class="h5 card-text text-muted">Name</span>
                                <span class="h5 card-text text-muted">Price</span>
                                <div class="d-flex flex-column gap-1 justify-content-evenly">
                                    <a class="btn fw-bold btn-danger btn-block" href="">
                                        Remove
                                    </a>
                                </div>
                            </div>
                            <div class="col-5">
                                <span class="h5 card-text text-muted">Name</span>
                                <span class="h5 card-text text-muted">Price</span>
                                <div class="d-flex flex-column gap-1 justify-content-evenly">
                                    <a class="btn fw-bold btn-danger btn-block" href="">
                                        Remove
                                    </a>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
		<script type="text/javascript" src="/js/jQuery.js"></script>
		<script type="text/javascript" src="/js/home.js"></script>
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
	</body>
</html>