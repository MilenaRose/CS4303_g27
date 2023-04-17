class Shooter_Main {
    
    Shooter_Main() {
    }
    
    void handleMovement() {
        if (player.isMovingLeft()) {
            player.moveLeft();
        } else if (player.isMovingRight()) {
            player.moveRight();
        } else if (player.isMovingUp()) {
            player.moveUp();
        } else if (player.isMovingDown()) {
            player.moveDown();
        }
    }
    
    void draw() {
        handleMovement();
        player.draw();
    }
}