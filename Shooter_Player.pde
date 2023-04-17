class Shooter_Player {
    private int x;
    private int y;
    private int _width;
    private int _height;
    private boolean movingUp;
    private boolean movingDown;
    private boolean movingLeft;
    private boolean movingRight;
    private boolean shooting;
    private final int MOVE_INCREMENT = 4;  // Make this a percentage or something?
    
    Shooter_Player(int x, int y, int _width, int _height) {
        this.x = x;
        this.y = y;
        this._width = _width;
        this._height = _height;
        movingUp = false;
        movingDown = false;
        movingLeft = false;
        movingRight = false; 
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
    
    public int getWidth() {
        return _width;
    }
    
    public void setWidth(int width) {
        this._width = width;
    }
    
    public int getHeight() {
        return _height;
    }
    
    public void setHeight(int height) {
        this._height = height;
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

    public boolean isShooting(){
        return shooting;
    }

    public void setShooting(boolean shooting){
        this.shooting = shooting;
    }
    
    public void moveLeft() {
        if (!(x <= 0)) {
            x = x - MOVE_INCREMENT;
        }
    }
    
    public void moveRight() {
        if (!(x + _width >= width)) {
            x = x + MOVE_INCREMENT;
        }
    }
    
    public void moveUp() {
        if (!(y <= 0)) {
            y = y - MOVE_INCREMENT;
        }
    }
    
    public void moveDown() {
        if (!(y + _height >= height)) {
            y = y + MOVE_INCREMENT;
        }
    }

    public void shoot(){

    }
    
    void draw() {
        if (shooting){
            shoot(); // how to move and shoot at the same time? I can only think of threads... :(
        }
        rect(x,y,_width,_height);
    }
}