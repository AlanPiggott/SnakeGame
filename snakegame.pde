import ddf.minim.*;
Minim minim;
AudioPlayer player;

ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
int w = 30, h = 30, bs = 20, dir = 2, applex = 12, appley = 10;
int[] dx = {0,0,1,-1}, dy = {1,-1,0,0};
boolean gameover = false;

int score = 0;
int hscore= 0;

void setup() {
size(600,600,P3D);
x.add(5);
y.add(5);

//play music
minim = new Minim(this);
player = minim.loadFile("snakesong.mp3");
player.play();
}

void draw() {
  background(40,235,255);
    for(int i = 0 ; i < w; i++) line(i*bs, 0, i*bs, height); //Vertical line for grid
    for(int i = 0 ; i < h; i++) line(0, i*bs, width, i*bs); //Horizontal line for grid
    for(int i = 0 ; i < x.size(); i++) {
    fill (10,200,40);
    rect(x.get(i)*bs, y.get(i)*bs, bs, bs);
    fill(0);
    textSize(25);
    text("Score: " + score, 100 ,30);
    
 }
  if(!gameover) {
    fill(255,0,0);
    rect(applex*bs, appley*bs, bs, bs);
    
 if(frameCount%5==0) { //move snake
    x.add(0,x.get(0) + dx[dir]);
    y.add(0,y.get(0) + dy[dir]);
  if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h) gameover = true;

   for(int i = 1; i < x.size(); i++) if(x.get(0) == x.get(i) &&  y.get(0) == y.get(i)) gameover = true;
   //moves apple randomely
  if(x.get(0)==applex && y.get(0)==appley) {
    applex = (int)random(0,w);
    appley = (int)random(0,h);
    score++; //add score when snake eats apple
    
}  
  else {
    x.remove(x.size()-1);
    y.remove(y.size()-1);
   }
  }
} 
  else {
    fill(0);
    textSize(30);
    text("GAME OVER. Press Space to Play Again", 20, height/2);
  if(keyPressed && key == ' ') {
    x.clear(); //Clear array list
    y.clear(); //Clear array list
    x.add(5);
    y.add(5);
     gameover = false;
     score=0;
    applex = (int)random(0,w);//random spawn when restarted
    appley = (int)random(0,h);
    

  }
  }

  fill(0);
  textSize(20);
  text("Movement: 'W' - UP, 'S' - DOWN, 'A' - LEFT, 'D' - RIGHT", 5, height); //instructions

  if (keyPressed == true) {
    int newdir = key=='s' ? 0 : (key=='w' ? 1 : (key=='d' ? 2 : (key=='a' ? 3 : -1)));
  if(newdir != -1 && (x.size() <= 1 || !(x.get(1) ==x.get(0) + dx[newdir] && y.get (1) == y.get(0) + dy[newdir]))) dir = newdir;//restart game
  }
}
