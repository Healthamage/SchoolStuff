class Animation(){
	constructor(imgSrc,imgRects,spriteSheetPath){
		this.nbFrame = imgRects.length();
		this.img = new Image();
		this.img.src = spriteSheetPath;
		this.currentFrame = 0;
		this.imgRects = imgRects;
	}
	next(){
		currentFrame++;
		if(currentFrame >= nbFrame)
			currentFrame = 0;
	}
	draw(context,x,y,width,height){
		rect = imgRects[currentFrame];
		context.drawImage(this.img,rect[0],rect[1],rect[2],rect[3],x,y,width,height);
	}
}