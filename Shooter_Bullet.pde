/**
* This class is for the shooter bullets.
* Collisions with player or enemies will remove health.
*/

class Shooter_Bullet{
    private float x;
    private float y;
    private int _width;
    private int _height;
    private final int MOVE_INCREMENT = 5;
    private PVector direction;
    
    /**
    * Creates the bullet.
    */
    Shooter_Bullet(int _width, int _height, float x, float y, PVector direction) {
        this._width = _width;
        this._height = _height;
        this.x = x;
        this.y = y;
        this.direction = direction;
    }
    
    /**
    * Updates the location of the bullet based on the aiming direction.
    */
    public void update(){
        // Have to jump through some hoops to avoid exponential speed
        PVector result = new PVector();
        result = direction.copy();
        result.mult(MOVE_INCREMENT);

        x = x + result.x;
        y = y + result.y;
    }
    
    /**
    * Reseats the position of the bullet.w
    */
    public void reset(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    /**
    * Draws the bullet.
    */
    void draw() {
        ellipse(x, y, _width, _height);
    }
}