
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Pickup> pickups = new ArrayList<Pickup>();
Player player;
boolean gameOver = false;
int score = 0;  

void setup() {
  size(800, 600);  
  startNewGame();
}

void draw() {
  background(0);  
  
  if (!gameOver) {
    
    player.display();
    
    
    for (Obstacle obs : obstacles) {
      obs.update();
      obs.display();
      
      
      if (player.collidesWith(obs)) {
        gameOver = true;
        displayGameOverScreen();
      }
    }
    
    
    for (Pickup p : pickups) {
      p.display();
      if (player.collidesWith(p)) {
        pickups.remove(p);  
        score += 100;  
      }
    }

    
    fill(255);
    textSize(20);
    textAlign(LEFT, TOP);
    text("Score: " + score, 10, 10);
    
    
    if (keyPressed) {
      if (keyCode == LEFT) {
        player.move(-10, 0);
      } else if (keyCode == RIGHT) {
        player.move(10, 0);
      } else if (keyCode == UP) {
        player.move(0, -10);
      } else if (keyCode == DOWN) {
        player.move(0, 10);
      }
    }
  }
}


class Player {
  float x, y;
  float size = 30;
  
  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    fill(0, 0, 255);  
    rect(x, y, size, size);  
    
    fill(255);  
    rect(x + 5, y + 5, 10, 10);  
    
    fill(0);  
    ellipse(x + 7, y + 25, 10, 10);  
    ellipse(x + 23, y + 25, 10, 10);  
  }
  
  void move(float dx, float dy) {
    x += dx;
    y += dy;
    
    
    y = constrain(y, 0, height - size);
  }
  
  boolean collidesWith(Obstacle obs) {
    return dist(x, y, obs.x, obs.y) < (size / 2 + obs.size / 2);
  }
  
  boolean collidesWith(Pickup p) {
    return dist(x, y, p.x, p.y) < (size / 2 + p.size / 2);
  }
}


class Obstacle {
  float x, y;
  float speedX, speedY;
  float size = 30;
  
  Obstacle(float x, float y, float speedX, float speedY) {
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
  }
  
  void update() {
    x += speedX;
    y += speedY;
    
    
    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }
  }
  
  void display() {
    fill(255, 0, 0);  
    rect(x, y, size, size);  
    
    
    fill(0);  
    ellipse(x + 7, y + 25, 8, 8); 
    ellipse(x + 23, y + 25, 8, 8);  
  }
}


class Pickup {
  float x, y;
  float size = 20;
  
  Pickup(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    fill(0, 255, 0);  
    rect(x - size / 2, y - size / 2, size, size);  
    
    fill(255, 0, 0); 
    ellipse(x, y - size / 2 - 5, 15, 15);  
    
    fill(255);  
    ellipse(x, y + size / 2 + 5, 5, 10);  
  }
}


void startNewGame() {
  player = new Player(width / 2, height / 2);  
  obstacles.clear();  
  pickups.clear();  
  gameOver = false;  
  score = 0;  
  
  
  for (int i = 0; i < 5; i++) {
    obstacles.add(new Obstacle(random(width), random(height), random(-3, 3), random(-3, 3)));
  }
  for (int i = 0; i < 3; i++) {
    pickups.add(new Pickup(random(width), random(height)));
  }
}


void displayGameOverScreen() {
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  text("THE END", width / 2, height / 2 - 40);
  
  textSize(24);
  fill(255);
  text("Your Score: " + score, width / 2, height / 2);
  text("Press 'R' to Restart", width / 2, height / 2 + 40);
}


void keyPressed() {
  if (gameOver && (key == 'r' || key == 'R')) {
    startNewGame();  
  }
}
