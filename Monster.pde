public class Monster {
    PVector position = new PVector(0, 0);
    float width;
    float height;
    PVector velocity = new PVector(0,0);
    int max_Velocity = 8;
    int velocityX = 0;
    int velocityY = 0;
    int max_health = 50;
    int attack = 2;
    int defense = 5;
    int health;
    int xp = 10;
    float initialX;
    float initialY;
    Monster() {
        // this.position.x = x;
        // this.position.y = y;
        // initialX = x;
        // initialY = y;
        // this.width = width;
        // this.height = height;
        health = max_health;
    }

    //     public void setVelocity() {
    //     this.velocityX = (int) random(-max_Velocity, max_Velocity);
    //     this.velocityY = (int) random(-max_Velocity, max_Velocity);
    // }

    // public void updateMonster() {
    //     velocity.x = velocityX;
    //     velocity.y = velocityY;
    //     position.add(velocity);
    //     velocity.mult(0);
    // }

    // public void reverse() {
    //     velocityX = -velocityX;
    //     velocityY = -velocityY;
    // }

    public boolean alive() {
        if(health == 0) {
            return false;
        } else {
            return true;
        }
    }

    // public PVector getCenter() {
    //     PVector center = new PVector(position.x + width/2, position.y + height/2);
    //     return center;
    // }
}