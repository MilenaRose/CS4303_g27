Shooter_Main shooter;
boolean inShooterMode;
import java.lang.Character;

boolean playerLost;

/**
* Initialises the game, creating the key objects.
* (Window will be fullscreen for deployment)
*/
void setup() {
    //fullScreen();
    size(800,600);
    shooter = new Shooter_Main();
    inShooterMode = true;
    playerLost = false;
}

/**
* Handles key presses. Checks what state the game is in first.
* Key presses usually switch a varible from false to true.
*/
void keyPressed() {
    if (key == 'w' || key == 'W') {
        if (inShooterMode) {
            shooter.setPlayerMovingForward(true);
        }
    }
    if (key == 'a' || key == 'A') {
        if (inShooterMode) {
            shooter.setPlayerLookingCounterClock(true);
        }
    }
    if (key == 's' || key == 'S') {
        if (inShooterMode) {
            shooter.setPlayerMovingBackward(true);
        }
    }
    if (key == 'd' || key == 'D') {
        if (inShooterMode) {
            shooter.setPlayerLookingClock(true);
        }
    }
    if (key == ' ') {
        if (inShooterMode) {
            shooter.setPlayerShooting(true);
        }
    }
}

/**
* Handles keys being released.
*/
void keyReleased() {
    if (key == 'w' || key == 'W') {
        if (inShooterMode) {
            shooter.setPlayerMovingForward(false);
        }
    }
    if (key == 'a' || key == 'A') {
        if (inShooterMode) {
            shooter.setPlayerLookingCounterClock(false);
        }
    }
    if (key == 's' || key == 'S') {
        if (inShooterMode) {
            shooter.setPlayerMovingBackward(false);
        }
    }
    if (key == 'd' || key == 'D') {
        if (inShooterMode) {
            shooter.setPlayerLookingClock(false);
        }
    }
    if (key == ' ') {
        if (inShooterMode) {
            shooter.setPlayerShooting(false);
        }
    }
}

/**
* Returns true if two ellipses are colliding (assumes that the ellipses are circles).
*/
public boolean ellipseCollision(float x1, float y1, float radius1, float x2, float y2, float radius2) {
    float distance = dist(x1, y1, x2, y2);
    float radiusSum = radius1 + radius2;
    
    return distance < radiusSum;
}

/**
* Finds the coordinates of a point on a circle given an angle, center of the circle and radius.
*/
public PVector calcCoordsFromAngle(float angle, float offsetX, float offsetY, float radius) {
    float x = (radius * sin(radians(angle))) + offsetX;
    float y = (radius * cos(radians(angle))) + offsetY;
    return new PVector(x,y);
}

/**
* Checks what state the game is in and then calls the correct object's draw method.
*/
void draw() {
    if (!playerLost) {
        background(0);  
        if (inShooterMode) {
            shooter.draw();
        }
    } else {
        background(0);
        textSize(50);
        text("Player Lost", width / 2 - 100, height / 2);
    }
    
}
