#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/core.hpp>
#include <iostream>
#include <cstdlib>
#include <time.h>
using namespace std;
using namespace cv;

bool continuer = true; // key 'esc' to trigger	
bool roiActive = false; // key 'r' to trigger
bool hideProcessWindow = false; //key 'a' to trigger
unsigned char minSkinDetectValue = 100;
unsigned char maxSkinDetectValue = 125;
int clickedX = 0;
int clickedY = 0;
int roiOffsetX = 0;
int roiOffsetY = 0;
int roiSizeX = 0;
int roiSizeY = 0;
int imgWidth = 0;
int imgHeight = 0;


void updateKey(char key) {
	int minRoiWidth;
	int maxRoiHeight;
	int maxRoiWidth;
	int minRoiHeight;
	switch (key) {
		case 27:
			continuer = false;
			break;
		case 'r':
			roiActive = !roiActive;
			break;
		case 't':
			hideProcessWindow = !hideProcessWindow;
			if (hideProcessWindow) {
				destroyWindow("blur");
				destroyWindow("HSV");
				destroyWindow("mask");
				destroyWindow("contour");
			}
			break;
		case '9':
			minSkinDetectValue--;
			break;
		case '0':
			minSkinDetectValue++;
			break;
		case '+':
			maxSkinDetectValue++;
			break;
		case '-':
			maxSkinDetectValue--;
			break;
		case 'w':
			roiOffsetY-=5;
			if (roiOffsetY < 0)
				roiOffsetY = 0;
			break;
		case 'a':
			roiOffsetX-=5;
			if (roiOffsetX < 0)
				roiOffsetX = 0;
			break;
		case 's':
			roiOffsetY+=5;
			break;
		case 'd':
			roiOffsetX+=5;
			break;
		case '1':
			roiSizeX -= 5;
			roiSizeY -= 5;
			minRoiWidth = ((imgWidth/2)*-1)+1;
			minRoiHeight = ((imgHeight / 2)*-1) + 1;
			if (roiSizeX < minRoiWidth)
				roiSizeX = minRoiWidth;
			if (roiSizeY < minRoiHeight)
				roiSizeY = minRoiHeight;
			break;
		case '2':
			roiSizeY += 5;
			roiSizeX += 5;
			maxRoiWidth = (imgWidth/2) - roiOffsetX;
			maxRoiHeight = (imgHeight/2) - roiOffsetY;
			if (roiSizeX > maxRoiWidth)
				roiSizeX = maxRoiWidth;
			if (roiSizeY > maxRoiHeight)
				roiSizeY = maxRoiHeight;
			break;
	}
}
///detection du rond ainsi que l'affichage de celui-ci
///parametre Image source sous forme RGB
void detectPeau(Mat src) {

	Mat hsv;
	Mat imgblur;
	Mat resultat;
	Mat mask;
	Mat contour;
	Mat roiImg;
	Rect rect;
	//on fait une ROI si activer et on blur
	if (roiActive) {
		int sizeX = ((src.size().width) / 2) + roiSizeX;
		int sizeY = ((src.size().height)/2) + roiSizeY;
		rect = Rect(roiOffsetX, roiOffsetY, sizeX, sizeY);
		roiImg = src(rect);
		blur(roiImg, imgblur, Size(3, 3));
	}
	else 
		blur(src, imgblur, Size(3, 3));
	
	//image en HSV
	cvtColor(imgblur, hsv, COLOR_RGB2HSV);
	//on fait un mask de la peau
	inRange(hsv, Scalar(minSkinDetectValue, 20, 75), Scalar(maxSkinDetectValue, 200, 255), mask);
	//on fait un mask de contour
	Mat sobelX;
	Mat sobelY;
	Sobel(mask, sobelX, CV_16S, 1, 0, 1);
	convertScaleAbs(sobelX, sobelX);
	Sobel(mask, sobelY, CV_16S, 1, 0, 1);
	convertScaleAbs(sobelY, sobelY);
	addWeighted(sobelX, 0.5, sobelY, 0.5, 0, contour);
	
	//on applique les 2 mask contour en rouge peau en bleu
	resultat = src.clone();

	if (roiActive) {
		resultat(rect).setTo(Scalar(255, 0, 0), mask);
		resultat(rect).setTo(Scalar(0, 0, 255), contour);
	}
	else {
		resultat.setTo(Scalar(255, 0, 0), mask);
		resultat.setTo(Scalar(0, 0, 255), contour);
	}
	//on inscrit les informations
	String info = "minVal : ";
	info += to_string(minSkinDetectValue);
	info += +" maxVal : ";
	info += to_string(maxSkinDetectValue);
	putText(resultat, info, Point2f(50,50), FONT_HERSHEY_PLAIN, 2, Scalar(0, 0, 255, 255), 1);
	if (roiActive)
		rectangle(resultat, rect, Scalar(0, 255, 0, 255),5);
	//on affiche les fenetres de processus
	if (!hideProcessWindow) {
		imshow("blur", imgblur);
		imshow("HSV", hsv);
		imshow("mask", mask);
		imshow("contour", contour);
	}
	imshow("Final", resultat);
	imshow("original", src);

	hsv.release();
	imgblur.release();
	resultat.release();
	mask.release();
	contour.release();
	roiImg.release();

}
///prepare l'image pour la detection a partir d'une image en argument
///parametre le path pour ouvrir l'image
void detectPeauOnImg(String path) {
	Mat src;
	src = imread(path);
	if (!src.data) {
		cout << "impossible d'ouvrir l'image" << endl;
	}
	else {
		imgWidth = src.size().width;
		imgHeight = src.size().height;
		while (continuer) { 
			detectPeau(src);
			updateKey(waitKey(33));
		}
	}
	src.release();
}
///prepare l'image pour la detection a partir d'un video
///parametre le path pour ouvrir le video
void detectPeauOnVideo(String path) {

	VideoCapture cap(path);
	Mat src;
	if (!cap.isOpened()) {
		cout << "impossible d'ouvrir le video" << endl;
	}
	else {
		time_t startTime, endTime;
		int boucleDelais = (1000 / cap.get(CAP_PROP_FPS));
		cout << "boucledelais" << boucleDelais << endl;
		do {
			time(&startTime);
			if (!cap.read(src)) {
				cout << "Repeating!\r\n";
				cap.set(CAP_PROP_POS_AVI_RATIO, 0);
			}
			if (src.data) {
				imgWidth = src.size().width;
				imgHeight = src.size().height;
				detectPeau(src);
			}
			time(&endTime);
			updateKey(waitKey(boucleDelais - (endTime - startTime)));
		} while (continuer);
	}
	src.release();
}
///prepare l'image pour la detection a partir du numero de la camera
///parametre le numero de l'image
void detectPeauOnCamera(String numeroCamera) {
	VideoCapture cap;
	Mat src;
	if (!cap.open(stoi(numeroCamera))) {
		cout << "impossible d'ouvrir la camera" << endl;
	}
	else {
		while (continuer) {
			updateKey(waitKey(33));
			cap >> src;
			if (src.data) {
				imgWidth = src.size().width;
				imgHeight = src.size().height;
				detectPeau(src);
			}
		}
	}
	src.release();
}
//----------------------------------------------------------//
//----------------------------------------------------------//
void CallBackFunc(int event, int x, int y, int flags, void* userdata)
{
	if (event == EVENT_LBUTTONDOWN){
		clickedX = x;
		clickedY = y;
	}
}
//----------------------------------------------------------//
//----------------------------------------------------------//
int main(int argc, char *argv[])
{
	bool argValid = true;
	namedWindow("HSV", WINDOW_AUTOSIZE);
	setMouseCallback("HSV", CallBackFunc, NULL);
	if (argc == 2) {
		String type = argv[1];
		if (type == "-c")
			detectPeauOnCamera("0");
		else
			argValid = false;
	}
	else if (argc == 3) {
		String type = argv[1];
		String path = argv[2];
		if (type == "-i") {
			detectPeauOnImg(path);
		}
		else if (type == "-v") {
			detectPeauOnVideo(path);
		}
		else if (type == "-c") {
			detectPeauOnCamera(path);
		}
		else
			argValid = false;
	}
	if (!argValid) {
		cout << "Argument invalid" << endl;
		cout << " -i cheminDacces pour une image" << endl;
		cout << " -v cheminDacces pour un film" << endl;
		cout << " -c numeroWemcam pour une webcam" << endl;
	}
	
	return 0;
}

