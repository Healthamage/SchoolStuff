var canvas = null; 
var context = null;

var indexCarteSelectionner = new Array();
var click =false; 
var canvasHeight = 480;
var canvasWidth = 640;
var fontSizeInfo = canvasHeight / 25;

var firstCardPositionX =  0.10 *canvasWidth;
var firstCardPositionY = 0.12 * canvasHeight;
var hourglass = new HourGlass();
var cards = [];
var boardWidthSize = 4;
var boardHeightSize = 4;
var cardsTableWidth = 0.60 * canvasWidth;
var cardsTableHeight = 0.65*canvasHeight;
var cardWidthSize = cardsTableWidth / boardWidthSize;
var cardHeightSize = cardsTableHeight / boardHeightSize;
var cardImage;
var selectedCards = [];
var nbCarteDecouverte = 0;
var player;
var adversaire;
var currentPlayer;
var cardInfo = [["1/2",0],["0.5",0],["1/4",1],["0.25",1],
				["1/8",2],["0.125",2],["3/4",3],["0.75",3],
				["3/8",4],["0.375",4],["7/8",5],["0.875",5],
				["5/8",6],["0.675",6],["1/4",7],["2/8",7]];
var cardState = {
  COUVERTE : 0,
  DECOUVERTE: 1,
  DECOUVRAGE : 2,
  COUVRAGE : 3,
  DISPARISSAGE: 4,
  READY : 5
};
function HourGlass(){
	this.imgSource;
	this.frame = 0;
	this.loopCount = 0;
	this.x = 0;
	this.y = 0;
	this.width = 0;
	this.height = 0;
	this.init = function(){
		this.imgSource = new Image();
		this.imgSource.src = "hourglass.png";
		this.x = 0.77 * canvasWidth;
		this.y = 0.30 * canvasHeight;
		this.width = 0.15 * canvasWidth;
		this.height = 0.15 * canvasWidth;
	}
	this.draw = function(){
			this.loopCount++;
			this.frame = this.loopCount % 8;
			if(this.frame < 4)
				context.drawImage(this.imgSource,this.frame * 68,7,70,70,this.x,this.y,this.width,this.height);
			else
				context.drawImage(this.imgSource,(this.frame - 4) * 68,77,70,70,this.x,this.y,this.width,this.height);
		
	}
}
function Card(x,y,text,id){
	this.x = x;
	this.y = y;
	this.text = text;
	this.isFound = false;
	this.id = id;//id to compare same id = match
	this.state = cardState.COUVERTE; //couverte,decouverte,en animation
	this.frame = 0;
	this.drawCard = function(){
		switch(this.state){
			case cardState.COUVERTE:
				context.drawImage(cardImage,0,56,32,44,x,y,cardWidthSize,cardHeightSize);
				break;
			case cardState.DECOUVERTE:
				context.beginPath();
				context.lineWidth="2";
				context.strokeStyle="black";
				context.rect(x,y,cardWidthSize,cardHeightSize);
				context.stroke();
				context.strokeText(this.text,x+(0.25*cardWidthSize),y+(0.45*cardWidthSize));
				this.frame++;
				if(this.frame > 30)
					this.state = cardState.READY;
				break;
			case cardState.READY:
				context.beginPath();
				context.lineWidth="2";
				context.strokeStyle="black";
				context.rect(x,y,cardWidthSize,cardHeightSize);
				context.stroke();
				context.strokeText(this.text,x+(0.25*cardWidthSize),y+(0.45*cardWidthSize));
				break;
			case cardState.DECOUVRAGE:
				context.drawImage(cardImage,32 * this.frame,56,32,44,x,y,cardWidthSize,cardHeightSize);
				this.frame++;
				if(this.frame > 7){
					this.state = cardState.DECOUVERTE;
					this.frame = 0;
				}
				break;
			case cardState.COUVRAGE:
				context.drawImage(cardImage,32 * (8-this.frame),56,32,44,x,y,cardWidthSize,cardHeightSize);
				this.frame++;
				if(this.frame > 8){
					this.state = cardState.COUVERTE;
					frame = 0;
				}
				break;
			case cardState.DISPARISSAGE:
				break;
		}
	}
	this.isClicked = function(event){
		if(event.pageX < this.x) {return false;}
		if(event.pageY < this.y) {return false;}
		if(event.pageX > this.x+cardWidthSize) {return false;}
		if(event.pageY > this.y+cardHeightSize) {return false;}

		return true;
	}
}
window.requestAnimFrame = function(){
    return (
        window.requestAnimationFrame       || 
        window.webkitRequestAnimationFrame || 
        window.mozRequestAnimationFrame    || 
        window.oRequestAnimationFrame      || 
        window.msRequestAnimationFrame     || 
        function(/* function */ callback){
            window.setTimeout(callback, 1000 / 60);
        }
    );
}();

