/**
* This class is for the shooter bullets.
* Collisions with player or enemies will remove health.
*/

class Shooter_Bullet{
    private float x;
    private float y;
    private int _width;
    private int _height;
    // To make sure that player can never run into their own bullets:
    // bullet_speed >= player_speed
    private final int MOVE_INCREMENT = 8;
    private PVector direction;
    private int entity_speed;
    
    /**
    * Creates the bullet.
    */
    Shooter_Bullet(int _width, int _height, float x, float y, PVector direction, int entity_speed) {
        this._width = _width;
        this._height = _height;
        this.x = x;
        this.y = y;
        this.direction = direction;
        // This is the speed that the entity that fired the bullet was moving at the time of firing
        this.entity_speed = entity_speed; 
    }
    
    /**
    * Updates the location of the bullet based on the aiming direction.
    */
    public void update(){
        // Have to jump through some hoops to avoid exponential speed
        PVector result = new PVector();
        result = direction.copy();
        // Player movement speed is added to bullet speed
        // https://science.howstuffworks.com/question456.htm
        // Can be a bit weird if player is moving backwards, decreasing the bullet speed
        result.mult(MOVE_INCREMENT + entity_speed);

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