//David,Danielle,Andy 

void mousePressed() {
    list.add(new Ball(mouseX, mouseY, color(random(255), 255, 255)));
  }
  
void keyPressed() {
  if (key == 'a') {
    p1.vy = -5;
  }
  if (key == 'z') {
    p1.vy = 5;
  }
  if (key == ';') {
    p2.vy = -5;
  }
  if (key == '.') {
    p2.vy = 5;
  }
  list.add(new Ball(mouseX, mouseY, color(random(255), 255, 255)));
}


void keyReleased() {
  if (key == 'a' && p1.vy < 0) {
    p1.vy = 0;
  }
  if (key == 'z' && p1.vy > 0) {
    p1.vy = 0;
  }
  if (key == ';' && p2.vy < 0) {
    p2.vy = 0;
  }
  if (key == '.' && p2.vy > 0) {
    p2.vy = 0;
  }
}

class Ball {
  float initialX, initialY, x, y, vx, vy, size = 10;
  color c;

  Ball(float x, float y, color c) {
    this.x = initialX = x;
    this.y = initialY = y;
    this.c = c;
    vx = 2;
    vy = 1;
  }

  void draw() {
    noStroke();
    fill(c);
    ellipse(x, y, size*2, size*2);
  }

  void reset() {
    x = initialX;
    y = initialY;
    vx = 2+random(1);
    if (random(1) < 0.5) {
      vx = -vx;
    }
    vy = random(2)-1;
  }

  void move() {
    x += vx;
    y += vy;
    if (x < size || x > width-size) {
      vx = -vx;
    }
    if (y < size || y > height-size) {
      vy = -vy;
    }
    if (x-size < p1.x + p1.w) {
      if (y > p1.y &&
        y < p1.y + p1.h) {
        vx = -vx;
      } else {
        rightScore++;
        reset();
      }
    }
    if (x+size > p2.x) {
      if (y > p2.y &&
        y < p2.y + p2.h) {
        vx = -vx;
      } else {
        leftScore++;
        reset();
      }
    }
  }
}

class Paddle {
  float x, y, vy, w = 20, h = 80; 
  color c;

  Paddle(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    vy = 0;
  }

  void draw() {
    noStroke();
    rect(x, y, w, h);
    fill(0);
  }

  void move() {
    y += vy;
    if (y < 0 || y > height-h) {
      vy = 0;
      y = constrain(y, 0, height-h);
    }
  }
}


ArrayList <Ball> list;
Paddle p1, p2;
Ball b;
int leftScore = 0;
int rightScore = 0;

void setup() {
  size(500, 500);


  colorMode(HSB);
  list = new ArrayList<Ball>();
  list.add(new Ball(width*0.5, height*0.5, color(random(255), 255, 255)));

  p1 = new Paddle(15, 200, color(255));
  p2 = new Paddle(width-30, 200, color(255));
}

void drawScores() {
  textSize(40);
  text(""+leftScore, width/2-40, 50);
  text(""+rightScore, width/2+40, 50);
}

void draw() {
  background(255);

  for (int i = 0; i < list.size(); i += 1) {
    list.get(i).draw();
    list.get(i).move();
  }

  p1.move();
  p1.draw();
  p2.move();
  p2.draw();
  drawScores();
 
}
