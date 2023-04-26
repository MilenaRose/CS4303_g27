Shooter_Main shooter;
boolean inShooterMode;
import java.lang.Character;

Shooter_Player player;
final int SHOOTER_PLAYER_RADIUS = 50;

void setup() {
    size(800,600);
    player = new Shooter_Player(100,100,SHOOTER_PLAYER_RADIUS);
    shooter = new Shooter_Main();
    inShooterMode = true;
}

void keyPressed() {
    if (key == 'w' || key == 'W') {
        if (inShooterMode) {
            player.setMovingUp(true);
        }
    }
    if (key == 'a' || key == 'A') {
        if (inShooterMode) {
            player.setMovingLeft(true);
        }
    }
    if (key == 's' || key == 'S') {
        if (inShooterMode) {
            player.setMovingDown(true);
        }
    }
    if (key == 'd' || key == 'D') {
        if (inShooterMode) {
            player.setMovingRight(true);
        }
    }
    if (key == ' ') {
        if (inShooterMode) {
            player.setShooting(true);
        }
    }
}

void keyReleased() {
    if (key == 'w' || key == 'W') {
        if (inShooterMode) {
            player.setMovingUp(false);
        }
    }
    if (key == 'a' || key == 'A') {
        if (inShooterMode) {
            player.setMovingLeft(false);
        }
    }
    if (key == 's' || key == 'S') {
        if (inShooterMode) {
            player.setMovingDown(false);
        }
    }
    if (key == 'd' || key == 'D') {
        if (inShooterMode) {
            player.setMovingRight(false);
        }
    }
    if (key == ' ') {
        if (inShooterMode) {
            player.setShooting(false);
        }
    }
}

void draw() {
    background(0);  
    if (inShooterMode) {
        shooter.draw();
    }
    
}
