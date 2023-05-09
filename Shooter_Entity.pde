/**
* This class creates the shooter entity (a player or enemy) with its 'eye' and bullets.
* An entity can only move forwards and backwards relative to the position of its eye.
* An entity shoots from its eye.
*/


class Shooter_Entity {
    private float x;
    private float y;
    private int radius;
    
    private boolean movingForward;
    private boolean movingBackward;
    private boolean shooting;
    
    private Shooter_Eye eye;
    private final int MOVE_SPEED = 4;  // Make this a percentage or something? Need to make sure that bullet are faster than entity!
    private final float LOOK_SPEED = 3; // this is in degrees (should scale acording to diameter of entity).
    private final int BULLET_WIDTH = 5;
    private final int BULLET_HEIGHT = 5;
    private ArrayList<Shooter_Bullet> bullets;
    private boolean canShoot = true;
    private int canShootCounter;
    private final int SHOOT_WAIT = 10;
    
    /**
    * Creates a shooter entity, the entity is a circle so a radius is needed
    * Initialises the bullet and eye.
    */
    Shooter_Entity(float x, float y, int radius) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        movingForward = false;
        movingBackward = false;
        shooting = false;
        eye = new Shooter_Eye(x,y,radius);
        bullets = new ArrayList<Shooter_Bullet>();
    }
    
    /**
    * Returns the x coordinate of the entity.
    */
    public float getX() {
        return x;
    }
    
    /**
    * Sets the x coordinate of the entity.
    */
    public void setX(float x) {
        this.x = x;
    }
    
    /**
    * Returns the y coordinate of the entity.
    */
    public float getY() {
        return y;
    }
    
    /**
    * Sets the y coordinate of the entity.
    */
    public void setY(float y) {
        this.y = y;
    }
    
    /**
    * Returns the radius of the entity.
    */
    public int getRadius() {
        return radius;
    }
    
    /**
    * Sets the radius of the entity.
    */
    public void setRadius(int radius) {
        this.radius = radius;
    }
    
    public void setMovingForward(boolean movingForward) {
        this.movingForward = movingForward;
    }
    
    public void setMovingBackward(boolean movingBackward) {
        this.movingBackward = movingBackward;
    }
    
    /**
    * Returns whether the entity is shooting.
    */ 
    public boolean isShooting() {
        return shooting;
    }
    
    /**
    * Sets whether the entity is shooting.
    */ 
    public void setShooting(boolean shooting) {
        this.shooting = shooting;
    }
    
    /**
    * Rotate the eye clockwise
    */
    public void lookClockwise() {
        float angle = eye.getCurrentAngle();
        if (angle <= 0) {
            eye.setCurrentAngle(360 - LOOK_SPEED);
        } else{
            eye.setCurrentAngle(angle - LOOK_SPEED);
        }
    }
    
    /**
    * Rotate the eye counter-clockwise
    */
    public void lookCounterClockwise() {
        float angle = eye.getCurrentAngle();
        if (angle >= 360) {
            eye.setCurrentAngle(0 + LOOK_SPEED);
        } else{
            eye.setCurrentAngle(angle + LOOK_SPEED);
        } 
    }
    
    /**
    * Gets the direction that the entity's eye is facing
    * Direction is returned as a normalised vector.
    */
    public PVector getAimingDirection() {
        PVector result = new PVector(eye.getX() - x, eye.getY() - y);
        return result.normalize(); // Normalise to just get the direction
    }
    
    /**
    * Makes sure the entity cannot move out of bounds by checking the angle of it's eye.
    * 0 = cannot move
    * 1 = can move forward
    * 2 = can move backward
    * 3 = can move forward or backward
    */
    private int canMove() {
        float angle = eye.getCurrentAngle();
        print(angle + ": y = " + y + "\n");
        if (x <= 0) {      
            // // check if they're in the corners
            if (y >= height) {
                if (angle >= 90 && angle <= 180) {
                    return 1;
                } else if (angle >= 270 && angle <= 360) {
                    return 2;
                } else {
                    return 0;
                }
            } else if (y <= 0) {
                if (angle >= 0 && angle <= 90) {
                    return 1;
                } else if (angle >= 180 && angle <= 270) {
                    return 2;
                } else {
                    return 0;
                }
            } else {
                return (angle >= 0 && angle <= 180) ? 1 : 2;
            }
        } 
        if (x >= width) {
            if (y <= 0) {
                if (angle >= 270 && angle <= 360) {
                    return 1;
                } else if (angle >= 90 && angle <= 180) {
                    return 2;
                } else {
                    return 0;
                }
            } else if (y >= height) {
                if (angle >= 180 && angle >= 270) {
                    return 1;
                } else if (angle >= 0 && angle <= 90) {
                    return 2;
                } else {
                    return 0;
                }
            } else {
                return (angle >= 180 && angle <= 360) ? 1 : 2;
            }
        }

        // no need to check the corners again
        if(y <= 0){
            return ((angle >= 0 && angle <= 90) || (angle >= 270 && angle <= 360)) ? 1 : 2;
        } else if (y >= height){
            return (angle >= 90 && angle <= 270) ? 1 : 2;
        }
        
        return 3;
    }
    
    /**
    * Moves the entity with towards (forward == true) or away from it's eye
    * Checks for collisions before moving.
    */
    public void move(boolean forward) {
        int validDirection = canMove();
        
        if (validDirection == 0) {
            return;
        }
        
        PVector result = getAimingDirection().mult(MOVE_SPEED);

        if (forward && (validDirection == 1 || validDirection == 3)) {
            x = x + result.x;
            y = y + result.y;
        } else if (validDirection == 2 || validDirection == 3) {
            x = x - result.x;
            y = y - result.y;
        }
        eye.setParentX(x);
        eye.setParentY(y);
    }
    
    /**
    * Regulates shooting speed and adds bullets to the game.
    */
    public void fire() {
        if (shooting && canShoot) { 
            if (movingForward) {
                bullets.add(new Shooter_Bullet(BULLET_WIDTH, BULLET_HEIGHT, eye.getX(),eye.getY(),getAimingDirection(), MOVE_SPEED));
            } else if (movingBackward) {
                bullets.add(new Shooter_Bullet(BULLET_WIDTH, BULLET_HEIGHT, eye.getX(),eye.getY(),getAimingDirection(),(MOVE_SPEED * - 1)));
            } else {
                bullets.add(new Shooter_Bullet(BULLET_WIDTH, BULLET_HEIGHT, eye.getX(),eye.getY(),getAimingDirection(), 0));
            }
            canShoot = false;
            canShootCounter = 0;
        }
        if (!canShoot) {
            canShootCounter++;
            if (canShootCounter == SHOOT_WAIT) {
                canShoot = true;
            }
        }
    }
    
    
    /**
    * Updates bullets, draws entity and eye.
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
