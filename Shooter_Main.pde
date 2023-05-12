/**
* This class handles the shooter side of the game. It is called from the main file.
* All shooter files lead here.
*/
import java.util.Iterator;

class Shooter_Main {
    
    private boolean playerMovingForward;
    private boolean playerMovingBackward;
    
    private boolean playerLookingClock; // The player is moving the eye clockwise
    private boolean playerLookingCounterClock; // The player is moving the eye counter-clockwise
    private boolean playerShooting;
    private final int PLAYER_RADIUS = 25;
    private Shooter_Entity player;
    
    private ArrayList<Shooter_Enemy> enemies;
    private final int INIT_PLAYER_DMG = 10;
    private ArrayList<Shooter_Entity> entities;
    
    /**
    * Constructor is empty for now but will likely need to level number to be passed to it.
    */
    Shooter_Main() {
        int level = 1;
        entities = new ArrayList();
        
        // Calculate player radius based on screen size
        float playerRadius = (width + height) * 0.015;
        player = new Shooter_Entity(width / 2,height / 2,playerRadius, INIT_PLAYER_DMG);
        entities.add(player);
        
        // Spawn enemies depending on level number
        enemies = new ArrayList();
        
        switch(level) {
            case 1:
                enemies.add(new Shooter_Enemy(width / 2 - 10,height,playerRadius, 10));
                break;
        }
        entities.addAll(enemies);       
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
    
    // Check for collisions between entities
    // Check each entity's bullets and then 
    
    
    /**
    * Checks whether the player's bullets have hit an enemy. If they have then that enemy loses health.
    */
    private void handleCollisions() {
        // e1 is the shooter, e2 is the shot
        for (int i = 0; i < entities.size(); i++) {
            Shooter_Entity e1 = entities.get(i);

            for (int j = 0; j < entities.size(); j++) {
                Shooter_Entity e2 = entities.get(j);
                 
                // Can't shoot yourself
                if (e1.equals(e2)) {
                    continue;
                }

                // Check whether e1 has shot e2
                Iterator<Shooter_Bullet> itr = e1.getBullets().iterator();
            
                while(itr.hasNext()) {
                    Shooter_Bullet bullet = itr.next();
                    if (ellipseCollision(bullet.getX(), bullet.getY(), bullet.getRadius(), e2.getX(), e2.getY(), e2.getRadius())) {
                        // Health is only removed if the player shoots an enemy, or an enemy shoots the player
                        if (e1.equals(player) || e2.equals(player)) {
                            e2.setHealth(e2.getHealth() - e1.getDamage());
                        } 
                        itr.remove();
                    }
                }
            }
        }
    }

    /**
    * Checks for entites with zero or less health and removes them from the game.
    * If the player loses all their health, they lose.
    */
    private void checkForDead(){

    }
    
    /**
    * Returns true if two ellipses are colliding (assumes that the ellipses are circles).
    */
    private boolean ellipseCollision(float x1, float y1, float radius1, float x2, float y2, float radius2) {
        float distance = dist(x1, y1, x2, y2);
        float radiusSum = radius1 + radius2;
        
        return distance < radiusSum;
    }
    
    /** 
    * Draws everything in the shooter level
    */
    void draw() {
        handlePlayer();
        player.draw();
        for (Shooter_Enemy enemy : enemies) {
            enemy.setShooting(true);
            enemy.draw();
        }
        handleCollisions();
    }
}
