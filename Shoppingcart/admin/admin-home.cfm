<cfif NOT (structKeyExists(session, "check") 
        AND session.check.access)
    OR (structKeyExists(url, "logout")
        AND url.logout EQ 1)>
        <cfset structClear(session)>
        <cfset session.check = {
            "access" : false
        }>
	    <cflocation url="index.cfm" addToken="no">
</cfif>
<cfif structKeyExists(form, 'okbtn')>
    <cfset variables.input = {}>
    <cfif structKeyExists(form, 'category')>
        <cfset variables.input['category'] = form.category>
    </cfif>
    <cfif structKeyExists(form, 'subcategory')>
        <cfset variables.input['subcategory'] = form.subcategory>
    </cfif>
    <cfif structKeyExists(form, 'recordId') AND len(form.recordId) NEQ 0>
        <cfset variables.input['id'] = form.recordId>
    </cfif>
    <cfif NOT structIsEmpty(variables.input)>
        
    </cfif>
<cfelse>
</cfif>
<html lang="en">
	<head>
		<link href="/css/admin.css" rel="stylesheet">
		<link href="/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="d-flex flex-row align-items-center">
		<nav class="navbar navbar-expand-lg navbar-light fixed-top" data-bs-theme="dark">
			<div class="container-fluid bg-success fw-bold">
				<a class="navbar-brand text-info" href="">
					<img src="/images/shop.png" width="40" height="40" class="rounded-pill">
					Shopping Cart
				</a>
				<ul class="navbar-nav nav-tabs nav-justified">
					<li class="nav-item">
						<a class="nav-link bg-success active text-info" href="admin-home.cfm?logout=1">
							Log out
						</a>
					</li>
				</ul>
			</div>
		</nav>
		<div class="container-fluid row d-flex justify-content-around rounded-3 mx-auto mt-5 p-3" data-bs-theme="dark">
            <div id="categories" class="card col-3 rounded-3 p-3">
                <p class="h2 card-header card-title text-center text-success">Categories</p>
                <div id="categorylist" class="card-body list-group"></div>
                <button id="addCategory" name="addCategory" class="card-footer btn btn-primary btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="add" data-bs-set="category">
                    <img src="/images/add.png" width="40" height="40" class="img-fluid">
                </button>
            </div>
            <div id="subcategories" class="card col-3 rounded-3 p-3">
                <p class="h2 card-header card-title text-center text-success">Sub categories</p>
                <div id="subcategorylist" class="card-body list-group"></div>
                <button id="addSubcategory" name="addSubcategory" class="card-footer btn btn-primary btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="add" data-bs-set="subcategory">
                    <img src="/images/add.png" width="40" height="40" class="img-fluid">
                </button>
            </div>
            <div id="products" class="card col-3 rounded-3 p-3">
                <p class="h2 card-header card-title text-center text-success">Products</p>
                <div id="productlist" class="card-body list-group"></div>
                <button id="addProduct" name="addProduct" class="card-footer btn btn-primary btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="add" data-bs-set="product">
                    <img src="/images/add.png" width="40" height="40" class="img-fluid">
                </button>
            </div>
            <div class="modal fade" id="modal" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content d-flex p-3">
                        <div class="modal-header d-flex">
                            <h2 id="modalhead" class="modal-title flex-grow-1 fw-bold text-info text-center"></h2>
                            <button type="button" class="btn-close border rounded" data-bs-dismiss="modal"></button>
                        </div>
                        <form id="modalForm" name="modalForm" class="modal-body d-flex flex-column gap-1" action="" method="post" enctype="multipart/form-data">
                            <div class="category form-floating">
                                <input type="text" name="category" id="category" class="form-control text-warning" placeholder="">
                                <label for="category" class="form-label text-light">Category</label>
                            </div>
                            <div class="subcategory form-floating">
                                <input type="text" name="subcategory" id="subcategory" class="form-control text-warning" placeholder="">
                                <label for="subcategory" class="form-label text-light">Sub category</label>
                            </div>
                            <fieldset id="product" class="product d-flex flex-column rounded border gap-2 p-3">
                                <legend class="text-primary">
                                    Product Details
                                    <hr class="border-5">
                                </legend>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="productName" name="productName" placeholder="">
                                    <label for="productName" class="form-label text-light">Product Name</label>
                                </div>
                                <div class="form-floating">
                                    <textarea class="form-control text-warning" id="productDesc" name="productDesc" placeholder=""></textarea>
                                    <label for="productDesc" class="form-label text-light">Product Description</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control text-warning" type="text" id="price" name="price" placeholder="">
                                    <label for="price" class="form-label text-light">Price</label>
                                </div>
                                <div class="d-flex">
                                    <img id="editImageView" src="" class="img-thumbnail img-fluid" alt="viewImage" data-bs-theme="dark"> 
                                    <div class="form-floating">
                                        <input class="form-control text-warning" type="file" name="productPic" id ="productPicture" accept="image/jpeg, image/png">
                                        <label for="productPicture" class="form-label text-light text-start">Product Picture</label>	
                                    </div>
                                </div>
                            </fieldset>
                            <input type="hidden" name="recordId" id="recordId">
                            <fieldset class="delete-mode d-flex flex-column rounded border gap-2 p-3">
				                <legend class="text-warning">Are you sure you want to delete this contact?</legend>
                            </fieldset>
                        </form>
                        <div class="modal-footer d-flex justify-content-between">
                            <button name="okbtn" id="okbtn" type="submit" class="btn btn-outline-success fw-bold" form="modalForm"></button>
                            <button name="dltbtn" id="dltbtn" type="submit" class="btn btn-outline-success fw-bold" form="modalForm">Yes</button>
                            <button type="button" class="btn btn-outline-danger fw-bold" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
		</div>
		<script type="text/javascript" src="/js/jQuery.js"></script>
		<script type="text/javascript" src="/js/admin-home.js"></script>
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
	</body>
</html>