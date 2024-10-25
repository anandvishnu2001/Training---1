<html lang="en">
	<head>
		<link href="./css/admin.css" rel="stylesheet">
		<link href="./css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body class="d-flex flex-row align-items-center">
		<nav class="navbar navbar-expand-lg navbar-light fixed-top" data-bs-theme="dark">
			<div class="container-fluid bg-success fw-bold">
				<a class="navbar-brand text-info" href="">
					<img src="./images/shop.png" width="40" height="40" class="rounded-pill">
					Shopping Cart
				</a>
				<ul class="navbar-nav nav-tabs nav-justified">
					<li class="nav-item">
						<a class="nav-link bg-success active text-info" href="">
							Log in
						</a>
					</li>
				</ul>
			</div>
		</nav>
		<div class="container-fluid row d-flex justify-content-around rounded-3 mx-auto mt-5 p-3" data-bs-theme="dark">
            <div id="categories" class="card col-3 rounded-3 p-3">
                <p class="h2 card-header card-title text-center text-success">Categories</p>
                <div id="categorylist" class="card-body list-group"></div>
                <button id="addCategory" name="addCategory" class="card-footer btn btn-primary btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="add">Add</button>
            </div>
            <div id="subcategories" class="card col-3 rounded-3 p-3">
                <p class="h2 card-header card-title text-center text-success">Sub categories</p>
                <div id="subcategorylist" class="card-body list-group"></div>
                <button id="addSubcategory" name="addSubcategory" class="card-footer btn btn-primary btn-block">Add</button>
            </div>
            <div id="products" class="card col-3 rounded-3 p-3">
                <p class="h2 card-header card-title text-center text-success">Products</p>
                <div id="productlist" class="card-body list-group"></div>
                <button id="addProduct" name="addProduct" class="card-footer btn btn-primary btn-block">Add</button>
            </div>
            <div class="modal fade" id="modal">
                <div class="modal-dialog">
                    <div class="modal-content d-flex p-3">
                        <div class="modal-header d-flex">
                            <h2 id="modalhead" class="modal-title flex-grow-1 fw-bold text-info text-center"></h2>
                            <button type="button" class="btn-close border rounded" data-bs-dismiss="modal"></button>
                        </div>
                        <form id="modalForm" name="modalForm" class="modal-body d-flex flex-column gap-1" action="" method="post" enctype="multipart/form-data">
                            <div class="modify-mode form-floating">
                                <input type="text" name="category" id="category" class="form-control" placeholder="">
                                <label for="category" class="form-label text-light">Category</label>
                            </div>
                            <div class="modify-mode form-floating">
                                <input type="text" name="subcategory" id="subcategory" class="form-control" placeholder="">
                                <label for="subcategory" class="form-label text-light">Sub category</label>
                            </div>
                            <fieldset class="modify-mode d-flex flex-column rounded border gap-2 p-3">
                                <legend class="text-primary">
                                    Product Details
                                    <hr class="border-5">
                                </legend>
                                <div class="form-floating">
                                    <input class="form-control" type="text" id="productName" name="productName" placeholder="">
                                    <label for="productName" class="form-label text-light">Product Name</label>
                                </div>
                                <div class="form-floating">
                                    <textarea class="form-control" id="productDesc" name="productDesc" placeholder=""></textarea>
                                    <label for="productDesc" class="form-label text-light">Product Description</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control" type="text" id="price" name="price" placeholder="">
                                    <label for="price" class="form-label text-light">Price</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control" type="file" name="productPic" id ="productPicture" accept="image/jpeg, image/png">
                                    <label for="productPicture" class="form-label text-light text-start">Product Picture</label>	
                                </div>
                            </fieldset>
                            <fieldset class="delete-mode d-flex flex-column rounded border gap-2 p-3">
				                <legend class="text-warning">Are you sure you want to delete this contact?</legend>
                                <input type="hidden" name="d_id" id="d_id">
                            </fieldset>
                        </form>
                        <div class="modal-footer d-flex justify-content-between">
                            <button name="okbtn" id="okbtn" type="submit" class="btn btn-outline-success fw-bold"></button>
                            <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
		</div>
		<script type="text/javascript" src="./js/jQuery.js"></script>
		<script type="text/javascript" src="./js/admin-home.js"></script>
		<script type="text/javascript" src="./js/bootstrap.min.js"></script>
	</body>
</html>