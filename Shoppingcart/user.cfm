<cfset control = CreateObject("component", "components.control")>
<cfif NOT (structKeyExists(session, "user") 
    AND session.user.access)>
        <cflocation  url="login.cfm?log=1" addToken="no">
<cfelse>
    <cfset variables.carter = control.getCart(session.user.user)>
</cfif>
<cfif structKeyExists(form, 'okbtn')>
    <cfset variables.shipping = {
        'name' = form.name,
        'phone' = form.phone,
        'house' = form.house,
        'street' = form.street,
        'city' = form.city,
        'state' = form.state,
        'country' = form.country,
        'pincode' = form.pincode,
        'user' = session.user.user
    }>
    <cfif structKeyExists(form, 'shippingId') AND len(form.shippingId) NEQ 0>
        <cfset variables.shipping['id'] = form.shippingId>
    </cfif>
    <cfset control.modifyShipping(data=variables.shipping)>
<cfelseif structKeyExists(form, 'dltbtn')>
    <cfset control.deleteShipping(id=form.shippingId)>
</cfif>
<html lang="en">
	<head>
		<link href="/css/admin.css" rel="stylesheet">
		<link href="/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="container-fluid p-0 d-flex flex-column align-items-center">
		<nav id="main-nav" class="container-fluid navbar navbar-expand-lg justify-content-center bg-primary gap-5 z-3 fw-bold fixed-top" data-bs-theme="dark">
            <div class="flex-grow-1">
                <a class="navbar-brand" title="home" data-bs-toggle="tooltip" href="index.cfm">
                    <img src="/images/shop.png" width="40" height="40" class="img-fluid">
                    Shopping Cart
                </a>
            </div>
            <ul class="flex-grow-1 navbar-nav nav-tabs nav-justified">
                <li class="nav-item">
                    <a class="nav-link" title="cart" data-bs-toggle="tooltip" href="cart.cfm">
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
                    <a class="nav-link" title="logout" data-bs-toggle="tooltip" href="login.cfm?log=0">
                        <img src="/images/logout.png" class="img-fluid" alt="Login" width="30" height="30">
                    </a>
                </li>
            </ul>
		</nav>
        <div class="container-fluid d-flex flex-row flex-wrap align-items-start justify-content-start h-100 p-0 mt-5">
            <cfoutput>
                <div class="bg-dark h-100 d-flex flex-column align-items-center fw-bold col-4 gap-5 p-5">
                    <img class="img-fluid img-thumbnail rounded-circle" src="/uploads/#session.user.image#"
                        alt="Card image" height="80" data-bs-theme="dark">
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
                        <cfset variables.addresses = control.getShipping(user=session.user.user)>
                        <cfloop array="#variables.addresses#" item="address">
                            <cfoutput>
                                <div class="accordion-item">
                                    <div class="accordion-header">
                                        <span class="container-fluid accordion-button bg-primary gap-5">
                                            <h4 class="text-white w-75">#address.name#</h4>
                                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#chr(35)#modal"
                                                data-bs-action="edit" data-bs-id="#address.id#">
                                                    Edit
                                            </button>
                                            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#chr(35)#modal"
                                                data-bs-action="delete" data-bs-id="#address.id#">
                                                    Remove
                                            </button>
                                        </span>
                                    </div>
                                    <div class="accordion-body">
                                        <h4 class="text-muted">#address.phone#</h4>
                                        <h5 class="text-muted">
                                            #address.house#,
                                            #address.street#,
                                            #address.city#,
                                            #address.state#,
                                            #address.country#,
                                            PIN-#address.pincode#
                                        </h5>
                                    </div>
                                </div>
                            </cfoutput>
                        </cfloop>
                    </div>
                    <button id='add' class="card-footer btn fw-bold btn-primary btn-block" data-bs-toggle="modal" data-bs-target="#modal"
                        data-bs-action="add">
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
                                    <img src="/images/logout.png" class="col-5 img-fluid" alt="Login" width="40" height="40">
                                    <div class="col-5 d-flex flex-column">
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
            <div class="modal fade" id="modal" tabindex="-1" role="dialog" data-bs-theme="dark">
                <div class="modal-dialog">
                    <div class="modal-content d-flex p-3">
                        <div class="modal-header d-flex">
                            <h2 id="modalhead" class="modal-title flex-grow-1 fw-bold text-primary text-center">Shipping Address Details</h2>
                            <button type="button" class="btn-close border rounded" data-bs-dismiss="modal"></button>
                        </div>
                        <form id="addressForm" name="addressForm" class="modal-body d-flex flex-column gap-2 p-3" action="" method="post" enctype="multipart/form-data">
                            <fieldset id="modify-mode" class="d-flex flex-column rounded border gap-2 p-3">
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="name" name="name" placeholder="">
                                    <label for="name" class="form-label text-light">Name</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="phone" name="phone" placeholder="">
                                    <label for="phone" class="form-label text-light">Phone</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="house" name="house" placeholder="">
                                    <label for="house" class="form-label text-light">House/Flat</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="street" name="street" placeholder="">
                                    <label for="street" class="form-label text-light">Street</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="city" name="city" placeholder="">
                                    <label for="city" class="form-label text-light">City</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="state" name="state" placeholder="">
                                    <label for="state" class="form-label text-light">State</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="country" name="country" placeholder="">
                                    <label for="country" class="form-label text-light">Country</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="pincode" name="pincode" placeholder="">
                                    <label for="pincode" class="form-label text-light">Pincode</label>
                                </div>
                            </fieldset>
                            <fieldset class="delete-mode d-flex flex-column rounded border gap-2 p-3">
				                <legend class="text-center text-warning">Are you sure you want to remove this address?</legend>
                            </fieldset>
                            <input type="hidden" name="shippingId" id="shippingId">
                        </form>
                        <div class="modal-footer d-flex justify-content-between">
                            <button name="okbtn" id="okbtn" type="submit" class="btn btn-outline-success fw-bold" form="addressForm"></button>
                            <button name="dltbtn" id="dltbtn" type="submit" class="btn btn-outline-success fw-bold" form="addressForm">Yes</button>
                            <button type="button" class="btn btn-outline-danger fw-bold" data-bs-dismiss="modal">Cancel</button>
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