Shooter_Main shooter;
boolean inShooterMode;
import java.lang.Character;

Shooter_Player player;
final int SHOOTER_PLAYER_RADIUS = 50;


/**
* Initialises the game, creating the key objects.
* (Window will be fullscreen for deployment)
*/
void setup() {
    size(800,600);
    player = new Shooter_Player(100,100,SHOOTER_PLAYER_RADIUS);
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
            player.setMovingUp(true);
        }
    }
    if (key == 'a' || key == 'A') {
        if (inShooterMode) {
            player.setLookingCounterClock(true);
        }
    }
    if (key == 's' || key == 'S') {
        if (inShooterMode) {
            player.setMovingDown(true);
        }
    }
    if (key == 'd' || key == 'D') {
        if (inShooterMode) {
            player.setLookingClock(true);
        }
    }
    if (key == ' ') {
        if (inShooterMode) {
            player.setShooting(true);
        }
    }
}

/**
* Handles keys being released.
*/
void keyReleased() {
    if (key == 'w' || key == 'W') {
        if (inShooterMode) {
            player.setMovingUp(false);
        }
    }
    if (key == 'a' || key == 'A') {
        if (inShooterMode) {
            player.setLookingCounterClock(false);
        }
    }
    if (key == 's' || key == 'S') {
        if (inShooterMode) {
            player.setMovingDown(false);
        }
    }
    if (key == 'd' || key == 'D') {
        if (inShooterMode) {
            player.setLookingClock(false);
        }
    }
    if (key == ' ') {
        if (inShooterMode) {
            player.setShooting(false);
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
