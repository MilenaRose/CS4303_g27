
/**
* This class creates the portal for the player to go from shooter mode to combat mode
*/
class Shooter_Portal {
    private float x;
    private float y;
    private float radius;
    
    Shooter_Portal(float x, float y, float radius) {
        this.x = x;
        this.y = y;
        this.radius = radius;
    }
    
    /**
    * Returns the x coordinate of the portal.
    */
    public float getX() {
        return x;
    }
    
    /**
    * Returns the x coordinate of the portal.
    */
    public float getY() {
        return y;
    }
    
    /**
    * Returns the radius of the portal.
    */
    public float getRadius() {
        return radius;
    }
    
    
    void draw() {
        ellipseMode(RADIUS);
        ellipse(x,y,radius, radius);
    }
}