class Shooter_Player {
    private int x;
    private int y;
    private int radius;
    private boolean movingUp;
    private boolean movingDown;
    private boolean movingLeft;
    private boolean movingRight;
    private boolean shooting;
    private Shooter_Eye eye;
    private final int MOVE_INCREMENT = 4;  // Make this a percentage or something?
    private Shooter_Bullet bullet;
    
    Shooter_Player(int x, int y, int radius) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        movingUp = false;
        movingDown = false;
        movingLeft = false;
        movingRight = false; 
        bullet = new Shooter_Bullet(10,10,10,10);
        eye = new Shooter_Eye(x,y,10,radius);
    }
    
    public int getX() {
        return x;
    }
    
    public void setX(int x) {
        this.x = x;
    }
    
    public int getY() {
        return y;
    }
    
    public void setY(int y) {
        this.y = y;
    }
    
    public int getRadius() {
        return radius;
    }
    
    public void setRadius(int radius) {
        this.radius = radius;
    }
    
    public boolean isMovingUp() {
        return movingUp;
    }
    
    public void setMovingUp(boolean movingUp) {
        this.movingUp = movingUp;
    }
    
    public boolean isMovingDown() {
        return movingDown;
    }
    
    public void setMovingDown(boolean movingDown) {
        this.movingDown = movingDown;
    }
    
    public boolean isMovingLeft() {
        return movingLeft;
    }
    
    public void setMovingLeft(boolean movingLeft) {
        this.movingLeft = movingLeft;
    }
    
    public boolean isMovingRight() {
        return movingRight;
    }
    
    public void setMovingRight(boolean movingRight) {
        this.movingRight = movingRight;
    }
    
    public boolean isShooting() {
        return shooting;
    }
    
    public void setShooting(boolean shooting) {
        this.shooting = shooting;
    }


    public void lookLeft() {

    }
    
    public void lookRight(){

    }

   // move left and right will be replaced by moving the "eye"
    public void moveLeft() {
            x = x - MOVE_INCREMENT;
            eye.setParentX(x);

    }
    
    public void moveRight() {
            x = x + MOVE_INCREMENT;
            eye.setParentX(x);
    }
    
    public void moveUp() {
        if (!(y <= 0)) {
            y = y - MOVE_INCREMENT;
            eye.setParentY(y);
        }
    }
    
    public void moveDown() {
        if (!(y + radius >= height)) {
            y = y + MOVE_INCREMENT;
              eye.setParentY(y);
        }
    }

    private void drawPlayer(){
        ellipseMode(RADIUS);
        ellipse(x,y,radius, radius);
    }
    
    void draw() {
        // Either shoot and then handle movement or just move (this way they can shoot and move "simultaneously")
        if (shooting) {
            bullet.fire();
            bullet.draw();
                    ellipseMode(RADIUS);
        ellipse(x,y,radius, radius);
        } else {
            bullet.reset(x,y);
                    ellipseMode(RADIUS);
        ellipse(x,y,radius, radius);
        }  
        eye.draw();
    }
}