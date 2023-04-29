/**
* Class for the shooter player eye. It rotates around the circumference of the player.
*/

class Shooter_Eye{
    private float x;
    private float y;
    private float radius;
    private int parent_radius;
    private float parent_x;
    private float parent_y;
    private float current_angle;
    
    /**
    * Creates the eye and calcualtes its coordinates based on the player coordinates (parent).
    */
    Shooter_Eye(float x, float y, int parent_radius) {
        this.parent_radius = parent_radius;
        this.parent_x = x;
        this.parent_y = y;
        this.x = x;
        this.y = y;
        // Scaling the eye according to the parent's radius should give a constant turning speed on all window sizes.
        radius = parent_radius * (0.20); 
        // The player is initialised looking up.
        current_angle = 180; 
        calcCoords(current_angle);
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
    public void setParentX(float parent_x) {
        this.parent_x = parent_x;
    }
    
    /**
    * Method to update the parent y coordinate.
    */
    public void setParentY(float parent_y) {
        this.parent_y = parent_y;
    }

    /**
    * Returns the current angle of the eye in degrees.
    */
    public float getCurrentAngle(){
        return current_angle;
    }

    /**
    * Sets the angle of the eye in degrees.
    */
    public void setCurrentAngle(float current_angle){
        this.current_angle = current_angle;
    }
    
    /**
    * Sets the eye coordinates given an angle and based on the parent center and radius.
    */
    private void calcCoords(float angle) {
        x = (parent_radius * sin(radians(angle))) + parent_x;
        y = (parent_radius * cos(radians(angle))) + parent_y;
    }
    
    /**
    * Updates the eye coordinates and draws it.
    */
    void draw() {
        calcCoords(current_angle);
        ellipse(x,y,radius,radius);
    }
}