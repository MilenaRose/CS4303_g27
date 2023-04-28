/**
* This class handles the shooter side of the game. It is called from the main file.
* All shooter files lead here.
*/


class Shooter_Main {
    
    /**
    * Constructor is empty for now but will likely need to level number to be passed to it.
    */
    Shooter_Main() {
    }
    
    /**
    * Handles movement for the player and checks for object collisions (not window collisions).
    * Movement is only permitted when there are no collisons.
    *
    * Why is this here and not in the player file? Because eventually there will be
    * other objects (enemies, items) to collide with and only the Shooter_Main should know about the 
    * other objects.
    */
    void handleMovement() {
        if (player.isLookingClock()) {
            player.lookClockwise();
        } else if (player.isLookingCounterClock()) {
            player.lookCounterClockwise();
        } if (player.isMovingUp()) {
            player.moveUp();
        } else if (player.isMovingDown()) {
            player.moveDown();
        }
    }
    
    /**
    * Draws everything in the shooter level
    */
    void draw() {
        handleMovement();
        player.draw();
    }
}