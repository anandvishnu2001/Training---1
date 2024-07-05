const name = document.getElementByName("name");
const phone = document.getElementByName("phone");
const profile = document.getElementByName("profile");
const dob = document.getElementByName("dob");
const gender = document.getElementByName("gender");
const marital = document.getElementByName("marital");
const job = document.getElementByName("job");
const bio = document.getElementByName("bio");
const email = document.getElementByName("email");
const password = document.getElementByName("password");
const terms = document.getElementByName("terms");
const verify = document.getElementByName("verify");

const namePop = document.getElementByName("npop");
const phonePop = document.getElementByName("phpop");
const profilePop = document.getElementByName("prpop");
const dobPop = document.getElementByName("dpop");
const genderPop = document.getElementByName("gpop");
const maritalPop = document.getElementByName("mpop");
const jobPop = document.getElementByName("jpop");
const bioPop = document.getElementByName("bpop");
const emailPop = document.getElementByName("epop");
const passwordPop = document.getElementByName("papop");
const termsPop = document.getElementByName("tpop");

let emailValid = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
let passwordValid = /^([A-Za-z0-9*#_])$/;

let valid = verify;

if ( name == '' || name == null ) {
	namePop.innerHTML = "*Name field should not be empty.";
	valid+=1;
}
else {
	namePop = "*Name field verified"
}

if ( phone