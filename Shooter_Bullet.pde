/**
* This class is for the shooter bullets.
* Collisions with player or enemies will remove health.
*/

class Shooter_Bullet{
    private float x;
    private float y;
    private int _width;
    private int _height;
    private final int MOVE_INCREMENT = 4;
    private boolean firing;
    
    /**
    * Creates the bullet and initialised firing to be false.
    */
    Shooter_Bullet(float x, float y, int _width, int _height) {
        this.x = x;
        this.y = y;
        this._width = _width;
        this._height = _height;
        firing = false;
    }
    
    // want the bullet to move up until it hits the top or an enemy (when they're implemented)
    /**
    * Updates the position of the bullet (should be called every frame).
    * When the bullet collides with player, enemy or window it will disappear. (still ironing this out).
    */
    public void fire() {
        if (!(y <= 0) && firing) {
            y = y - MOVE_INCREMENT;
        } else {
            reset(player.getX(), player.getY());
        }
    }
    
    /**
    * Reseats the position of the bullet.
    */
    public void reset(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    /**
    * Draws the bullet.
    */
    void draw() {
        rect(x, y, _width, _height);
    }
}