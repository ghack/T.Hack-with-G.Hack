// Import reacTIVision library
import TUIO.*;

// import osc libraries
import oscP5.*;
import netP5.*;

TuioProcessing tuioClient; // Initialise TUIO (REACTIVISION)

OscP5 oscP5; //INITIALISE OSC (TO MAX)
NetAddress myRemoteLocation;
OscMessage myMessage;

// Declare screen size
int screenSizeX = 640; 
int screenSizeY = 480;

// Declare variables to track marker
float trackedX; 
float trackedY;

// Declare once
int once;

void setup() {

  frameRate(20); // set the framerate
  smooth(); 
  size(screenSizeX, screenSizeY);  // set screen size
  background(255); // background alpha

  // initialize tuio tracking connection between processing
  tuioClient  = new TuioProcessing(this);

  //initialize osc communication with max patch
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  myMessage = new OscMessage("int");
  
  //initialise once
  once=0;
}


//main loop
void draw()
{

  background(255); //background alpha

  // tuio tracking (makes a list of markers currently tracked)
  Vector tuioObjectList = tuioClient.getTuioObjects();
  stroke(0);
  strokeWeight(10);

  // track position of Object 
  for ( int i=0 ; i<tuioObjectList.size() ; i++ ) 
  {

    TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);

    trackedX = tobj.getX() * screenSizeX; 
    trackedY = ( 1 - tobj.getY() ) * screenSizeY;

    trackedX = round(trackedX * 100.0) / 100.0;
    trackedY = round(trackedY * 100.0) / 100.0;

    point(trackedX, trackedY);
  }

  //UNCOMMENT FOR MOUSE CO-ORDINATES
  /* trackedX=mouseX;
   trackedY=mouseY;
   point(trackedX, trackedY);*/

  if ( trackedX < (screenSizeX/2) && trackedX > 0 ) {

    if ( once == 1 || once == 0 ) {
      OscMessage myMessage = new OscMessage("int");
      myMessage.add(1);
      oscP5.send(myMessage, myRemoteLocation);
      println("Left Screen");
      once=2;
    }
  } 
  else if ( trackedX > (screenSizeX/2) && trackedX < screenSizeX ) {

    if ( once == 2 || once == 0 ) {
      OscMessage myMessage = new OscMessage("int");
      myMessage.add(2);
      oscP5.send(myMessage, myRemoteLocation);
      println("Right Screen");
      once=1;
    }
  }

}

