/**
* This class is for the shooter bullets.
* Collisions with player or enemies will remove health.
*/

class Shooter_Bullet{
    private float x;
    private float y;
    private float radius;
    // To make sure that player can never run into their own bullets:
    // bullet_speed >= player_speed * 2
    private float bulletSpeed;
    private PVector direction;
    private float entitySpeed;
    private int bulletDamage;
    
    /**
    * Creates the bullet.
    */
    Shooter_Bullet(float radius, float x, float y, PVector direction, float entitySpeed, int bulletDamage) {
        this.radius = radius;
        this.x = x;
        this.y = y;
        this.direction = direction;
        // This is the speed that the entity that fired the bullet was moving at the time of firing
        this.entitySpeed = entitySpeed; 
        this.bulletDamage = bulletDamage;
        // Bullet speed is based off width, which is based off entity size which is based off window size
        bulletSpeed = radius * 3;
    }

    /**
    * Returns the x coordinate of the bullet.
    */
    public float getX(){
        return x;
    }

    /**
    * Returns the y coordinate of the bullet.
    */
    public float getY(){
        return y;
    }

    /**
    * Returns the radius of the bullet.
    */
    public float getRadius(){
        return radius;
    }

    /**
    * Returns the damage of the bullet.
    */
    public int getDamage(){
        return bulletDamage;
    }
    
    /**
    * Updates the location of the bullet based on the aiming direction.
    */
    public void update() {
        PVector result = new PVector();
        result = direction.copy();
        // Player movement speed is added to bullet speed
        // https://science.howstuffworks.com/question456.htm
        result.mult(bulletSpeed + entitySpeed);

        x = x + result.x;
        y = y + result.y;
    }
    
    /**
    * Draws the bullet.
    */
    void draw() {
        ellipseMode(RADIUS);
        ellipse(x, y, radius, radius);
    }
}
