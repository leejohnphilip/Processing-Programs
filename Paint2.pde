//  Paint Program (version 2.0)
//  by: John Philip "JP" Lee
//  Last update: Feb 19, 2017; 6:41 pm

//  FEATURES: 
//  - Custom RGB color selection
//  - Eraser tool
//  - Reset canvas option
//  - Save most updated sketch to custom location

//  TO FIX: 
//  - Scalers move if mouse is dragged (from anywhere); should only move when clicked THEN dragged at initial positions of scalers.

//  TO ADD:
//  - Save multiple sketches
//  - Better-themed GUI


color current=0;
float weight=1;
PImage eraser;
PImage reset;
PImage erasercursor;
PImage pencil;
PImage imgsave;
PShape redscalebar;
PShape greenscalebar;
PShape bluescalebar;
int redval=0;
int greenval=0;
int blueval=0;
int scalerREDx=70;
int scalerGREENx=70;
int scalerBLUEx=70;
boolean erasermode=false;
boolean drawmode=true;
boolean overSave=false;
boolean drawAbility=false;
String dir;


void setup() {
  size (900, 600);
  background (255);
  
  eraser=loadImage("eraser.png");
  reset=loadImage("reset.png");
  erasercursor=loadImage("erasercursor.png");
  pencil=loadImage("pencil.png");
  
  redscalebar= createShape(RECT, 70, 20, 255, 12);
  redscalebar.setFill(color(255,0,0));
  
  greenscalebar= createShape(RECT, 70, 50, 255, 12);
  greenscalebar.setFill(color(0,255,0));
  
  bluescalebar= createShape(RECT, 70, 80, 255, 12);
  bluescalebar.setFill(color(0,0,255));
}


void mouseClicked() {
    if (660<=mouseX && mouseX<=740 && 15<=mouseY && mouseY<=95){  // click eraser
      erasermode=true;
      drawmode=false;
      current= color(255);
      weight=20;
      println("clicked white");
  } else if (340<=mouseX && mouseX<=420 && 15<=mouseY && mouseY<=95){  // click preview pallette
      erasermode=false;
      drawmode=true;
      weight=1;
      current=color(redval,greenval,blueval);
  } else if (471<=mouseX && mouseX<=581 && 77<=mouseY && mouseY<=105){  // click to save sketch
      drawAbility=false;
      imgsave=get(30,120,840,450);
      selectFolder("Select a location to save your sketch: ", "folderSelection");
      println("Saved File");
  } else if (760<=mouseX && mouseX<=860 && 15<=mouseY && mouseY<=95){  // click reset
      erasermode=false;
      drawmode=true;
      redval=0;
      greenval=0;
      blueval=0;
      scalerREDx=70;
      scalerGREENx=70;
      scalerBLUEx=70;
      
      background (255);
      
      noStroke();
    
      fill (111);  // top bar
      rect(0, 0, 900, 120);
      
      fill (111);  // left bar
      rect(0, 120, 30, 480);
      
      fill (111);  // right bar
      rect(870,120,30,480);
      
      fill(111);  // bottom bar
      rect(30,570,870,30);
      
      stroke(0);
      strokeWeight(1);
      
      fill (color(redval, greenval, blueval));   // preview palette
      ellipse(380, 55, 80, 80);
     
      
      noFill(); 
      stroke(255);
      strokeWeight(2);
      
      image(eraser,672,25, 60, 60);  // eraser icon
      ellipse(700, 55, 80, 80);
      
      image(reset, 772, 25, 60, 60); // reset icon
      ellipse(800, 55, 80, 80);
      
      rect(471,23,110,35);  // mode display
      rect (471,77,110,28);  // save icon
        
      fill(0);
      textSize(16);
      text("R", 40, 36);
      text("G", 40, 66);
      text("B", 41, 96);
      
      shape(redscalebar);
      shape(greenscalebar);
      shape(bluescalebar);

      fill(255);
      stroke(0);
      strokeWeight(1);
      rect(scalerREDx,15,7,22);
      rect(scalerGREENx,45,7,22);
      rect(scalerBLUEx,75,7,22);
      
      current= color(0);
      weight=1;
      println("reset canvas");
  }
}

void folderSelection (File selection){  // for getting directory of folder selected to save sketch
  if (selection==null){
    return;
} else
  dir=selection.getPath()+"\\";
  imgsave.save(dir+"Untitled Sketch.png");
}

