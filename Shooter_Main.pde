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
    private final float PLAYER_MOVE_MOD = 0.5;
    private final int PLAYER_SHOOT_WAIT = 10;
    private final float PLAYER_LOOK_SPEED = 4;
    
    private Shooter_Entity player;
    
    private ArrayList<Shooter_Enemy> enemies;
    private ArrayList<Shooter_Entity> entities;
    
    private final int INIT_PLAYER_DMG = 20;
    private final int INIT_PLAYER_HEALTH = 200;
    
    private ArrayList<Shooter_Item> items;
    
    private final int ENEMY_LOOK_SPEED = 2;
    private final int ENEMY_LV1_HEALTH = 50;
    private final int ENEMY_LV1_DMG = 5;
    private final int ENEMY_LV1_SHOOT_WAIT = 15;
    
    private final int ENEMY_LV2_HEALTH = 52;
    private final int ENEMY_LV2_DMG = 7;
    private final int ENEMY_LV2_SHOOT_WAIT = 15;
    
    private final int LV1_TOTAL_ENEMIES = 10;
    private final int LV2_TOTAL_ENEMIES = 10;
    
    private final int MAX_WAVES = 3; // ---------- CHANGE THIS FOR TESTING
    private final int WAVE_SIZE = 3;
    
    private final int ITEM_SPAWN_INTERVAL = 4; // this is goups of 60 frames (so seconds if fps = 60)
    private int itemSpawnTimer;
    private float itemRadius;
    
    private int currentWave;
    private Shooter_Portal portal;
    private int level;
    private Random rand;
    
    /**
    * Constructor creates player and enemies for level. Enemies are spawned based on the level number.
    */
    Shooter_Main(int level) {
        entities = new ArrayList();
        items = new ArrayList();
        enemies = new ArrayList();
        this.level = level;
        rand = new Random();
        itemRadius = (width + height) * 0.005;
        itemSpawnTimer = 0;
        
        // Calculate player radius based on screen size
        float playerRadius = (width + height) * 0.015;
        player = new Shooter_Entity(width * 0.1, height / 2, playerRadius, INIT_PLAYER_DMG, INIT_PLAYER_HEALTH, 90, PLAYER_MOVE_MOD, PLAYER_SHOOT_WAIT, PLAYER_LOOK_SPEED);
        entities.add(player);
        
        currentWave = 0;
        
        float portalRadius = (width + height) * 0.05;
        portal = new Shooter_Portal(width / 2, height / 2, portalRadius);    
    }
    
    
    /**
    * Spawns an enemy on the right hand side of the sceen, facing left.
    * Different enemies depending on level.
    */
    private void spawnEnemy() {
        PVector spawnCoords = randomiseSpawn(width - (width * 0.1), width - (width * 0.5), 0 + (height * 0.05), height - (height * 0.05));
        float spawnX = spawnCoords.x;
        float spawnY = spawnCoords.y;
        float radius = (width + height) * 0.015;
        switch(level) {
            case 1:
                enemies.add(new Shooter_Enemy(spawnX, spawnY, radius, ENEMY_LV1_DMG, ENEMY_LV1_HEALTH, 270, 0, ENEMY_LV1_SHOOT_WAIT, ENEMY_LOOK_SPEED, player));
                break;
            case 2:
                enemies.add(new Shooter_Enemy(spawnX, spawnY, radius, ENEMY_LV2_DMG, ENEMY_LV2_HEALTH, 270, 0, ENEMY_LV2_SHOOT_WAIT, ENEMY_LOOK_SPEED, player));
                break;
        }
    }
    
    /**
    * Generate random coordinates within a range.
    */
    PVector randomiseSpawn(float minX, float maxX, float minY, float maxY) {
        float randX = rand.nextFloat() * (maxX - minX) + minX;
        float randY = rand.nextFloat() * (maxY - minY) + minY;
        return new PVector(randX, randY);
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
            if (e1.getHealth() <= 0) {
                print("hit");
                if (e1.equals(player)) {
                    lost = true;
                    inShooterMode = false;
                } else {
                    enemies.remove(e1);
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
    
    /* 
    * Spawns another wave of enemies.
    */ 
    private void spawnWave() {
        currentWave++;
        for (int i = 0; i < WAVE_SIZE; i++) {
            spawnEnemy();
        }
        player.setHealth(player.getHealth() + 20);
        entities.addAll(enemies);
    }
    
    /**
    * Checks for collision between player and portal.
    */
    private boolean portalCollision() {
        return ellipseCollision(player.getX(), player.getY(), player.getRadius(), portal.getX(), portal.getY(), portal.getRadius());
    }
    
    private void spawnItem() {
        float itemX = width;
        float itemY = rand.nextFloat() * height;
        
        int type = rand.nextInt((3 - 1) + 1) + 1;
        int power = 0;
        switch(type) {
            case 1:
                // Health increase
                power = rand.nextInt((INIT_PLAYER_HEALTH - 20) + INIT_PLAYER_HEALTH);
                break;
            case 2:
                power = 2;
                break;
            case 3:
                power = rand.nextInt((20 - 2) + 2);
                break;
        }
        
        Shooter_Item item = new Shooter_Item(itemX, itemY, itemRadius, type, power);
        items.add(item);
        
    } 

    /**
    * Applies the affects of an item to the player.
    */
    private void useItem(Shooter_Item item){
        switch(item.getType()){
            case 1:
            player.setHealth(player.getHealth() + item.getPower());
            break;
            case 2:
            player.setShootWait(player.getShootWait() + item.getPower());
            break;
            case 3:
            player.setBulletDamage(player.getBulletDamage() + item.getPower());
            break;
        }
    }

    private void displayStats(){
        int textHeight = height-20;
        textSize(25);
        text("Health: " +player.getHealth(), width/2 - 30, textHeight);
        text("Shoot interval: " + player.getShootWait(), 20, textHeight);
        text("Damage: " + player.getBulletDamage(), width - 200, textHeight);
    }
    
    /** 
    * Draws everything in the shooter level.
    */
    void draw() {
        displayStats();
        handlePlayer();
        handleCollisions();
        fill(3, 45, 255);
        player.draw();
        fill(176, 4, 4);
        for (Shooter_Enemy enemy : enemies) {
            enemy.draw();
        }
        fill(255);
        
        for (int i = items.size() - 1; i >= 0; i--) {
            Shooter_Item item = items.get(i);
            if(ellipseCollision(player.getX(), player.getY(), player.getRadius(), item.getX(), item.getY(), item.getRadius())){
                useItem(item);
                items.remove(item);
            }
            else if (item.getX() <= 0) {
                items.remove(item);
            } else {
                item.draw();
            }
        }
        
        if ((frameCount % (60 * ITEM_SPAWN_INTERVAL)) == 1) {
            spawnItem();
        }

        if (currentWave < MAX_WAVES && enemies.size() == 0) {
            spawnWave();
        } else if (currentWave >= MAX_WAVES && enemies.size() == 0) {
            portal.draw();
            if (portalCollision()) {
                if(level == 1){
                inShooterMode = false;
                terramorMode = true;
                } else {
                    inShooterMode = false;
                    won = true;
                }
            }
        }
    }
}

