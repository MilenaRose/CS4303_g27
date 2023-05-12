/**
* Class for the shooter player eye. It rotates around the circumference of the player.
*/

class Shooter_Eye{
    private float x;
    private float y;
    private float radius;
    private float parentRadius;
    private float parentX;
    private float parentY;
    private float currentAngle;
    
    /**
    * Creates the eye and calcualtes its coordinates based on the parent's coordinates.
    */
    Shooter_Eye(float x, float y, float parentRadius) {
        this.parentRadius = parentRadius;
        this.parentX = x;
        this.parentY = y;
        this.x = x;
        this.y = y;
        radius = parentRadius * (0.20); 
        // Entities spawn looking up
        currentAngle = 180; 
        calcCoords(currentAngle);
    }
    
    public float getX(){
        return x;
    }

    public float getY(){
        return y;
    }

    /**
    * Method to update the parent x coordinate.
    */
    public void setParentX(float parentX) {
        this.parentX = parentX;
    }
    
    /**
    * Method to update the parent y coordinate.
    */
    public void setParentY(float parentY) {
        this.parentY = parentY;
    }

    /**
    * Returns the current angle of the eye in degrees.
    */
    public float getCurrentAngle(){
        return currentAngle;
    }

    /**
    * Sets the angle of the eye in degrees.
    */
    public void setCurrentAngle(float currentAngle){
        this.currentAngle = currentAngle;
    }
    
    /**
    * Sets the eye coordinates given an angle and based on the parent center and radius.
    */
    public void calcCoords(float angle) {
        x = (parentRadius * sin(radians(angle))) + parentX;
        y = (parentRadius * cos(radians(angle))) + parentY;
    }
    
    /**
    * Updates the eye coordinates and draws it.
    */
    void draw() {
        calcCoords(currentAngle);
        ellipse(x,y,radius,radius);
    }
}
