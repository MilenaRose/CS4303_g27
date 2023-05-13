import java.util.Iterator;

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
    
    private ArrayList<Shooter_Enemy> enemies;
    private final int INIT_PLAYER_DMG = 10;
    private ArrayList<Shooter_Entity> entities;
    
    /**
    * Constructor creates player and enemies for level. Enemies are spawned based on the level number.
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
                enemies.add(new Shooter_Enemy(width / 2 - 100,height-100,playerRadius, 10, player));
                break;
        }
        entities.addAll(enemies);       
    }
    
    /*
    * Sets the player to move forward.
    */
    public void setPlayerMovingForward(boolean playerMovingForward) {
        this.playerMovingForward = playerMovingForward;
    }
    
    /*
    * Sets the player to move backwards.
    */
    public void setPlayerMovingBackward(boolean playerMovingBackward) {
        this.playerMovingBackward = playerMovingBackward;
    }

    /**
    * Sets the player to look clockwise.
    */
    public void setPlayerLookingClock(boolean playerLookingClock) {
        this.playerLookingClock = playerLookingClock;
    }
    
    /**
    * Sets the player to look counter-clockwise.
    */
    public void setPlayerLookingCounterClock(boolean playerLookingCounterClock) {
        this.playerLookingCounterClock = playerLookingCounterClock;
    }
    
    /**
    * Sets the player to shoot.
    */
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
            
        } if (playerMovingForward || playerMovingBackward) {
            player.move();
        }
    }
       
    /**
    * Handles collisons between entities and entity bullets.
    */
    private void handleCollisions() {
        // e1 is the shooter, e2 is the shot
        for (int i = 0; i < entities.size(); i++) {
            Shooter_Entity e1 = entities.get(i);

            // First check if this entity is dead, if yes then remove from list
            // Sadly it means its bullets will disappear when it dies but this could be a good thing
            if(e1.getHealth() <= 0){
                if(e1.equals(player)){
                    playerLost = true;
                }
                entities.remove(e1);
                i--;
                break;
            }
            
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
    * Draws everything in the shooter level.
    */
    void draw() {
        handlePlayer();
        handleCollisions();
        for (Shooter_Entity entity : entities){
            entity.draw();
        }
    }
}
