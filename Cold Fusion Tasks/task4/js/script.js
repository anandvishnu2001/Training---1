let e = document.getElementsByClassName('week');
for(let i = 0;i < e.length; i++){
	switch(e[i].innerHTML){
		case 'Sunday':	e[i].style.color = 'red';
				break;
		case 'Monday':	e[i].style.color = 'green';
				break;
		case 'Tuesday':	e[i].style.color = 'orange';
				break;
		case 'Wednesday':e[i].style.color = 'yellow';
				break;
		case 'Thursday':e[i].style.color = 'black';
				e[i].style.fontWeight = 'bold';
				break;
		case 'Friday':	e[i].style.color = 'blue';
				break;
		case 'Saturday':e[i].style.color = 'red';
				e[i].style.fontWeight = 'bold';
				break;
	}
}