boolean inventoryMode;
boolean combatMode;
Combat battle;
Player player;
Monster monster;
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
boolean terramorMode;
String god;
int attackType;
int roundUsedByGod;
int roundUsedByPlayer;
int currentRound = 3; //this is not the actual current round, it is just a placeholder for the cooldowns.
boolean lost = false;
boolean won = false;
int attackOfMonster;
int available;
boolean deny = false;
boolean marked = false;
boolean weak = false;
boolean attacking = false;

void setup() {
    fullScreen();
    initialize();
}

void draw() {
    fill(255, 30);
    rect(0, 0, width, height);
    if (lost) {
        fill(0);
        textSize(50);
        text("You lost", width / 2, height / 2);
    } else {
        if (inventoryMode) {
            player.inventoryDisplay();
        } else if (combatMode || terramorMode) {
            if (terramorMode) {
                terramor_combat.combatDisplay();
            }
            else{
                //battle.combatDisplay();
            }
            if (attackText) {
                fill(0);
                textSize(30);
                if(deny) {
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
                println(monsterPos.x + "        " + monsterPos.y);
                pushMatrix();
                translate(monsterPos.x, monsterPos.y);
                PVector direction = playerPos.sub(monsterPos);
                projectile(direction);
                popMatrix();
        }
        }
    }
}

public void keyReleased() {
    if (key == 'i'  || key == 'I') {
        inventoryMode = !inventoryMode;
    }
    if (key == 'c' || key == 'C') {
        combatMode = !combatMode;
    } else if (key == 'T' || key == 't') {
        terramorMode = !terramorMode;
        combatMode = !combatMode;
        god = "Terramor";
    }
    if (combatMode == true && !inventoryMode) {
        if (key == '1' && !attacking) { //have to change this to a switch statement
            available = player_combat.checkPlayerAttack(1);
            if(available != -1) {
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
            if(available != -1) {
            attacking = true;
            attackAnimation = true;
            attackText = true;
            bullet = new PVector(0,0);
            attackType = 2;
            } else {
                deny = true;
            }
            //battle.attack(2);
            //attackAnimationMonster = true;
            //battle.spell();
            //battle.monsterAttack();
        } 
        else if (key == '3' && !attacking) { //decide whether the player can run away or not.
            available = player_combat.checkPlayerAttack(3);
            if(available != -1) {
            attacking = true;
            attackAnimation = true;
            attackText = true;
            bullet = new PVector(0,0);
            attackType = 3;
            } else {
                deny = true;
            }
            //battle.attack(3);
            //attackAnimationMonster = true;
            //battle.run();
            //combatMode = !combatMode;
        } 
        else if (key == '4' && !attacking) {
            available = player_combat.checkPlayerAttack(4);
            if(available != -1) {
            attacking = true;
            attackAnimation = true;
            attackText = true;
            bullet = new PVector(0,0);
            attackType = 4;
            } else {
                deny = true;
            }
            //battle.attack(4);
            //attackAnimationMonster = true;
            //battle.enchantment();
            //battle.monsterAttack();
        } else if(key == '5' && !attacking) {
            available = player_combat.checkPlayerAttack(5);
            if(available != -1) {
            attacking = true;
            attackAnimation = true;
            attackText = true;
            bullet = new PVector(0,0);
            attackType = 5;
            } else {
                deny = true;
                println("denied" + deny);
            }            
        }
    }
}

public void initialize() {
    inventoryMode = false;
    combatMode = false;
    player = new Player(width / 2, height / 2 , 50, 50);
    monster = new Monster();
    battle = new Combat(player, monster);
    attackAnimation = false;
    attackAnimationMonster = false;
    monsterPos = new PVector(width - 700, 300);
    playerPos = new PVector(370, height - 400);
    terramor = new Terramor();
    terramor_combat = new Terramor_combat(terramor, player);
    player_combat = new Player_combat(terramor, player);
    terramorMode = false;
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
        //battle.monsterAttack();
    }
}

// public void attacking(String god, int attackType) {
//     if (god.equals("Terramor")) {
//         terramor_combat.attack(attackType);
//     }
// }

public void godAttacking(String god) {
    if (god.equals("Terramor")) {
        terramor_combat.monsterAttack();
    }
}