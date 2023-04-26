class Shooter_Bullet{
    private int x;
    private int y;
    private int _width;
    private int _height;
    private final int MOVE_INCREMENT = 4;
    private boolean firing;
    Shooter_Bullet(int x, int y, int _width, int _height) {
        this.x = x;
        this.y = y;
        this._width = _width;
        this._height = _height;
        firing = false;
    }

// want the bullet to move up until it hits the top or an enemy (when they're implemented)
    public void fire(){
        if(!(y <= 0 ) && firing){
            y = y - MOVE_INCREMENT;
        } else {
            reset(player.getX(), player.getY());
        }
    }

    public void reset(int x, int y){
        this.x = x;
        this.y = y;
    }
    
    void draw() {
        rect(x, y, _width, _height);
    }
}