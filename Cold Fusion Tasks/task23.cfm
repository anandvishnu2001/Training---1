<form name="register" id="register" method="post" action="">
	<header>
		<h1>Employment Application</h1>
		<h3>Fields marked with (*) are mandatory.</h3>
	</header>
	<div>
		<label for="position">Which position are you applying for?<span style="color:red;">*</span></label>
		<select name="position" id="position">
			<option value=""></option>
			<option value="Interface Designer">Interface Designer</option>
			<option value="Software Engineer">Software Engineer</option>
			<option value="System Administrator">System Administrator</option>
			<option value="Office Manager">Office Manager</option>
		</select>
	</div>
	<legend>Are you willing to relocate?<span style="color:red;">*</span></legend>
	<div>
		<input name="relocation" id="yes" type="radio" value="yes"/><label for="yes">Yes</label>
		<input name="relocation" id="no" type="radio" value="no"/><label for="no">No</label>
	</div>
	<div>
		<label for="start">When can you start?<span style="color:red;">*</span></label>
		<input name="start" id="start" type="date"/>
	</div>
	<div>
		<label for="web">Portfolio Web Site</label>
		<input id="web" name="web" type="text" value="http://">
	</div>
	<div>
		<label for="resume">Attach a Copy of Your Resume</label>
		<input name="resume" id="resume" type="file" accept="image/*"/>
	</div>
	<div>
		<label for="salary">Salary Requirements</label>
		<input name="salary" id="salary" type="number"/>
	</div>
	<div>
		<label for="name">Name<span style="color:red;">*</span></label>
		<input name="name" id="name" type="text"/>
	</div>
	<div>
		<label for="email">Email Address<span style="color:red;">*</span></label>
		<input name="email" id="email" type="email"/>
	</div>
	<div>
		<label for="phone">Phone<span style="color:red;">*</span></label>
		<input name="phone" id="phone" type="number" pattern="[0-9]{10}"/>
	</div>
	<input name="btn" type="submit" value="Submit"/>
</form>
<cfobject component="database" name="data">
<script>
	let form = document.forms["register"];
	let names = ['position','relocation','start','name','email','phone'];
	form.addEventListener("submit",(event) => {
		let valid = true;
		let alerts = document.querySelectorAll('.alerts');
		alerts.forEach(alert => alert.remove());
		for(let i in names){
			let n = form.elements.namedItem(names[i]);
			if(n instanceof NodeList && n.value == ''){
				n[0].insertAdjacentHTML('beforebegin', '<span class="alerts" style="color:red;">*Field is required</span>');
				valid = false;
			}
			else if(!n.value){
				n.insertAdjacentHTML('beforebegin', '<span class="alerts" style="color:red;">*Field is required</span>');
				valid = false;
			}
		}
		if(!valid)
			event.preventDefault();
	});
</script>