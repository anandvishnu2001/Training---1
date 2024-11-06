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
                <div class="bg-dark h-100 d-flex flex-column align-items-center fw-bold col-4 gap-5 p-5">
                    <img class="img-fluid img-thumbnail rounded-circle" src="/uploads/#session.user.image#"
                        alt="Card image" width="80" height="80" data-bs-theme="dark">
                    <h1 class="text-info fw-bold">#session.user.name#</h1>
                <div class="d-grid fw-bold gap-5">
                    <button id="address-btn" class="btn fw-bold btn-outline-primary btn-block">
                        <img src="/images/address.png" class="img-fluid" alt="Login" width="40" height="40">
                        Manage Addresses
                    </button>
                    <button id="order-btn" class="btn fw-bold btn-outline-primary btn-block">
                        <img src="/images/order.png" class="img-fluid" alt="Login" width="40" height="40">
                        Order Details
                    </button>
                    </div>
                </div>
            </cfoutput>
            <div class="h-100 d-flex flex-column fw-bold col-8 p-5">
                <div id="address-card" class="card bg-light h-100 fw-bold p-5">
                    <h3 class="card-title">Manage Addresses</h3>
                    <div class="card-body overflow-y-scroll accordion">
                        <div class="accordion-item">
                            <div class="accordion-header">
                                <span class="container-fluid accordion-button bg-primary gap-5">
                                    <h4 class="text-white w-75">Name</h4>
                                    <button class="btn btn-success">edit</button>
                                    <button class="btn btn-danger">remove</button>
                                </span>
                            </div>
                            <div class="accordion-body"><div class="col-5">
                                <h4 class="text-muted">Phone</h4>
                                <h5 class="text-muted">Address</h5>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="card-footer btn fw-bold btn-primary btn-block" href="">
                    <span class="h3">Add Address</span>
                </button>
                </div>
                <div id="order-card" class="card bg-light h-100 fw-bold p-5">
                    <h3 class="card-title">Order History</h3>
                    <div class="card-body overflow-y-scroll accordion">
                        <div class="accordion-item">
                            <div class="accordion-header">
                                <span class="container-fluid accordion-button bg-primary gap-5">
                                    <h4 class="text-white w-75">Order</h4>
                                    <button class="btn btn-danger">pdf</button>
                                </span>
                            </div>
                            <ul class="accordion-body list-group">
                                <li class="list-group-item">
                                    <img src="/images/logout.png" class="img-fluid" alt="Login" width="80" height="80">
                                    <div class="">
                                    <span class="h5 card-text text-muted">Name</span>
                                    <span class="h5 card-text text-muted">Price</span>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <span class="h5 card-text text-muted">Name</span>
                                    <span class="h5 card-text text-muted">Price</span>
                                </li>
                                <li class="list-group-item">
                                    <span class="h5 card-text text-muted">Name</span>
                                    <span class="h5 card-text text-muted">Price</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<script type="text/javascript" src="/js/jQuery.js"></script>
		<script type="text/javascript" src="/js/home.js"></script>
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
	</body>
</html>