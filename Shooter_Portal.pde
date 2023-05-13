
/**
* This class creates the portal for the player to go from shooter mode to combat mode
*/
class Shooter_Portal {
    private float x;
    private float y;
    private float radius;

    Shooter_Portal(float x, float y, float radius){
        this.x = x;
        this.y = y;
        this.radius = radius;
    }

    void draw(){
        ellipseMode(RADIUS);
        ellipse(x,y,radius, radius);
    }
}