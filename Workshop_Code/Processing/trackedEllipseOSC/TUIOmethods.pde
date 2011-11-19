
// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

void updateTuioObject(TuioObject tobj) {
}

void updateTuioCursor(TuioCursor tobj) {
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tobj) {

}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tobj) {
  //println("remove cursor "+tobj.getobjsorID()+" ("+tobj.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}
