<cfset control = CreateObject("component", "components.control")>
<cfif NOT (structKeyExists(session, "user") 
    AND session.user.access)>
        <cfset session.user = {
            "access" = false
        }>
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
            <ul class="flex-grow-1 navbar-nav nav-pills nav-justified">
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
                <div class="bg-dark h-100 d-flex flex-column fw-bold col-4 p-5">
                    <img class="w-100 h-auto img-fluid img-thumbnail rounded-circle" src="/uploads/#session.user.image#"
                        alt="Card image" data-bs-theme="dark">
                    <h1 class="text-center text-info fw-bold">#session.user.name#</h1>
                    <a type="submit" class="btn fw-bold btn-primary btn-block" href="">
                        Details
                    </a>
                </div>
            </cfoutput>
            <div class="h-100 d-flex flex-column fw-bold col-8 p-5">
                <div class="card bg-light fw-bold col-auto p-5">
                    <ul class="card-body list-group p-3 d-flex fw-bold">
                        <li class="d-flex flex-wrap justify-content-evenly list-group-item border border-warning">
                            <div class="flex-grow-1 d-flex justify-content-evenly">
                                <p class="h5 card-text text-primary">House/flat</p>
                                <p class="h5 card-text text-primary">city</p>
                            </div>
                            <div class="col-5 d-flex justify-content-evenly">
                                <p class="h5 card-text text-primary">state</p>
                                <p class="h5 card-text text-primary">country</p>
                            </div>
                            <div class="col-5 d-flex justify-content-evenly">
                                <p class="h5 card-text text-primary">pincode</p>
                                <p class="h5 card-text text-primary">phone</p>
                            </div>
                            <div class="col-5 d-flex justify-content-evenly">
                                <a type="submit" class="btn fw-bold btn-primary btn-block" href="">
                                    Details
                                </a>
                                <a type="submit" class="btn fw-bold btn-primary btn-block" href="">
                                    Details
                                </a>
                            </div>
                        </li>
                        <li class="list-group-item border border-warning">
                            <div class="d-flex justify-content-evenly">
                                <p class="h5 card-text text-primary">House/flat</p>
                                <p class="h5 card-text text-primary">city</p>
                            </div>
                            <div class="d-flex justify-content-evenly">
                                <p class="h5 card-text text-primary">state</p>
                                <p class="h5 card-text text-primary">country</p>
                                <p class="h5 card-text text-primary">pincode</p>
                            </div>
                            <a class="btn fw-bold btn-primary btn-block" href="">
                                Details
                            </a>
                            <a class="btn fw-bold btn-primary btn-block" href="">
                                Add
                            </a>
                        </li>
                    </ul>
                    <a class="card-footer btn fw-bold btn-primary btn-block" href="">
                        <span class="h3">Address</span>
                        <img src="/images/add.png" class="img-fluid" alt="Login" width="25" height="25">
                    </a>
                </div>
            </div>
        </div>
		<script type="text/javascript" src="/js/jQuery.js"></script>
		<script type="text/javascript" src="/js/home.js"></script>
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
	</body>
</html>