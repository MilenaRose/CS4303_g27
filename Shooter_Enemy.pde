import java.lang.Math;

class Shooter_Enemy extends Shooter_Entity {
    private float targetX;
    private float targetY;
    private float targetAngle;
    private Shooter_Entity player;
    private float detectionRadius; // this is the radius that bullets and the player are detected.
    private int clearCounter; // determines how many times to move forward when stuck.
    private final int CLEAR_WAIT = 20;
    private boolean stuck;
    
    Shooter_Enemy(float x, float y, float radius, int bulletDamage, Shooter_Entity player) {
        super(x,y,radius, bulletDamage);
        
        detectionRadius = radius * 5;
        stuck = false;
        clearCounter = 0;
        
        // Enemies need to know player information.
        this.player = player;
    }
    
    /**
    * Calculates the angle between (bottom) of the circle and a given point.
    * Angle will always be between 0 and 360. Going anti-clockwise.
    */
    private float calculateAngle(double pointX, double pointY) {
        double degrees = 0;
        // Have to move the reference point from right to bottom.
        double radians = Math.atan2(pointY - y, pointX - x) - Math.PI / 2;
        
        // If the radians are negative the angle has "flipped" and we have to unflip it.
        if (radians > 0) {
            degrees = 360;
            degrees = degrees - Math.toDegrees(radians);
        } else {
            degrees = Math.toDegrees(radians);
        }
        
        float result = (float) degrees;
        
        return abs(result);
    }
    
    /**
    * Is given an destination angle and returns whether it is faster to move the eye
    * clockwise (true) or anti-clockwise (false) to face the destination angle.
    */
    private boolean smallerClockwise(float destAngle) {
        float eyeAngle = eye.getCurrentAngle();
        if (eyeAngle > destAngle) {
            // Please read these carefully, they look similar
            if (eyeAngle - destAngle < (360 - eyeAngle) + destAngle) {
                return true;
            } else {
                return false;
            }
        } else {
            if ((destAngle - eyeAngle) > (360 - destAngle) + eyeAngle) {
                return true;
            } else {
                return false;
            }
        }
    }
    
    // generally want to move backwards when fleeing from player, forwards away from bullets
    // forwards when chasing player.
    private void orientToTarget(boolean faceTowards) {
        if (faceTowards) {
            if (smallerClockwise(targetAngle)) {
                lookClockwise();
            } else {
                lookCounterClockwise();
            }
        } else {
            if (!smallerClockwise(targetAngle)) {
                lookClockwise();
            } else {
                lookCounterClockwise();
            }
        }
    }
    
    /**
    * Moves the enemy forwards if chasing and backwards if fleeing.
    */
    private void chase(boolean chase) {
        if (chase) {
            movingForward = true;
        }  else {
            movingBackward = true;
        }
        move();
        movingForward = false;
        movingBackward = false;
    }
    
    private void setTarget(float targetX, float targetY, float targetAngle) {
        this.targetX = x;
        this.targetY = y;
        this.targetAngle = targetAngle;
    }

    // The enemy shoots at the player if they are facing towards them
    private void shootAtPlayer(){
        float playerAngle = calculateAngle(player.getX(), player.getY());
        if(eye.getCurrentAngle() >= playerAngle - 20|| eye.getCurrentAngle() <= playerAngle + 20){
            // Make it more random whether or not they will shoot:

            shooting = true;
        } else {
            print(eye.getCurrentAngle() + "   " + (eye.getCurrentAngle() >= playerAngle + 20) + "    ");
            print(playerAngle + "\n");
            shooting = false;
        }
    }
    
    
    private void decide() {

        // Check if you're stuck in the edge if so then move towards player
        if (canMove() != 3) {
            print(clearCounter);
            stuck = true;
            clearCounter++;
            setTarget(player.getX(), player.getY(), calculateAngle(player.getX(), player.getY()));
            orientToTarget(true);
            chase(true);
            return;
        } else if (clearCounter < CLEAR_WAIT && stuck) {
            clearCounter++;
            setTarget(player.getX(), player.getY(), calculateAngle(player.getX(), player.getY()));
            orientToTarget(true);
            chase(true);
            return;
        } else {
            stuck = false;
            clearCounter = 0;
        }
        
        
        // Check whether there are any bullets heading towards the enemy
        for (Shooter_Bullet bullet : player.getBullets()) {
            if (ellipseCollision(bullet.getX(), bullet.getY(), bullet.getRadius(), x, y, detectionRadius)) {
                setTarget(bullet.getX(), bullet.getY(), calculateAngle(bullet.getX(), bullet.getY()));
                orientToTarget(true);
                chase(false);
                return;
            }
        }

        // Check if player is within detection radius, if yes then flee (unless in a corner).
        if (ellipseCollision(player.getX(), player.getY(), player.getRadius(), x, y, detectionRadius)){
            setTarget(player.getX(), player.getY(), calculateAngle(player.getX(), player.getY()));
            orientToTarget(true);
            chase(false);
            return;
        }

        // Check current health - if below 50% then run away from player
        if(currentHealth < (INITAL_HEALTH /2)){
            setTarget(player.getX(), player.getY(), calculateAngle(player.getX(), player.getY()));
            orientToTarget(false);
            chase(false);
            return;
        }

        // Otherwise maybe turn towards player or move in a random direction
        // Random number generation
        setTarget(player.getX(), player.getY(), calculateAngle(player.getX(), player.getY()));
        orientToTarget(true);
    }    
    
    @Override
    public void draw() {
        super.draw(); // This will call method from super class
        // This is where enemy will call its AI functions
        decide();
        shootAtPlayer();
    }
    
}