function startGame() {
    canvas = document.getElementById('canvas'); 
    canvas.height = canvasHeight;
    canvas.width = canvasWidth;
    context = canvas.getContext("2d"); 
	cardImage = new Image();
	cardImage.src = "carteSpriteSheet.png";
	player = new Player("guest1",0,1000);
	adversaire = new Player("guest2",0,2000);
	currentPlayer = player;
	player.play();
	cards = [];
	//a remplir avec le serveur normalement
	for (i = 0; i < boardHeightSize; i++){
		card = [];
		var y = firstCardPositionY + (i * cardHeightSize);
		for(j = 0 ; j < boardWidthSize ; j++){
			var x = firstCardPositionX + (j *cardWidthSize);
			card.push( new Card(x,y,cardInfo[i*4+j][0],cardInfo[i*4+j][1]));
		}
		cards.push(card);
	}

	canvas.addEventListener('mousedown', doMouseDown);
	canvas.addEventListener('mouseup', doMouseUp);
	hourglass.init();
	draw();
}


function doMouseUp(event){
	click=false;
}
function doMouseDown(event){

	if(currentPlayer.equals(player)){
		if(!click){
			for (i = 0; i < boardHeightSize; i++){
				for(j = 0 ; j < boardWidthSize ; j++){
					if( cards[i][j].state == cardState.COUVERTE && cards[i][j].isClicked(event) && nbCarteDecouverte < 2){
						cards[i][j].state = cardState.DECOUVRAGE;
						selectedCards[nbCarteDecouverte] = cards[i][j];
						nbCarteDecouverte++;
					}
				}
			}
		}
		click=true;
	}
}

function drawMessageBox(title,text){
	var width = canvasWidth * 0.33;
	var height = canvasHeight * 0.33;

	context.fillStyle="#0040ff";
	context.fillRect((canvasWidth / 2 ) - (width/2) ,(canvasHeight / 2) - (height/2) ,width,height);

//titre
	context.fillStyle="#000000";
	context.font = fontSizeInfo + "px sans-serif";
	context.fillText(title, canvasWidth / 2 - 0.33 * width  , canvasHeight / 2 - 0.40 * height);
//texte
	context.fillStyle="#000000";
	context.font = fontSizeInfo + "px sans-serif";
	context.fillText(text, canvasWidth / 2 - 0.40 * width  , canvasHeight / 2 - 0.10 * height);
}
//refresh a 30 fps


var lastTime = Date.now() ;
var msPerFrame = 30;
var timeCount = 0;
function draw(){
	requestAnimFrame(draw);

	var deltaTime = Date.now() - lastTime;
	if(timeCount > msPerFrame){
		timeCount = 0;
		//affichage du background
		context.fillStyle="#0040ff";
		context.fillRect(0,0,canvasWidth,canvasHeight);
		//on affiche l espace des cartes
		context.fillStyle="#ffffff";
		context.fillRect(0.10 * canvasWidth,0.12 * canvasHeight,0.60 * canvasWidth,0.65*canvasHeight);
		

		//draw cards
		for (i = 0; i < boardHeightSize; i++)
			for(j = 0 ; j < boardWidthSize ; j++)
				cards[i][j].drawCard();

		//check for match
		if(nbCarteDecouverte == 2){
			if(selectedCards[0].state == cardState.READY && selectedCards[1].state == cardState.READY){
				//match found
				if(selectedCards[0].id == selectedCards[1].id){
					selectedCards[0].state = cardState.DISPARISSAGE;
					selectedCards[1].state = cardState.DISPARISSAGE;
					currentPlayer.succes();
				}
				else{
					selectedCards[0].state = cardState.COUVRAGE;
					selectedCards[1].state = cardState.COUVRAGE;
					//on change de joueur
					
					switchPlayer();
					
					
					
				}
				nbCarteDecouverte = 0;
			}
		}
		//draw hourglas
		hourglass.draw();
		//on affiche les info des joueurs
		adversaire.drawAsTopPlayer(context);
		player.drawAsBottomPlayer(context);
		//on update le temps joueur couramment entrain de jouer
		currentPlayer.updateTime(msPerFrame);
	}

	timeCount += deltaTime;
	lastTime = Date.now();
}
function switchPlayer(){
	currentPlayer.endTurn();
	if(currentPlayer.equals(player))
		currentPlayer = adversaire;
	else
		currentPlayer = player;
	currentPlayer.play();
}
function gagner(){
	player.win();

}
function perdre(){
	player.lose();
	
}

