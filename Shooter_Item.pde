
/**
* This class creates items for the shooter levels, the item type describes what atribute it affects
* power is how much it affects the atribute. Items move from right to left across the screen and cannot be picked
* up by enemies.
*/
class Shooter_Item {
    private float x;
    private float y;
    private float radius;
    private int type;
    private int power;
    private final int MOVE_SPEED = 4;
    
    /**
    * Creates an item of  given type with a given power. Types:
    * 1 = increase health
    * 2 = decrease shoot interval
    * 3 = increase bullet damage
    */
    Shooter_Item(float x, float y, float radius, int type, int power) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.type = type;
        this.power = power;
    }
    
    /**
    * Returns the x coordinate of the item.
    */
    public float getX() {
        return x;
    }
    
    /**
    * Returns the x coordinate of the item.
    */
    public float getY() {
        return y;
    }
    
    /**
    * Returns the radius of the item.
    */
    public float getRadius() {
        return radius;
    }

    /**
    * Returns the type of item:
    * 1 = increase health
    * 2 = decrease shoot interval
    * 3 = increase bullet damage
    */
    public int getType(){
        return type;
    } 

    /**
    * Returns the power of the item.
    */
    public int getPower(){
        return power;
    }

    /**
    * Moves the item across the screen from right to left.
    */
    private void update(){
        x = x - MOVE_SPEED;
    }
    
    /**
    * Draws the item and updates it's position.
    */
    void draw() {
        update();
        ellipseMode(RADIUS);
        
        switch(type){
            case 1:
            fill(3, 255, 32);
            break;
            case 2:
            fill(3, 192, 255);
            break;
            case 3:
            fill(192, 3, 255);
            break;
        }
        ellipse(x,y,radius, radius);
        fill(255);
    }

}
