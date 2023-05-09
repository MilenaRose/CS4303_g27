/**
* This class handles the shooter side of the game. It is called from the main file.
* All shooter files lead here.
*/


class Shooter_Main {
    
    private boolean playerMovingForward;
    private boolean playerMovingBackward;
    
    private boolean playerLookingClock; // The player is moving the eye clockwise
    private boolean playerLookingCounterClock; // The player is moving the eye counter-clockwise
    private boolean playerShooting;
    private final int PLAYER_RADIUS = 25;
    private Shooter_Entity player;
    
    /**
    * Constructor is empty for now but will likely need to level number to be passed to it.
    */
    Shooter_Main() {
        player = new Shooter_Entity(width / 2,height / 2,PLAYER_RADIUS);
    }
    
    
    public void setPlayerMovingForward(boolean playerMovingForward) {
        this.playerMovingForward = playerMovingForward;
    }
    
    public boolean isPlayerMovingBackward() {
        return playerMovingBackward;
    }
    
    public void setPlayerMovingBackward(boolean playerMovingBackward) {
        this.playerMovingBackward = playerMovingBackward;
    }
    
    public boolean isPlayerLookingClock() {
        return playerLookingClock;
    }
    
    public void setPlayerLookingClock(boolean playerLookingClock) {
        this.playerLookingClock = playerLookingClock;
    }
    
    public boolean isPlayerLookingCounterClock() {
        return playerLookingCounterClock;
    }
    
    public void setPlayerLookingCounterClock(boolean playerLookingCounterClock) {
        this.playerLookingCounterClock = playerLookingCounterClock;
    }
    
    public boolean isPlayerShooting() {
        return playerShooting;
    }
    
    public void setPlayerShooting(boolean playerShooting) {
        this.playerShooting = playerShooting;
    }
    
    
    /**
    * Handles movement for the player and checks for object collisions (not window collisions).
    * Movement is only permitted when there are no collisons.
    *
    * Why is this here and not in the player file? Because eventually there will be
    * other objects (enemies, items) to collide with and only the Shooter_Main should know about the 
    * other objects.
    */
    private void handlePlayer() {
        player.setMovingBackward(playerMovingBackward);
        player.setMovingForward(playerMovingForward);
        player.setShooting(playerShooting);

        if (playerLookingClock) {
            player.lookClockwise();
        } else if (playerLookingCounterClock) {
            player.lookCounterClockwise();
            
        } if (playerMovingForward) {
            player.move(true);
        } else if (playerMovingBackward) {
            player.move(false);
        }
    }
    
    /** 
    * Draws everything in the shooter level
    */
    void draw() {
        handlePlayer();
        player.draw();
    }
}
