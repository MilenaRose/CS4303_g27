
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
        fill(112, 3, 255);
        ellipse(x,y,radius, radius);
        fill(0);
        ellipse(x,y, radius - (radius*0.1), radius - (radius*0.1));
        fill(255);
    }
}