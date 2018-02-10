import gifAnimation.*;

int[] center = new int[2];

float toRadians = PI / 180.0;
float RAD = 6.28;

int totalObj = 25;
Obj1[][] objs = new Obj1[totalObj][totalObj];

GifMaker gifExport = new GifMaker(this, "sine-circles.gif");

void setup(){
  frameRate(12);

  width = 600;
  height = 600;
  size(600, 600);
  smooth();
  background(255);
  center[0] = width/2;
  center[1] = height/2;
  
  gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);        // make it an "endless" animation
    gifExport.setTransparent(0,0,0);  // black is transparent

  
  for(int i=0;i < 25; i++){
    float inc = sin( scaleRange(RAD, i, 25)) * 0.1;
    for(int j=0; j < 25; j++){
       objs[j][i] = new Obj1(j*25,i*25, scaleRange( RAD, j*25, width) + i*25+inc, 0.15);
    }
  }
}

void draw(){
  background(255);
  
  for(int i=0;i < 25; i++){
    for(int j=0; j < 25; j++){
       objs[j][i].render();
    }
  }
  
   gifExport.setDelay(1);
   gifExport.addFrame();
}

void mousePressed() {
    gifExport.finish();          // write file
}

class Obj1{
  float x = 0.0;
  float y = 0.0;
  float rad = 0.0;
  float inc = 0.1;
  
  final static float maxSize = 20;
  
  Obj1(float tx, float ty, float tr, float ti){
    x = tx;
    y = ty;
    rad = tr; 
    inc = ti;
  }
  
  void render(){
    rad += inc;
    float val = Obj1.maxSize * sin( rad );
    pushMatrix();
    translate(this.x, this.y);
    ellipse(0,0,val, val);
    //rect(0,0,val/1.5, val/1.5);
    popMatrix();
  }
}

float scaleRange(float rangeEnd, float val, float valMax){
  return (val/valMax) * rangeEnd;
}

float sigmoid(float t){
  return 1/(1+exp(-t));
}