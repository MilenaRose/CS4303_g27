/**
* This class creates the shooter player with its 'eye' and bullets.
* Player can only move forwards and backwards relative to the position of its eye.
* Player shoots from its eye.
*/


class Shooter_Player {
    private float x;
    private float y;
    private int radius;
    private boolean movingForward;
    private boolean movingBackward;
    
    private boolean lookingClock; // The player is moving the eye clockwise
    private boolean lookingCounterClock; // The player is moving the eye counter-clockwise
    
    private boolean shooting;
    private Shooter_Eye eye;
    private final int MOVE_SPEED = 4;  // Make this a percentage or something?
    private final float LOOK_SPEED = 3; // this is in degrees (should scale acording to diameter of player).
    private final int BULLET_WIDTH = 5;
    private final int BULLET_HEIGHT = 5;
    private ArrayList<Shooter_Bullet> bullets;
    private boolean canShoot = true;
    private int canShootCounter;
    private final int SHOOT_WAIT = 10;
    
    /**
    * Creates a shooter player, the player is a circle so a radius is needed
    * Initialises the bullet and eye
    */
    Shooter_Player(float x, float y, int radius) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        movingForward = false;
        movingBackward = false;
        lookingCounterClock = false;
        lookingClock = false; 
        eye = new Shooter_Eye(x,y,radius);
        bullets = new ArrayList<Shooter_Bullet>();
    }
    
    /**
    * Returns the x coordinate of the player.
    */
    public float getX() {
        return x;
    }
    
    /**
    * Sets the x coordinate of the player.
    */
    public void setX(float x) {
        this.x = x;
    }
    
    /**
    * Returns the y coordinate of the player.
    */
    public float getY() {
        return y;
    }
    
    /**
    * Sets the y coordinate of the player.
    */
    public void setY(float y) {
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
    public boolean isMovingForward() {
        return movingForward;
    }
    
    /**
    * Sets whether the player is moving up.
    */
    public void setMovingForward(boolean movingForward) {
        this.movingForward = movingForward;
    }
    
    /**
    * Returns whether the player is moving down.
    */
    public boolean isMovingBackward() {
        return movingBackward;
    }
    
    /**
    * Sets whether the player is moving down.
    */
    public void setMovingBackward(boolean movingBackward) {
        this.movingBackward = movingBackward;
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
    
    /**
    * Rotate the eye clockwise
    */
    public void lookClockwise() {
        eye.setCurrentAngle(eye.getCurrentAngle() - LOOK_SPEED);
    }
    
    /**
    * Rotate the eye counter-clockwise
    */
    public void lookCounterClockwise() {
        eye.setCurrentAngle(eye.getCurrentAngle() + LOOK_SPEED);
    }
    
    /**
    * Moves the player towards or away from the eye according to the speed.
    */
    
    public PVector getAimingDirection() {
        PVector result = new PVector(eye.getX() - x, eye.getY() - y);
        return result.normalize(); // Normalise to just get the direction
    }
    
    public void move(boolean forward) {
        PVector result = getAimingDirection().mult(MOVE_SPEED);
        
        if (forward) {
            x = x + result.x;
            y = y + result.y;
        } else {
            x = x - result.x;
            y = y - result.y;
        }
        eye.setParentX(x);
        eye.setParentY(y);
    }
    
    /**
    * Regulates shooting speed and adds bullets to the game
    */
    public void fire() {
        if (shooting == true) {
            if (canShoot == true) {
                bullets.add(new Shooter_Bullet(BULLET_WIDTH, BULLET_HEIGHT, eye.getX(),eye.getY(),getAimingDirection()));
                canShoot = false;
                canShootCounter = 0;
            }
        }
        if (canShoot == false) {
            canShootCounter++;
            if (canShootCounter == SHOOT_WAIT) {
                canShoot = true;
            }
        }
    }
    
    
    /**
    * Updates bullets, draws player and eye.
    */
    void draw() {
        fire();
        
        ellipseMode(RADIUS);
        ellipse(x,y,radius, radius);
        
        // Integrate bullets
        if (bullets.size() > 0) {
            for (int i = 0; i < bullets.size(); i++) {
                Shooter_Bullet bullet = bullets.get(i);
                bullet.update();
                bullet.draw();
            }
        }
        
        eye.draw();
    }
}
