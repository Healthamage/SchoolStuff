var PlayerState = {
  	PLAYING:0,
  	WAITING:1,
  	WINNER:2,
  	LOSER:3
};
class Player {
	
  	constructor(nom,score,rating) {
	  	this.nom = nom;
	  	this.score = score;
	  	this.rating = rating;
	  	this.timeLeft = 60;
	  	this.state = PlayerState.WAITING;
  	}
 	drawAsTopPlayer(context){
 		var fontSizeInfo = 0.04 * context.canvas.height ;
  		context.fillStyle="#000000";
		context.font = fontSizeInfo + "px sans-serif";
		//playerInfo
		context.fillText(this.nom, 0.80 *canvasWidth , 0.15 *canvas.height);
		context.fillText("score:", 0.80 *canvasWidth , 0.20 *canvas.height);
		context.fillText(this.score, 0.90 *canvasWidth , 0.20 *canvas.height);
	    context.fillText("rating :", 0.80 *canvasWidth , 0.25 *canvas.height);
		context.fillText(this.rating, 0.90 *canvasWidth , 0.25 *canvas.height);
	    context.fillText("temps :", 0.80 *canvasWidth , 0.30 *canvas.height);
	    context.fillText(Math.round(this.timeLeft)+"s", 0.90 *canvasWidth , 0.30 *canvas.height);
	    
	    //Dot rouge,vert dependant si cest ton tour
	    if(this.state == PlayerState.PLAYING)
	    	context.fillStyle="#00ff00";
	    else if(this.state == PlayerState.WAITING)
	    	context.fillStyle="#ff0000";
	    context.beginPath();
		context.arc(0.97 *context.canvas.width,0.29 *context.canvas.height,0.02 *context.canvas.height ,0,360);
		context.fill();
  	}
  	drawAsBottomPlayer(context){
	  	var fontSizeInfo = 0.04 * context.canvas.height;
	  	context.fillStyle="#000000";
		context.font = fontSizeInfo + "px sans-serif";
		//playerInfo
	    context.fillText(this.nom, 0.80 *canvasWidth , 0.55 *canvas.height);
		context.fillText("score:", 0.80 *canvasWidth , 0.60 *canvas.height);
		context.fillText(this.score, 0.90 *canvasWidth , 0.60 *canvas.height);
	    context.fillText("rating :", 0.80 *canvasWidth , 0.65 *canvas.height);
		context.fillText(this.rating, 0.90 *canvasWidth , 0.65 *canvas.height);
	    context.fillText("temps :", 0.80 *canvasWidth , 0.70 *canvas.height);
	    context.fillText(Math.round(this.timeLeft)+"s", 0.90 *canvasWidth , 0.70 *canvas.height);
	    //Dot rouge,vert dependant si cest ton tour
	    if(this.state == PlayerState.PLAYING)
	    	context.fillStyle="#00ff00";
	    else if(this.state == PlayerState.WAITING)
	    	context.fillStyle="#ff0000";
		context.beginPath();
		context.arc(0.97 *context.canvas.width,0.69 *context.canvas.height,0.02 *context.canvas.height ,0,360);
		context.fill();

		//les box si il est gagnant ou perdant
		if(this.state == PlayerState.WINNER)
			drawMessageBox("MATCH TERMINe","felicitation vous avez gagne",context);
		else if(this.state == PlayerState.LOSER)
			drawMessageBox("MATCH TERMINe","Desole vous avez perdu",context);
		else if(this.state == PlayerState.WAITING)
			drawMessageBox("EN ATTENTE","en attente de votre adversaire",context);
  	}
  	drawMessageBox(title,text,context){
		var width = context.canvas.width * 0.33;
		var height = context.canvas.height * 0.33;

		context.fillStyle="#0040ff";
		context.fillRect((context.canvas.width / 2 ) - (width/2) ,(context.canvas.height / 2) - (height/2) ,width,height);

		//titre
		context.fillStyle="#000000";
		context.font = fontSizeInfo + "px sans-serif";
		context.fillText(title, context.canvas.width / 2 - 0.33 * width  , context.canvas.height / 2 - 0.40 * height);
		//texte
		context.fillStyle="#000000";
		context.font = fontSizeInfo + "px sans-serif";
		context.fillText(text, context.canvas.width / 2 - 0.20 * width  , context.canvas.height / 2 - 0.10 * height);
	}
  	play(){
  		this.state = PlayerState.PLAYING;
  	}
  	endTurn(){
  		this.state = PlayerState.WAITING;
  	}
  	updateTime(elapsedTime){
  		this.timeLeft -= 0.001 * elapsedTime;
  	}
  	equals(player){
  		if(this.nom != player.nom){return false;}
  		return true;
  	}
  	succes(){
  		this.timeLeft += 10;
  		this.score++;
  	}
  	win(){
  		this.state = PlayerState.WINNER;
  	}
  	lose(){
  		this.state = PlayerState.LOSER;
  	}

  	
	
}