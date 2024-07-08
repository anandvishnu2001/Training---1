const name = document.getElementById("name");
const phone = document.getElementById("phone");
const profile = document.getElementById("profile");
const dob = document.getElementById("dob");
const job = document.getElementById("job");
const bio = document.getElementById("bio");
const email = document.getElementById("email");
const password = document.getElementById("password");
const terms = document.getElementById("terms");
const verify = document.getElementById("verify");

const gender = document.getElementsByName("gender");
const marital = document.getElementsByName("marital");


const namePop = document.getElementById("npop");
const phonePop = document.getElementById("phpop");
const profilePop = document.getElementById("prpop");
const dobPop = document.getElementById("dpop");
const genderPop = document.getElementById("gpop");
const maritalPop = document.getElementById("mpop");
const jobPop = document.getElementById("jpop");
const bioPop = document.getElementById("bpop");
const emailPop = document.getElementById("epop");
const passwordPop = document.getElementById("papop");
const termsPop = document.getElementById("tpop");

let emailValid = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

let passwordValid = /^([A-Za-z0-9!@#$%^&*()_+-]){8,}$/;

let phoneValid = /^([0-9]){10}$/;

function Email(){
	if(!email.value.match(emailValid)){
		emailPop.innerHTML = "*Email form should be example@mail.dns";
		emailPop.style.color = "red";
	}
	else{
		emailPop.innerHTML ="*Valid form verified";
		emailPop.style.color = "green";
	}
}

function Password(){
	if(!password.value.match(passwordValid)){
		passwordPop.innerHTML = "*Password should have atleast 8 characters<br>alphabets, numbers and !@#$%^&*()_+-";
		passwordPop.style.color = "red";
	}
	else{
		passwordPop.innerHTML ="*Valid form verified";
		passwordPop.style.color = "green";
	}
}

function Phone(){
	if(!phone.value.match(phoneValid)){
		phonePop.innerHTML = "*Phone should have only 10 numbers";
		phonePop.style.color = "red";
	}
	else{
		phonePop.innerHTML ="*Valid form verified";
		phonePop.style.color = "green";
	}
}

const form = document.getElementById("register");

form.addEventListener('submit', function(e)
{	
	let valid = true;

	if(name.value == '' || name.value == null)
	{
		valid = false;
		namePop.innerHTML = "*Name field is required";
		namePop.style.color = "red";
	}
	else
	{
		namePop.innerHTML = "*Valid form verified";
		namePop.style.color = "green";
	}

	if(phone.value.length == 0)
	{
		valid = false;
		phonePop.innerHTML = "*Phone field is required";
		phonePop.style.color = "red";
	}
	else
	{
		phonePop.innerHTML = "*Valid form verified";
		phonePop.style.color = "green";
	}

	if(profile.value == '' || profile.value == null)
	{
		valid = false;
		profilePop.innerHTML = "*Profile picture should be uploaded";
		profilePop.style.color = "red";
	}
	else
	{
		profilePop.innerHTML = "*Valid form verified";
		profilePop.style.color = "green";
	}

	if(dob.value == '' || dob.value == null)
	{
		valid = false;
		dobPop.innerHTML = "*Date of Birth field is required";
		dobPop.style.color = "red";
	}
	else
	{
		dobPop.innerHTML = "*Valid form verified";
		dobPop.style.color = "green";
	}

	g = 0;
	for (let i = 0; i < gender.length; i++) {
		if (gender[i].checked) {
    			g += 1;
			break;
  		}
	}
	if(g == 0)
	{
		valid = false;
		genderPop.innerHTML = "*Atleast one choice should be chosen";
		genderPop.style.color = "red";
	}
	else
	{
		genderPop.innerHTML = "*Valid form verified";
		genderPop.style.color = "green";
	}	

	m = 0;
	for (let i = 0; i < marital.length; i++) {
		if (marital[i].checked) {
    			m += 1;
			break;
  		}
	}
	if(m == 0)
	{
		valid = false;
		maritalPop.innerHTML = "*Atleast one choice should be chosen";
		maritalPop.style.color = "red";
	}
	else
	{
		maritalPop.innerHTML = "*Valid form verified";
		maritalPop.style.color = "green";
	}	

	if(job.value == '')
	{
		valid = false;
		jobPop.innerHTML = "*Atleast select one option";
		jobPop.style.color = "red";
	}
	else
	{
		jobPop.innerHTML = "*Valid form verified";
		jobPop.style.color = "green";
	}
	
	if(bio.value == '' || bio.value == null)
	{
		valid = false;
		bioPop.innerHTML = "*Description field is required";
		bioPop.style.color = "red";
	}
	else
	{
		bioPop.innerHTML = "*Valid form verified";
		bioPop.style.color = "green";
	}
	
	if(email.value == '' || email.value == null)
	{
		valid = false;
		emailPop.innerHTML = "*Email field is required";
		emailPop.style.color = "red";
	}
	else
	{
		emailPop.innerHTML = "*Valid form verified";
		emailPop.style.color = "green";
	}

	if(password.value == '' || password.value == null)
	{
		valid = false;
		passwordPop.innerHTML = "*Password field is required";
		passwordPop.style.color = "red";
	}
	else
	{
		passwordPop.innerHTML = "*Valid form verified";
		passwordPop.style.color = "green";
	}		
	
	if(!terms.checked)
	{
		valid = false;
		termsPop.innerHTML = "*Checkbox should be checked";
		termsPop.style.color = "red";
	}
	else
	{
		termsPop.innerHTML = "*Valid form verified";
		termsPop.style.color = "green";
	}
		
	window.scrollTo(0,0);
	if(!valid)
	{
		e.preventDefault();
		alert("All fields are mandatory");	
	}
	else{
		alert("All fields are verified");
	}
});