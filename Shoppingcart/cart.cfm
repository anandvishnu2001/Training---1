<cfset control = CreateObject("component", "components.control")>
<cfif structKeyExists(session, 'user') 
    AND session.user.access>
    <cfif structKeyExists(url, 'pro')>
        <cfset control.addCart(product=url.pro,user=session.user.user)>
        <cflocation  url="cart.cfm" addToken="no">
    </cfif>
    <cfset variables.carter = control.getCart(session.user.user)>
<cfelseif structKeyExists(url, 'pro')>
    <cflocation url="login.cfm?pro=#url.pro#&site=cart" addToken="no">
<cfelse>
    <cflocation url="login.cfm" addToken="no">
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
                    <a class="nav-link active" href="cart.cfm">
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
                    <a class="nav-link" href="user.cfm">
                        <cfoutput>
                            <img src="/uploads/#session.user.image#" class="img-fluid rounded-circle" alt="Login" width="30" height="30">
                        </cfoutput>
                    </a>
                </li>
            </ul>
		</nav>
        <div class="container-fluid d-flex flex-row justify-content-evenly align-items-start gap-5 p-5 mt-5">
            <div class="card bg-light fw-bold col-6 p-3">
                <ul class="card-body list-group d-flex flex-column p-5">
                    <cfset variables.cartTotal = 0>
                    <cfif arrayLen(variables.carter) NEQ 0>
                        <cfloop array="#variables.carter#" item="item">
                            <cfoutput>
                                <li class="list-group-item d-flex flex-column gap-3 p-5">
                                    <cfset variables.cartProduct = control.getProduct(product=item.product)>
                                    <div class="d-flex flex-row flex-wrap justify-content-evenly">
                                        <img class="card-img w-25 h-auto img-fluid img-thumbnail" src="/uploads/#variables.cartProduct[1].image#"
                                            alt="Card image" data-bs-theme="dark">
                                        <div class="col-5 d-flex flex-column justify-content-evenly fw-bold">
                                            <p class="h4 card-title text-info">#variables.cartProduct[1].name#</p>
                                            <cfset variables.cartTotal += variables.cartProduct[1].price*item.quantity>
                                            <p class="card-text text-danger">#variables.cartProduct[1].price*item.quantity#</p>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-evenly">
                                        <button onclick="changeQuantity(#item.id#,'decrement')" class="btn btn-secondary rounded-pill <cfif item.quantity LTE 1>disabled</cfif>">-</button>
                                        <p class="card-text text-muted">#item.quantity#</p>
                                        <button onclick="changeQuantity(#item.id#,'increment')" class="btn btn-secondary rounded-pill">+</button>
                                        <button onclick="removeCartProduct(#item.id#)" class="btn btn-danger">Remove item</button>
                                    </div>
                                </li>
                            </cfoutput>
                        </cfloop>
                    <cfelse>
                        <h1 class="text-center text-warning">Cart is Empty!!</h1>
                    </cfif>
                </ul>
            </div>
            <div class="card bg-light fw-bold col-4 p-3 gap-5 p-5">
                <cfoutput>
                    <p class="card-text bg-info text-center text-danger">Total Price :<br>#variables.cartTotal#</p>
                    <cfif arrayLen(variables.carter) NEQ 0>
                        <a class="btn btn-success" href="payment.cfm">Check out</a>
                    </cfif>
                    <button onclick="removeCart(#session.user.user#)" class="btn btn-danger">Empty cart</button>
                </cfoutput>
            </div>
        </div>
		<script type="text/javascript" src="/js/jQuery.js"></script>
		<script type="text/javascript" src="/js/home.js"></script>
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
	</body>
</html>