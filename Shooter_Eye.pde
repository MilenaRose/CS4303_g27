

class Shooter_Eye{
    private float x;
    private float y;
    private int radius;
    private int parent_radius;
    private float parent_x;
    private float parent_y;

    Shooter_Eye(float x, float y, int radius, int parent_radius){
        this.radius = radius;
        this.parent_radius = parent_radius;
        this.parent_x = x;
        this.parent_y = y;
        this.x = x;
        this.y = y;
        //calcCoords(180);
    }
    
    public void setParentX(float parent_x){
        this.parent_x = parent_x;
    }

    public void setParentY(float parent_y){
        this.parent_y = parent_y;
    }

    private void calcCoords(int angle){
        // Problem, angle needs to be in radians, rather than degrees.
        x = (parent_radius * sin(angle)) + parent_x;
        y = (parent_radius * cos(angle)) + parent_y;
    }

    void draw(){
        calcCoords(180);
        ellipse(x,y,radius,radius);
    }
}