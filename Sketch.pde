boolean inventoryMode;
boolean combatMode;
Combat battle;
Player player;
Monster monster;
boolean fired;
boolean attackAnimation;
boolean attackAnimationMonster;
PVector bullet;
PVector monsterPos;
PVector playerPos;

int attackType;

void setup() {
    fullScreen();
    initialize();
}

void draw() {
    fill(255, 30);
    rect(0, 0, width, height);
    if(inventoryMode) {
        player.inventoryDisplay();
    } else if(combatMode) {
        battle.combatDisplay();
        if(attackAnimation) {
            monsterPos = new PVector(width - 700, 300);
            playerPos = new PVector(370, height - 400);
            pushMatrix();
            translate(playerPos.x, playerPos.y);
            PVector direction = monsterPos.sub(playerPos);
            projectile(direction);
            popMatrix();
        } else if(attackAnimationMonster) {
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

public void keyReleased() {
    if (key == 'i'  || key == 'I') {
        inventoryMode = !inventoryMode;
    }
    if(key == 'c' || key == 'C') {
        combatMode = !combatMode;
    }
    if(combatMode == true && !inventoryMode) {
        if(key == '1' ) { //have to change this to a switch statement
            attackAnimation = true;
            bullet = new PVector(0,0);
            attackType = 1;
            //battle.attack(1);
            //attackAnimationMonster = true;
            //if(dungeon.removeIfDead()) {
                //combatMode = !combatMode;
            //}
            //battle.monsterAttack();
        } else if(key == '2') {
            attackAnimation = true;
            battle.attack(2);
            attackAnimationMonster = true;
            //battle.spell();
            battle.monsterAttack();
        } 
        else if(key == '3') { //decide whether the player can run away or not.
            attackAnimation = true;
            battle.attack(3);
            attackAnimationMonster = true;
            //battle.run();
            combatMode = !combatMode;
        } 
        else if(key == '4' ) {
            attackAnimation = true;
            battle.attack(4);
            attackAnimationMonster = true;
            //battle.enchantment();
            battle.monsterAttack();
        }
    }
}

public void initialize() {
    inventoryMode = false;
    combatMode = false;
    player = new Player(width/2, height/2 , 50, 50);
    monster = new Monster(width/4, height/4, 50, 50);
    battle = new Combat(player, monster);
    fired = false;
    attackAnimation = false;
    attackAnimationMonster = false;
    monsterPos = new PVector(width - 700, 300);
    playerPos = new PVector(370, height - 400);
}

public void projectile(PVector direction) {
    PVector referenceX = new PVector(width, 0);
    float theta = PVector.angleBetween(referenceX, direction);
    if((direction.cross(referenceX)).z<0){
        theta = 2*PI - theta;   //calculating the theta appropriately according to the x axis
    }
    fill(0);
    ellipse(bullet.x, bullet.y, 10, 10);
    PVector velocityProjectile = new PVector(cos(theta)*(3.0/6), -sin(theta)*(3.0/6)); 
    int value = 70;
    velocityProjectile.mult(value/7);
    bullet.add(velocityProjectile);
    if(bullet.x >= direction.x && bullet.y <= direction.y && attackAnimation) {
        attackAnimation = false;
        bullet.mult(0);
        battle.attack(attackType);
        attackType = 0;
        attackAnimationMonster = !attackAnimationMonster;
    }else if(bullet.x <= direction.x && bullet.y >= direction.y && attackAnimationMonster && !attackAnimation) {
        bullet.mult(0);
        battle.attack(attackType);
        attackType = 0;
        attackAnimationMonster = false;
        battle.monsterAttack();
    }
}