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
        PVector coords = calcCoordsFromAngle(currentAngle, parentX, parentY, parentRadius);
        x = coords.x;
        y = coords.y;
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
    * Updates the eye coordinates and draws it.
    */
    void draw() {
        PVector coords = calcCoordsFromAngle(currentAngle, parentX, parentY, parentRadius);
        x = coords.x;
        y = coords.y;
        ellipse(x,y,radius,radius);
    }
}
