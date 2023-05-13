import java.util.Iterator;

/**
* This class creates the shooter entity (a player or enemy) with its 'eye' and bullets.
* An entity can only move forwards and backwards relative to the position of its eye.
* An entity shoots from its eye.
*/

class Shooter_Entity {
    protected float y;
    protected float radius;
    protected float x;
    
    protected boolean movingForward;
    protected boolean movingBackward;
    protected boolean shooting;
    
    protected Shooter_Eye eye;
    protected float moveSpeed; 
    protected final float LOOK_SPEED = 4; // this is in degrees
    protected float bulletSize;
    protected ArrayList<Shooter_Bullet> bullets;
    protected boolean canShoot = true;
    protected int canShootCounter;
    protected int shootWait; // How long to wait until the next bullet is fired.
    protected int initialHealth;
    
    protected int currentHealth;
    protected int bulletDamage;
    
    /**
    * Creates a shooter entity, the entity is a circle so a radius is needed
    * Initialises the bullet and eye.
    */
    Shooter_Entity(float x, float y, float radius, int bulletDamage, int health, float spawnAngle, float moveModifier, int shootWait) {
        // calulate size of bullet based off entity radius
        bulletSize = radius * 0.2;
        this.shootWait = shootWait;
        
        // calculate move speed based off radius
        moveSpeed = radius * 0.15 + moveModifier;
        
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.bulletDamage = bulletDamage;
        movingForward = false;
        movingBackward = false;
        shooting = false;
        initialHealth = health;
        currentHealth = initialHealth;
        
        eye = new Shooter_Eye(x,y,radius, spawnAngle);
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
    public float getRadius() {
        return radius;
    }
    
    /**
    * Sets the radius of the entity.
    */
    public void setRadius(int radius) {
        this.radius = radius;
    }
    
    /**
    * Sets whether the entity is moving forward (towards eye).
    */
    public void setMovingForward(boolean movingForward) {
        this.movingForward = movingForward;
    }
    
    /**
    * Sets whether the entity is moving backwards (away from eye).
    */
    public void setMovingBackward(boolean movingBackward) {
        this.movingBackward = movingBackward;
    }

    public int getShootWait(){
        return shootWait;
    }

    public void setShootWait(int shootWait){
        this.shootWait = shootWait;
    }

    public int getBulletDamage(){
        return bulletDamage;
    } 

    public void setBulletDamage(int bulletDamage){
        this.bulletDamage = bulletDamage;
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
    * Returns the array of this entity's bullets.
    */
    public ArrayList<Shooter_Bullet> getBullets() {
        return bullets;
    }
    
    /**
    * Removes the given bullet from the array.
    */
    public void removeBullet(Shooter_Bullet bullet) {
        bullets.remove(bullet);
    }
    
    /**
    * Returns the current health of the entity.
    */
    public int getHealth() {
        return currentHealth;
    }
    
    /**
    * Sets the current health of the entity.
    */
    public void setHealth(int health) {
        currentHealth = health;
    }

    /**
    * Returns the bullet damage of the entity.
    */
    public int getDamage(){
        return bulletDamage;
    }

    /**
    * Sets the bullet damage of the entity.
    */
    public void setDamage(int damage){
        bulletDamage = damage;
    }
    
    /**
    * Rotates the eye clockwise.
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
    * Rotates the eye counter-clockwise.
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
    * Gets the direction that the entity's eye is facing.
    * Direction is returned as a normalised vector.
    */
    public PVector getAimingDirection() {
        PVector result = new PVector(eye.getX() - x, eye.getY() - y);
        return result.normalize(); // Normalise to just get the direction
    }
    
    /**
    * Makes sure the entity cannot move out of bounds by checking the angle of its eye.
    * 0 = cannot move
    * 1 = can move forward
    * 2 = can move backward
    * 3 = can move forward or backward
    */
    protected int canMove() {
        float angle = eye.getCurrentAngle();
        if (x <= 0) {      
            // check if they're in the corners
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
                return(angle >= 0 && angle <= 180) ? 1 : 2;
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
                return(angle >= 180 && angle <= 360) ? 1 : 2;
            }
        }
        
        // No need to check the corners again
        if (y <= 0) {
            return((angle >= 0 && angle <= 90) || (angle >= 270 && angle <= 360)) ? 1 : 2;
        } else if (y >= height) {
            return(angle >= 90 && angle <= 270) ? 1 : 2;
        }
        
        return 3;
    }
    
    /**
    * Moves the entity forward (towards its eye) or backwards (away from it's eye).
    * Checks for collisions before moving.
    */
    public void move() {
        int validDirection = canMove();
        
        if (validDirection == 0) {
            return;
        }
        
        PVector result = getAimingDirection().mult(moveSpeed);
        
        if (movingForward && (validDirection == 1 || validDirection == 3)) {
            x = x + result.x;
            y = y + result.y;
        } else if (movingBackward && (validDirection == 2 || validDirection == 3)) {
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
                bullets.add(new Shooter_Bullet(bulletSize, eye.getX(), eye.getY(),getAimingDirection(), moveSpeed, bulletDamage));
            } else if (movingBackward) {
                bullets.add(new Shooter_Bullet(bulletSize, eye.getX(), eye.getY(),getAimingDirection(),(moveSpeed * - 1), bulletDamage));
            } else {
                bullets.add(new Shooter_Bullet(bulletSize, eye.getX(), eye.getY(),getAimingDirection(), 0, bulletDamage));
            }
            canShoot = false;
            canShootCounter = 0;
        }
        if (!canShoot) {
            canShootCounter++;
            if (canShootCounter == shootWait) {
                canShoot = true;
            }
        }
    }
    
    /**
    * Updates bullets, draws entity and eye.
    */
    public void draw() {
        fire();
        
        ellipseMode(RADIUS);
        ellipse(x,y,radius, radius);
        
        // Integrate bullets
        Iterator<Shooter_Bullet> itr = bullets.iterator();
        while(itr.hasNext()) {
            Shooter_Bullet bullet = itr.next();
            // If the bullet is out of bounds, remove it
            if (bullet.getX() <= 0 || bullet.getX() >= width || bullet.getY() <= 0 || bullet.getY() >= height) {
                itr.remove();
            }
            bullet.update();
            bullet.draw();
        }
        eye.draw();
    }
}
