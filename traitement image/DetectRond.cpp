#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/core.hpp>
#include <iostream>
#include <cstdlib>
#include <time.h>
using namespace std;
using namespace cv;
Mat src, dst;

Mat detectRond(Mat src) {
	imshow("original", src);
	//Convertion au gris
	Mat src_gray;
	cvtColor(src, src_gray, COLOR_BGR2GRAY);
	//lissage
	Mat imgBlur;
	GaussianBlur(src_gray, imgBlur, Size(9, 9), 2, 2);
	imshow("blur", imgBlur);
	//seuillage
	Mat imgThreshold;
	threshold(imgBlur, imgThreshold, 50, 255, THRESH_BINARY);
	imshow("threshold", imgThreshold);
	//detection du rond
	Mat imgFinal = src.clone();
	int radius ;
	Point center;
	//algorithme pour trouver le radius et le centre
	bool circleFound = false;
	
	Point topCircle;
	Point leftCircle;
	topCircle.x = 0;
	topCircle.y = 0;
	leftCircle.x = 0;
	leftCircle.y = 0;
	//on trouve le topCirclePoint
	int firstPointCol = 0;
	for (int i = 0; i < imgThreshold.rows; i++) {
		int step = i * imgThreshold.cols;
		for (int j = 0; j < imgThreshold.cols; j++) {
			int index = step + j;
			if (imgThreshold.data[index] == 0 && !circleFound) {
				circleFound = true;
				firstPointCol = j;
			}
			if (imgThreshold.data[index] == 255 && circleFound) {
				topCircle.x = firstPointCol + ((j - firstPointCol)/2);
				topCircle.y = i;
				circleFound = false;
			}
		}
	}
	//on trouve le leftCirclePoint
	int firstPointRow = 0;
	for (int i = 0; i < imgThreshold.cols; i++) {
		for (int j = 0; j < imgThreshold.rows; j++) {
			if (imgThreshold.at<uchar>(j,i) == 0 && !circleFound) {
				circleFound = true;
				firstPointRow = j;
			}
			if (imgThreshold.at<uchar>(j,i) == 255 && circleFound) {
				leftCircle.x = i;
				leftCircle.y = firstPointRow + ((j - firstPointRow) / 2);
				circleFound = false;
			}
		}
	}
	//on calcule le centre et le radius avec le point top et le point left
	center.x = topCircle.x;
	center.y = leftCircle.y;
	radius =  leftCircle.x - topCircle.x  ;

	//draw les information dans l image Final
	circle(imgFinal, center, radius, Scalar(0, 0, 255), 3, 8, 0);
	String info = "";
	info += "CentreX : ";
	info += to_string(center.x);
	info += " CentreY : ";
	info += to_string(center.y);
	info += " rayon : ";
	info += to_string(radius);
	putText(imgFinal,info, Point2f(0.10 *imgFinal.rows, 0.90 * imgFinal.cols), FONT_HERSHEY_PLAIN,1, Scalar(0, 0, 255, 255),1);
	line(imgFinal, {center.x - 10,center.y}, { center.x + 10,center.y }, Scalar(0, 0, 255), 2);
	line(imgFinal, { center.x,center.y - 10 }, { center.x ,center.y+10 }, Scalar(0, 0, 255), 2);
	imshow("Final", imgFinal);

	return Mat();
}
//-----------------------------------------------------//
//-----------------------------------------------------//
void detectRondOnImg(String path) {
	src = imread(path);
	if (!src.data) {
		cout << "impossible d'ouvrir l'image" << endl;
	}
	else {
		detectRond(src);
		
		while (waitKey(1) != 27) {};
	}
}
//-----------------------------------------------------//
//-----------------------------------------------------//
void detectRondOnVideo(String path) {

	VideoCapture cap(path);
	
	if (!cap.isOpened()) {
		cout << "impossible d'ouvrir le video" << endl;
	}
	else {
		time_t startTime, endTime;
		int boucleDelais = (1000/cap.get(CAP_PROP_FPS));
		cout << "boucledelais" << boucleDelais << endl;
		do {
			time(&startTime);
			if (!cap.read(src))
			{
				cout << "Repeating!\r\n";
				cap.set(CAP_PROP_POS_AVI_RATIO, 0);
			}
			if (src.data);
				detectRond(src);
			time(&endTime);
		} while (waitKey(boucleDelais - (endTime - startTime)) != 27);
	}
}
//-----------------------------------------------------//
//-----------------------------------------------------//
void detectRondOnCamera(String numeroCamera) {
	VideoCapture cap;
	if (!cap.open(stoi(numeroCamera))) {
		cout << "impossible d'ouvrir la camera" << endl;
	}
	else {
		while (waitKey(33) != 27) {
			cap >> src;
			if (src.data) {
				detectRond(src);
			}
		}
	}		
}


int main (int argc, char *argv[])
{
	if (argc == 2) {
		String type = argv[1];
		if (type == "-c") {
			detectRondOnCamera("0");
		}
	}
	else if (argc == 3){
		String type = argv[1];
		String path = argv[2];
		if (type == "-i") {
			detectRondOnImg(path);
		}
		else if (type == "-v") {
			detectRondOnVideo(path);
		}
		else if(type == "-c"){
			detectRondOnCamera(path);
		}
	}
	else {
		cout << "Nombre de paramètre incorrect" << endl;
		cout << " -i cheminDacces pour une image" << endl;
		cout << " -v cheminDacces pour un film" << endl;
		cout << " -c numeroWemcam pour une webcam" << endl;
	}
	waitKey(0);
	return 0;
}

