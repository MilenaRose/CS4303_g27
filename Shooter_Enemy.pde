import java.lang.Math;

class Shooter_Enemy extends Shooter_Entity {
    
    Shooter_Enemy(float x, float y, float radius, int bulletDamage) {
        super(x,y,radius, bulletDamage);

        eye.calcCoords(180);
        print(calculateAngle(eye.getX(), eye.getY()));
    }

    /**
    * Calculates the angle between the reference (bottom) of the circle and a point on the circle.
    */
    private float calculateAngle(double pointX, double pointY){
        double degrees = 0;
        double radians = Math.atan2(pointY - y, pointX - x) - Math.PI/2;
        // This means the angle has "flipped" and we have to unflip it
        if(radians > 0){
            degrees = 360;
            degrees = degrees - Math.toDegrees(radians);
        } else {
            degrees = Math.toDegrees(radians);
        }
        print(radians + "\n");

        float result = (float) degrees;

        return abs(result);
    }

    /**
    * Is given an destination angle and returns whether it is faster to move the eye
    * clockwise (true) or anti-clockwise (false) to face the destination angle.
    */
    private boolean clockOrAnti(float destAngle){
        float eyeAngle = eye.getCurrentAngle();
        if(eyeAngle > destAngle) {
            // Please read these carefully, they look similar
            if(eyeAngle - destAngle < (360 - eyeAngle) + destAngle){
                return true;
            } else {
                return false;
            }
        } else {
            if((destAngle - eyeAngle) > (360 - destAngle) + eyeAngle){
                return true;
            } else {
                return false;
            }
        }

    }
    
    @Override
    public void draw() {
        super.draw(); // This will call method from super class
        // This is where enemy will call its AI functions
        
        // Do subclass specific work here
    }
        
    }