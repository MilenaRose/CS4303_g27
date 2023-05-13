Shooter_Main shooter;
boolean inShooterMode;
import java.lang.Character;

int shooter_level;

boolean inventoryMode;
boolean terramorMode;
Player player;
boolean attackAnimation;
boolean attackAnimationMonster;
public boolean textforHit = false;
public boolean attackText;
boolean monsterAttacksText;
PVector bullet;
PVector monsterPos;
PVector playerPos;
Terramor terramor;
Terramor_combat terramor_combat;
Player_combat player_combat;

String god;
int attackType;
int roundUsedByGod;
int roundUsedByPlayer;
int currentRound = 3; //this is not the actual current round, it is just a placeholder for the cooldowns.
boolean lost;
boolean won;
int attackOfMonster;
int available;
boolean deny = false;
boolean marked = false;
boolean weak = false;
boolean attacking = false;

/**
* Initialises the game, creating the key objects.
* (Window will be fullscreen for deployment)
*/
void setup() {
    //fullScreen();
    size(800,600);
    initialise();
}

/**
* Initialises the game
*/
void initialise() {
    shooter_level = 1;
    shooter = new Shooter_Main(shooter_level);
    inShooterMode = true;
    lost = false;
    god = "terramor";
    inventoryMode = false;
    player = new Player(width / 2, height / 2 , 50, 50);
    attackAnimation = false;
    attackAnimationMonster = false;
    monsterPos = new PVector(width - 700, 300);
    playerPos = new PVector(370, height - 400);
    terramor = new Terramor();
    terramor_combat = new Terramor_combat(terramor, player);
    player_combat = new Player_combat(terramor, player);
    terramorMode = false;
    won = false;
}

/**
* Progresses to the next shooter level
*/
void nextShooterLevel() {
    shooter_level = 2;
    shooter = new Shooter_Main(shooter_level);
    inShooterMode = true;
}

public void projectile(PVector direction) {
    PVector referenceX = new PVector(width, 0);
    float theta = PVector.angleBetween(referenceX, direction);
    if ((direction.cross(referenceX)).z<0) {
        theta = 2 * PI - theta;   //calculating the theta appropriately according to the x axis
    }
    fill(0);
    ellipse(bullet.x, bullet.y, 10, 10);
    PVector velocityProjectile = new PVector(cos(theta) * (3.0 / 6), -sin(theta) * (3.0 / 6)); 
    int value = 70;
    velocityProjectile.mult(value / 7);
    bullet.add(velocityProjectile);
    if (bullet.x >= direction.x && bullet.y <= direction.y && attackAnimation) {
        attackAnimation = false;
        
        bullet.mult(0);
        //attacking(god, attackType);
        player_combat.playerAttack(attackType);
        //battle.attack(attackType);
        
        attackOfMonster = terramor_combat.getMonsterAttack();
        attackAnimationMonster = !attackAnimationMonster;
        monsterAttacksText = !monsterAttacksText;
    } else if (bullet.x <= direction.x && bullet.y >= direction.y && attackAnimationMonster && !attackAnimation) {
        if (attackOfMonster != -1) {
            bullet.mult(0);
            //battle.attack(attackType);
            godAttacking(god);
            attackType = -1;
        }
        
        attackAnimationMonster = false;
        monsterAttacksText = false;
        currentRound++;
        attacking = false;
        attackText = false;
    }
}

public void godAttacking(String god) {
    if (god.equals("Terramor")) {
        terramor_combat.monsterAttack();
    }
}

/**
* Handles key presses. Checks what state the game is in first.
* Key presses usually switch a varible from false to true.
*/
void keyPressed() {
    if (key == 'w' || key == 'W') {
        if (inShooterMode) {
            shooter.setPlayerMovingForward(true);
        }
    }
    if (key == 'a' || key == 'A') {
        if (inShooterMode) {
            shooter.setPlayerLookingCounterClock(true);
        }
    }
    if (key == 's' || key == 'S') {
        if (inShooterMode) {
            shooter.setPlayerMovingBackward(true);
        }
    }
    if (key == 'd' || key == 'D') {
        if (inShooterMode) {
            shooter.setPlayerLookingClock(true);
        }
    }
    if (key == ' ') {
        if (inShooterMode) {
            shooter.setPlayerShooting(true);
        }
    }
}

