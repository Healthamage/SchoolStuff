var canvas = null; 
var context = null;

var cercle_x=50;
var cercle_y=100;
var suivre=false;

function effacer_text(){
	$("#message").text("");
}

// Dessin unitaire
$(document).ready(function(){
	canvas = document.getElementById('exercice'); 
	context = canvas.getContext("2d"); 
	
	canvas.addEventListener('mousedown', doMouseDown);
	canvas.addEventListener('mouseup', doMouseUp);
	canvas.addEventListener('mousemove', doMouseMove);
});

function doMouseDown(event){
	//Change les coordonnées du cercle par ceux choisi par la souris
	updateMousePosition(event);
	suivre = true;
	
	dessine_cercle();
}

function doMouseUp(event){
	suivre=false;
}

function doMouseMove(event){
	if(suivre){
		updateMousePosition(event);
		dessine_cercle();
	}
}

function updateMousePosition(event){
	cercle_x = event.pageX;
	cercle_y = event.pageY - canvas.offsetTop;	
}

function dessine_cercle(){
	context.beginPath(); // Vide le buffer
	context.lineWidth = 1;
	context.arc(cercle_x,cercle_y,$("#pen_range").val(),0,2*Math.PI);
	context.fillStyle = $("#color_picker").val();
	context.strokeStyle=$("#color_picker").val();
	context.fill();
	context.stroke();	
}

function clear_screen(){
	context.fillStyle = 'white'; 
	context.fillRect(0, 0, canvas.width, canvas.height); 
}