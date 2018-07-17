//Jingfei Tan
//State Variables Assignment: Letter Typing Game
//March 13, 2017

//Description:
// - Welcome to the Letter Typing Game!
// - There are 3 states: the start screen, the game screen, and end screen (which loops back to the start screen)
// - The objective of the game is to see how many letters you can type in 60 seconds!

//Extra for Experts:
// - used StringLists to create a list of the alphabet, then shuffled it everytime for a new letter
// - used a timer to control the length of the game with millis()

//State the variables
StringList inventory;
int state, points, startTime, time;
float randR, randG, randB;

//Background, assign values to variables
void setup () {
  size(800, 800);
  state = 0;
  points = 0;
  randR = 255;
  randG = 255;
  randB = 255;
  time = 0;
  startTime -= 1;
  
  //Adding each letter of the alphabet to the list of strings
  //I really want to find a more efficient way to do this...perhaps the answer is arrays?
  inventory = new StringList();
  inventory.append("a");
  inventory.append("b");
  inventory.append("c");
  inventory.append("d");
  inventory.append("e");
  inventory.append("f");
  inventory.append("g");
  inventory.append("h");
  inventory.append("i");
  inventory.append("j");
  inventory.append("k");
  inventory.append("l");
  inventory.append("m");
  inventory.append("n");
  inventory.append("o");
  inventory.append("p");
  inventory.append("q");
  inventory.append("r");
  inventory.append("s");
  inventory.append("t");
  inventory.append("u");
  inventory.append("v");
  inventory.append("w");
  inventory.append("x");
  inventory.append("y");
  inventory.append("z");
  inventory.shuffle();
}

//Draw loop, which checks for what state is currently running
//State 0 = start screen, state 1 = game screen, state 2 = end screen
void draw() {
  background(0);
  if (state == 0) {
    startScreen();
  }
  if (state == 1) {
    playGame();
  }
  if (state == 2) {
    gameOver();
  }
}

//Draws the start screen
void startScreen() {
  background(0); 
  
  //This makes the button interactive with the mouse
  if (((width/2-125 < mouseX) && (mouseX < width/2+125)) && (550 < mouseY) && ( mouseY < 700)) {
    fill(73, 215, 91);
  } else {
    fill(113, 255, 131);
  }
  rect(width/2-125, 550, 250, 150);
  
  fill(255);
  textSize(80);
  textAlign(LEFT);
  text("Welcome to Letter Typer!", 100, 100, 600, 400);
  textSize(100);
  text("Start", width/2-110, 660);
  textSize(30);
  text("How to play:", 100, 400); 
  text("See how many points you can score in 60 s!", 100, 450);
  text("Just type the letter you see on screen!", 100, 500);
}

//Draw the game screen
void playGame() {
  background(randR, randG, randB);
  fill(0);
  textSize(200);
  textAlign(CENTER, CENTER);
  
  //Using the list of strings, "inventory", first I get the first string, which would be randomized because it is shuffled
  //Then using .charAt(), I turn it into a character
  String item = inventory.get(0);
  char character = item.charAt(0);
  text(character, width/2, height/2);
  textSize(60);
  
  //Shows user how many points they currently have
  text("Points:" + str(points), 200, 100);

  //Shows the user the timer
  if (startTime != -1) {
    if (time == 60) {
      state = 2;
      startTime = 0;
    }
    time = (millis()-startTime)/1000;
  } else {
    time = 0;
  }
  text("Timer:" + time, 500, 700);
  
  //If the user presses the key that matches the character on screen, the background colors will change, as well will the letter, by randomizing it again with .shuffle()
  if ((keyPressed) && (key == character)) {
    randR = random(100, 255);
    randG = random(100, 255);
    randB = random(100, 255);
    inventory.shuffle();
    points ++;
    println(points);
  }
}

//Draw the end screen
void gameOver() {
  textAlign(CENTER);
  background(255, 171, 67);
  
  //Button to loop back to the start screen
  if (((width/2-125 < mouseX) && (mouseX < width/2+125)) && (550 < mouseY) && ( mouseY < 700)) {
    fill(73, 215, 91);
  } else {
    fill(113, 255, 131);
  }
  rect(width/2-125, 550, 250, 150);
  
  fill(0);
  textSize(100);
  text("Good Job!", 100, 100, 600, 400);
  textSize(40);
  
  //Tells user how many points they scored
  text("You scored: " + str(points) + " points!", 100, 300, 600, 400);
  text("Play again", 100, 600, 600, 400);
} 

//The start screen and end screen both change when the button, which is conveniently in the same position, is pressed 
void mouseClicked() {
  if (((width/2-125 < mouseX) && (mouseX < width/2+125)) && (550 < mouseY) && ( mouseY < 700)) {
    if (state == 0) {
      state = 1;
      startTime = millis();
      points = 0;
    }
    if (state == 2) {
      state = 0;
    }
  }
}