void draw() {
  
  noStroke();

  fill (111);  // top bar
  rect(0, 0, 900, 120);
  
  fill (111);  // left bar
  rect(0, 120, 30, 480);
  
  fill (111);  // right bar
  rect(870,120,30,480);
  
  fill(111);  // bottom bar
  rect(30,570,870,30);
  
  stroke(0);
  strokeWeight(1);
  
  fill (color(redval, greenval, blueval));   // preview palette
  ellipse(380, 55, 80, 80);
 
  
  noFill(); 
  stroke(255);
  strokeWeight(2);
  
  image(eraser,672,25, 60, 60);  // eraser icon
  ellipse(700, 55, 80, 80);
  
  image(reset, 772, 25, 60, 60); // reset icon
  ellipse(800, 55, 80, 80);
  
  rect(471,23,110,35);  // mode display
  rect (471,77,110,28);  // save icon
  
  fill(255);
  textSize(16);
  text("R", 40, 36);
  text("G", 40, 66);
  text("B", 41, 96);
  textSize(14);
  text("Save Sketch", 487, 96);
  textSize(16);
  
  shape(redscalebar);
  shape(greenscalebar);
  shape(bluescalebar);
  
  fill(255);
  stroke(0);
  strokeWeight(1);
  rect(scalerREDx,15,7,22);
  rect(scalerGREENx,45,7,22);
  rect(scalerBLUEx,75,7,22);

  if ((mouseY>120) && (mouseY<570) && (mouseX>30) && (mouseX<870)){  // fixes bug when cursor coming from off screen and accidentally draws on program
    drawAbility=true;
  } else {
    drawAbility=false;
    }
    
  if (mousePressed && (mouseY>120) && (mouseY<570) && (mouseX>30) && (mouseX<870) && drawAbility==true){  // for drawing lines on canvas, only when cursor is within canvas
    strokeWeight(weight);
    stroke(current);
    line (pmouseX, pmouseY, mouseX, mouseY);
  }
  
  if (erasermode==true && 471<=mouseX && mouseX<=581 && 77<=mouseY && mouseY<=105){   // if mode is ERASE; hover on save icon
    drawAbility=false;
    overSave=true;
    cursor(HAND);
    text("Mode: Erase", 480, 46);
  } else if (drawmode==true && 471<=mouseX && mouseX<=581 && 77<=mouseY && mouseY<=105){  // if mode is DRAW; hover on save icon
    drawAbility=false;
    overSave=true;
    cursor(HAND);
    text("Mode: Draw", 480, 46);
  } else if (erasermode==true && mouseX>=345){  // if mode is ERASE; not hover on save icon; not hover on all scaler bars
    drawAbility=false;
    cursor(erasercursor,0,0);
    text("Mode: Erase", 480, 46);
  } else if (erasermode==true){  // if mode is ERASE; not hover on save icon; hover on all scaler bars
    drawAbility=false;
    cursor (HAND);
    text("Mode: Erase", 480, 46);
  } else if (30<=mouseX && mouseX<=345 && 0<=mouseY && mouseY<=57){  // if mode is DRAW; not hover on save icon; hover on red scaler bar
    drawAbility=false;
    text("Mode: Draw", 480, 46);
    cursor(HAND);
  } else if (30<=mouseX && mouseX<=345 && 30<=mouseY && mouseY<=87){  // if mode is DRAW; not hover on save icon; hover on green scaler bar
    drawAbility=false;
    text("Mode: Draw", 480, 46);
    cursor(HAND);
  } else if (30<=mouseX && mouseX<=345 && 60<=mouseY && mouseY<=117){  // if mode is DRAW; not hover on save icon; hover on blue scaler bar
    drawAbility=false;
    text("Mode: Draw", 480, 46);
    cursor(HAND);
  } else {  
    text("Mode: Draw", 480, 46);
    cursor(pencil,0,0);
  }
 
  
}


void mouseDragged(){
   if (mousePressed==true && 70<=mouseX && mouseX<=325 && 15<=mouseY && mouseY<=37){  // red value will be according to mouseY when dragged
     erasermode=false;
     drawmode=true;
     scalerREDx=mouseX;
     redval=mouseX-70;
     current=color(redval,greenval,blueval);
     weight=1;
     println("Color set to red value is: ", redval);
  } else if (mousePressed==true && 70<=mouseX && mouseX<=325 && 45<=mouseY && mouseY<=67){  // green value will be according to mouseY when dragged
     erasermode=false;
     drawmode=true;
     scalerGREENx=mouseX;
     greenval=mouseX-70;
     current=color(redval,greenval,blueval);
     weight=1;
     println("Color set to green value is: ", greenval);
  } else if (mousePressed==true && 70<=mouseX && mouseX<=325 && 75<=mouseY && mouseY<=97){  // blue value will be according to mouseY when dragged
     erasermode=false;
     drawmode=true;
     scalerBLUEx=mouseX;
     blueval=mouseX-70;
     current=color(redval,greenval,blueval);
     weight=1;
     println("Color set to blue value is: ", blueval);
  } 
}