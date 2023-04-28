/**
* This class creates the shooter player with its 'eye' and bullets.
* Player can only move forwards and backwards relative to the position of its eye.
* Player shoots from its eye.
*/


class Shooter_Player {
    private int x;
    private int y;
    private int radius;
    private boolean movingUp;
    private boolean movingDown;

    private boolean lookingClock; // The player is moving the eye clockwise
    private boolean lookingCounterClock; // The player is moving the eye counter-clockwise

    private boolean shooting;
    private Shooter_Eye eye;
    private final int MOVE_INCREMENT = 4;  // Make this a percentage or something?
    private final float LOOK_INCREMENT = 3; // this is in degrees
    private Shooter_Bullet bullet;
    
    /**
    * Creates a shooter player, the player is a circle so a radius is needed
    * Initialises the bullet and eye
    */
    Shooter_Player(int x, int y, int radius) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        movingUp = false;
        movingDown = false;
        lookingCounterClock = false;
        lookingClock = false; 
        bullet = new Shooter_Bullet(10,10,10,10);
        eye = new Shooter_Eye(x,y,10,radius);
    }
    
    /**
    * Returns the x coordinate of the player.
    */
    public int getX() {
        return x;
    }
    
    /**
    * Sets the x coordinate of the player.
    */
    public void setX(int x) {
        this.x = x;
    }
    
    /**
    * Returns the y coordinate of the player.
    */
    public int getY() {
        return y;
    }
    
    /**
    * Sets the y coordinate of the player.
    */
    public void setY(int y) {
        this.y = y;
    }
    
    /**
    * Returns the radius of the player.
    */
    public int getRadius() {
        return radius;
    }
    
    /**
    * Sets the radius of the player.
    */
    public void setRadius(int radius) {
        this.radius = radius;
    }
    
    /**
    * Returns whether the player is moving up.
    */
    public boolean isMovingUp() {
        return movingUp;
    }
    
    /**
    * Sets whether the player is moving up.
    */
    public void setMovingUp(boolean movingUp) {
        this.movingUp = movingUp;
    }
    
    /**
    * Returns whether the player is moving down.
    */
    public boolean isMovingDown() {
        return movingDown;
    }
    
    /**
    * Sets whether the player is moving down.
    */
    public void setMovingDown(boolean movingDown) {
        this.movingDown = movingDown;
    }
    
    /**
    * Returns whether the player is moving down.
    */
    public boolean isLookingCounterClock() {
        return lookingCounterClock;
    }
    
    /**
    * Sets whether the player is moving left.
    */
    public void setLookingCounterClock(boolean lookingCounterClock) {
        this.lookingCounterClock = lookingCounterClock;
    }
    
    /**
    * Returns whether the player is moving right.
    */
    public boolean isLookingClock() {
        return lookingClock;
    }
    
    /**
    * Sets whether the player is moving right.
    */
    public void setLookingClock(boolean lookingClock) {
        this.lookingClock = lookingClock;
    }
    
    /**
    * Returns whether the player is shooting.
    */ 
    public boolean isShooting() {
        return shooting;
    }
    
    /**
    * Sets whether the player is shooting.
    */ 
    public void setShooting(boolean shooting) {
        this.shooting = shooting;
    }
    
    
    // These are stubs for now but will replace move left and right with rotating the eye.
    // Rotate eye clockwise
    public void lookClockwise() {
        eye.setCurrentAngle(eye.getCurrentAngle() - LOOK_INCREMENT);
    }

    // Rotate eye counter-clockwise
    public void lookCounterClockwise() {
        eye.setCurrentAngle(eye.getCurrentAngle() + LOOK_INCREMENT);
    }
        
    /**
    * Moves the player up according to a move increment, barring window collisions.
    */
    public void moveUp() {
        if (!(y <= 0)) {
            y = y - MOVE_INCREMENT;
            eye.setParentY(y);
        }
    }
    
    /**
    * Moves the player up according to a down increment, barring window collisions.
    */
    public void moveDown() {
        if (!(y + radius >= height)) {
            y = y + MOVE_INCREMENT;
            eye.setParentY(y);
        }
    }
    
    /**
    * Updates bullets if firing, draws player and eye.
    */
    void draw() {
        // Either shoot and then handle movement or just move (this way they can shoot and move "simultaneously")
        if (shooting) {
            bullet.fire();
            bullet.draw();
            ellipseMode(RADIUS);
            ellipse(x,y,radius, radius);
        } else {
            bullet.reset(x,y);
            ellipseMode(RADIUS);
            ellipse(x,y,radius, radius);
        }  
        eye.draw();
    }
}