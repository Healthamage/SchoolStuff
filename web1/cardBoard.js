var cardState = {
  COUVERTE : 0,
  DECOUVERTE: 1,
  ANIMATE_DECOUVRAGE : 2,
  ANIMATE_COUVRAGE : 3,
  ANIMATE_DISPARISSAGE: 4,
  READY : 5
};
class CardAnimations(){
	constructor(){
		this.animations = [];
		//on cree l animation de decouvrir la carte
	}
}
class Card{

  	constructor(img,text,id,x,y,width,height) {
  		this.img = img;
  		this.text = test;
  		this.id = id;
  		this.x = x;
  		this.y = y;
  		this.width = width;
  		this.height = height;
  	}
  	draw(context){

  	}
}
function Card(context,text,id){
	
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

class CardBoard {

  	constructor(context,RowCount,columnCount) {
  		
	  	this.context = context;

	  	this.cards = [];
	  	for (i = 0; i < columnCount; i++){
		card = [];
		var y = firstCardPositionY + (i * cardHeightSize);
		for(j = 0 ; j < RowCount ; j++){
			var x = firstCardPositionX + (j *cardWidthSize);
			card.push( new Card(x,y,i,i));
		}
		cards.push(card);
	}
  	}
}
