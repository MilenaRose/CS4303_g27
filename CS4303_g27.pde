Shooter_Main shooter;
boolean inShooterMode;
import java.lang.Character;

/**
* Initialises the game, creating the key objects.
* (Window will be fullscreen for deployment)
*/
void setup() {
    //fullScreen();
    size(800,600);
    shooter = new Shooter_Main();
    inShooterMode = true;
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
* Checks what state the game is in and then calls the correct object's draw method.
*/
void draw() {
    background(0);  
    if (inShooterMode) {
        shooter.draw();
    }
    
}