/**
* Handles keys being released.
*/
void keyReleased() {
    if (key == 'w' || key == 'W') {
        if (inShooterMode) {
            shooter.setPlayerMovingForward(false);
        }
    }
    if (key == 'a' || key == 'A') {
        if (inShooterMode) {
            shooter.setPlayerLookingCounterClock(false);
        }
    }
    if (key == 's' || key == 'S') {
        if (inShooterMode) {
            shooter.setPlayerMovingBackward(false);
        }
    }
    if (key == 'd' || key == 'D') {
        if (inShooterMode) {
            shooter.setPlayerLookingClock(false);
        }
    }
    if (key == ' ') {
        if (inShooterMode) {
            shooter.setPlayerShooting(false);
        }
    } if (key == 'r' || key == 'R') {
        if (lost || won) {
            initialise();
        } 
    } 
    if (terramorMode == true && !inventoryMode) {
        if (key == '1' && !attacking) { // have to change this to a switch statement
            available = player_combat.checkPlayerAttack(1);
            if (available != -1) {
                attacking = true;
                attackAnimation = true;
                attackText = true;
                bullet = new PVector(0,0);
                attackType = 1;
            } else {
                deny = true;
            }
        } else if (key == '2' && !attacking) {
            available = player_combat.checkPlayerAttack(2);
            if (available != -1) {
                attacking = true;
                attackAnimation = true;
                attackText = true;
                bullet = new PVector(0,0);
                attackType = 2;
            } else {
                deny = true;
            }
            
        } else if (key == '3' && !attacking) { //decide whether the player can run away or not.
            available = player_combat.checkPlayerAttack(3);
            if (available != -1) {
                attacking = true;
                attackAnimation = true;
                attackText = true;
                bullet = new PVector(0,0);
                attackType = 3;
            } else {
                deny = true;
            }
            
        } else if (key == '4' && !attacking) {
            available = player_combat.checkPlayerAttack(4);
            if (available != -1) {
                attacking = true;
                attackAnimation = true;
                attackText = true;
                bullet = new PVector(0,0);
                attackType = 4;
            } else {
                deny = true;
            }
        }
    }
}

/** 
* Returns true if two ellipses are colliding(assumes that the ellipses are circles).
*/
public boolean ellipseCollision(float x1, float y1, float radius1, float x2, float y2, float radius2) {
    float distance = dist(x1, y1, x2, y2);
    float radiusSum = radius1 + radius2;
    
    return distance < radiusSum;
}

/**
* Finds the coordinates of a point on a circle given an angle, center of the circle and radius.
*/
public PVector calcCoordsFromAngle(float angle, float offsetX, float offsetY, float radius) {
    float x = (radius * sin(radians(angle))) + offsetX;
    float y = (radius * cos(radians(angle))) + offsetY;
    return new PVector(x,y);
}

/**
* Checks what state the game is in and then calls the correct object's draw method.
*/
void draw() {
    if (lost) {
        background(0);
        textSize(50);
        text("Player Lost", width / 2 - 100, height / 2);
        text("Press R to restart", width / 2 - 150, height / 2 - 100);
    } else if (won) {
        background(0);
        textSize(50);
        text("Player won!!", width / 2 - 100, height / 2);
        text("Press R to restart", width / 2 - 150, height / 2 - 100);
    } else if (inShooterMode) {
        background(0); 
        shooter.draw();
    } else if (inventoryMode) {
        player.inventoryDisplay();
    } else if (terramorMode) {
        fill(255, 30);
        rect(0, 0, width, height);
        if (terramorMode) {
            terramor_combat.combatDisplay();
        }
        if (attackText) {
            fill(0);
            textSize(30);
            if (deny) {
                text("Move on cooldown", width / 2, height - 200);
                deny = false;
            } else {
                text("You used " + player_combat.getPlayerAttackName(attackType), width / 2, height - 200);
                //attackText = false;
            }
        } else if (monsterAttacksText) {
            fill(0);
            textSize(30);
            text(god + " used " + terramor_combat.getMonsterAttackName(), width / 2, height - 200);
            //monsterAttacksText = false;
        }
        if (attackAnimation) {
            monsterPos = new PVector(width - 700, 300);
            playerPos = new PVector(370, height - 400);
            pushMatrix();
            translate(playerPos.x, playerPos.y);
            PVector direction = monsterPos.sub(playerPos);
            projectile(direction);
            popMatrix();
        } else if (attackAnimationMonster) {
            monsterPos = new PVector(width - 700, 300);
            playerPos = new PVector(370, height - 400);
            pushMatrix();
            translate(monsterPos.x, monsterPos.y);
            PVector direction = playerPos.sub(monsterPos);
            projectile(direction);
            popMatrix();
        }
    }
} 

